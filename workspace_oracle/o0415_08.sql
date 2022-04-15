-- 2022/04/15(금) 8일차 수업

/* 
★★★
< 뷰(View)의 정의 >
- 가상 테이블
- 하나 이상의 테이블이나 다른 뷰를 이용하여 생성되는 가상 테이블
- 실질적으로 데이터를 저장하지 않고, 뷰를 정의할 때 기술한 쿼리문만 저장됨.
- 뷰를 통해서 데이터를 추가/수정/삭제를 하면 뷰가 사용하는 기본 테이블에 반영되고,
- 기본 테이블에서 데이터를 추가/수정/삭제를 하면 뷰에도 반영됨.

< 뷰의 종류 >
1. 단순 뷰(simple view) : 하나의 기본 테이블로부터 생성된 뷰
- DML 명령을 사용할 수 있음.
- 단순 뷰의 DML 명령은 기본 테이블 반영됨.

2. 복합 뷰(complex view) : 두 개 이상의 기본 테이블로부터 생성된 뷰
- 무결성 제약조건, group by 절, 표현식 등의 유무의 따라 DML 명령이 제한적으로 사용됨.
- 복합 뷰는 distinct, group by, 그룹함수, rownum을 사용할 수 없음.
*/

-- 문제3) emp01, dept01 테이블로부터 사번, 사원명, 업무, 연봉, 부서번호, 부서명을 
-- 입사일이 1981년인 사원의 정보를 보여주는 뷰를 생성하시오. (조인은 equi join을 사용)
-- 해결시간: 3분, 뷰 이름 : v_emp06

UPDATE VIEW v_emp06 AS
SELECT eno, ename, job, salary, hiredate, e.dno, dname, hiredate
FROM emp01 e, dept01 d
WHERE e.dno = d.dno 
AND SUBSTR(hiredate, 1, 2) = '81';

SELECT * FROM v_emp06;

-- 데이터 사전을 통해 뷰의 정보를 확인
SELECT * FROM user_views;

/*
< 뷰를 사용하는 장점 >
1. 보안 - 뷰를 사용하여 중요한 데이터의 접근을 막을 수 있다.
2. 사용의 편의성 - 사용자게에 필요한 데이터만 접근하게 하여 편의성을 높일 수 있음.

< 뷰를 사용할 때 발현되는 몇가지 문제 >

*/

-- v_emp01 뷰에 데이터를 추가
--> 문제점: SALESMAN을 조회하는 뷰인데, CLERK이 기본테이블 입력되고 있는 점.
INSERT INTO v_emp02 (eno, ename, dno, job) VALUES (9000, 'KIM', 10, 'CLEARK');
SELECT * FROM v_emp02;
SELECT * FROM emp01;

-- 2.2 부서별 연봉합계, 연봉평균을 보여주는 뷰를 생성하시오.
CREATE VIEW v_emp_dno
AS SELECT dno, SUM(salary), AVG(salary)
FROM emp01
GROUP BY dno;
-- 에러: ORA-00998: must have this expression with a column alias
--> 해결책 : 뷰를 생성할 때 그룹함수를 컬럼에 사용할 때는 alias를 사용함.

CREATE VIEW v_emp_dno
AS
SELECT dno, SUM(salary) "sum", AVG(salary) "avg"
FROM emp01
GROUP BY dno;

SELECT * FROM v_emp_dno;

-- v_emp_dno 뷰에 데이터를 삽입
INSERT INTO v_emp_dno VALUES(10, 1000, 1500);
--> ORA-01733: virtual column not allowed here
--> 에러: 그룹함수를 사용한 뷰에는 값을 삽입할 수 없음.

-- 3. 뷰의 제거
-- 형식 : DROP VIEW 뷰이름;
SELECT * FROM user_view;
DROP VIEW v_emp_dno;

-- 4. 뷰를 생성
-- CREATE VIEW 뷰이름 : 뷰 이름에 해당하는 뷰가 없을 때는 뷰를 생성, 있다면 에러
-- CREATE OR REPLACE VIEW 뷰이름 : 뷰 이름에 해당하는 뷰가 없을 때는 새로 생성, 있다면 삭제하고 새로 생성 

DESC v_emp_dno;

CREATE VIEW v_emp_dno
AS
SELECT eno, ename, job, dno FROM emp01;

DESC v_emp_dno;

-- 4-2. 강제로 뷰를 생성 : 뷰를 생성할 수 없는 상황임에도 강제로 뷰를 생성
-- CREATE OR REPLACE FORCE 뷰이
CREATE VIEW v_notable
AS
SELECT * FROM member;
-- 에러: ORA-00942: table or view does not exist

CREATE OR REPLACE FORCE VIEW v_notable
AS
SELECT * FROM member;
-- 오류: ORA-00942: table or view does not exist
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM user_views; -- 확인 
DESC v_notable;           -- 확인불가, 에러 
SELECT * FROM v_notable;  -- 확인불가, 에러 

-- < 뷰를 사용할 때 발현되는 몇가지 문제 >
SELECT * FROM user_views;

-- 5-1. with check option 사용
-- 뷰에서 보여지는 범위 내에서만 insert와 update가 가능하도록 명령
-- delete는 제외.

-- emp01 테이블로부터 eno, ename, dno, job의 업무가 'MANAGER'인 데이터를 보여주는 뷰를 생성하시오.
CREATE OR REPLACE VIEW v_emp01
AS SELECT eno, ename, dno, job FROM emp01 WHERE job = 'MANAGER';

SELECT * FROM user_views;
DESC v_emp01;
SELECT * FROM v_emp01;

-- 뷰를 통해 데이터 삽입 : MANAGER를 검색하는 뷰이니 MANAGER를 삽입하는 것은 합당 
INSERT INTO v_emp01 VALUES(9001, 'KIM', 10, 'MANAGER');
COMMIT;
SELECT * FROM v_emp01; -- 뷰에서 확인
SELECT * FROM emp01; -- 기본 테이블에서 확인 

-- 뷰를 통해 데이터 삽입 : MANAGER를 검색하는 뷰인데 SALESMAN을 삽입하는 것은 합당하지 않음 
INSERT INTO v_emp01 VALUES(9002, 'LEE', 20, 'SALESMAN'); -- 성공
COMMIT;
SELECT * FROM v_emp01; -- 뷰에서 확인 : 보이지 않음
SELECT * FROM emp01; -- 기본 테이블에서 확인

-- 위의 문제를 해결 : MANAGER를 검색하는 뷰라면 이 뷰를 통해서는 MANAGER 데이터만 추가/수정이 가능하도록 함, 삭제는 안됨.
-- 다시 뷰를 생성
CREATE OR REPLACE VIEW v_emp01
AS SELECT eno, ename, dno, job FROM emp01 WHERE job = 'MANAGER'
WITH CHECK OPTION;

DESC v_emp01;
SELECT * FROM v_emp01;
SELECT * FROM user_views;

-- 확인: 'MANAGER' 데이터를 삽입
INSERT INTO v_emp01 VALUES(9003, 'CHOI', 30, 'MANAGER');
COMMIT;
SELECT * FROM v_emp01;
SELECT * FROM emp01;

-- 확인: 'SALESMAN' 데이터를 삽입 --> 실패 
INSERT INTO v_emp01 VALUES(9004, 'PARK', 10, 'SALESMAN');
--> 오류: ORA-01402: view WITH CHECK OPTOION where-clause violation

-- 데이터 수정 확인: 'MANAGER' 데이터인 9001번의 이름을 수정 --> 성공 
UPDATE v_emp01 
SET ename = 'SONG'
WHERE eno = 9001;
COMMIT;

SELECT * FROM emp01;
SELECT * FROM v_emp01;

-- 데이터 수정 확인 : 'MANAGER' 데이터인 9001번의 업무를 'CLERK'으로 수정 --> 오류 
-- 'MANAGER'인 데이터의 업무는 수정 불가 
UPDATE v_emp01 
SET job = 'CLERK'
WHERE eno = 9001;
--> 오류: ORA-01402: view WITH CHECK OPTION where-clause violation 

SELECT * FROM emp01;
SELECT * FROM v_emp01;

----------
-- 5-2. with read only
-- 읽기만 가능한 뷰를 만들 때 사용, 읽기 전용 뷰 생성
-- 뷰를 통해서는 select만 가능하고, inset/update/delete는 사용이 불가함.
CREATE OR REPLACE v_emp01
AS SELECT eno, ename, job, dno FROM emp01 WHERE job = 'MANAGER'
WITH READ ONLY;

DESC v_emp01;
SELECT * FROM v_emp01;
SELECT * FROM user_views;

-- 데이터 삽입
INSERT INTO v)emp01 VALUES(1001, 'AAA', 10, 'MANAGER');
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

-- 데이터 수정
UPDATE v_emp01
SET ename= 'BBB'
WHERE eno = 9001;
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

-- 데이터 삭제 
DELETE FROM v_emp01 WHERE eno = 9001;
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

-------
/*
< 시퀀스 (Sequence) >
-- 테이블 내에서 자동으로 생성되고, 연속되는 유일한 숫자(정수)
-- 테이블에서 일련번호, 제품번호 등 유일하고 자동으로 생성되는 번호에 사용,

< 시퀀스 생성 형식 >
CREATE SEQUENCE 시퀀스명
START WITH 숫자 -- 시작 숫자
INCREMENT BY 숫자 -- 증가치
MINVALUE 숫자 -- 최소값 설정, 기본값은 1
MAXVALUE 숫자 -- 최대값 설정, 기본값은 10의 27승
CYCLE OR NOCYCLE -- 최대값까지 값이 증가했을 때 cycle이면 최소값부터 다시 시작, nocycle 이면 에러 발생 
CACHE OR NOCACHE -- 시퀀스를 관리하는 캐시값을 설정, 기본값은 20

< nextval, currval >
- nextval: 시퀀스의 다음 값을 설정
- currval: 시퀀스의 현재 값을 확인

< nextval, currval을 사용할 수 있는 경우 >
- 서브쿼리가 아닌 select문
- insert문의 select문
- insert문의 values절 --> 가장 많이 사용 (nextval)
- update 문의 set절

< nextval, currval을 사용할 수 없는 경우 >
- view의 select절
- distinct가 있는 select문
- group by, having, order by절이 있는 select
*/


SELECT * FROM user_views;
SELECT * FROM user_tables;

-- 데이터 없이 emp01, dept01 테이블 생성(복사)
CREATE TABLE emp01 AS SELECT * FROM employee WHERE 0 = 1;
CREATE TABLE dept01 AS SELECT * FROM department WHERE 0 = 1;

-- 테이블 확인
DESC emp01;
SELECT * FROM emp01;
DESC dept01;
SELECT * FROM dept01;

-- 시퀀스 생성
-- 1부터 1씩 증가하는 시퀀스 생성
CREATE SEQUENCE test01_seq START WITH 1 INCREMENT BY 1;

-- 시퀀스 확인
SELECT * FROM user_sequences;

SELECT test01_seq.NEXTVAL FROM dual; -- 다음 시퀀스
SELECT test01_seq.CURRVAL FROM dual; -- 현재 시퀀스 확인 

----------
-- 데이터 없이 emp01, dept01 테이블 생성(복사)
CREATE TABLE emp01 AS SELECT * FROM employee WHERE 0 = 1;
CREATE TABLE dept01 AS SELECT * FROM department WHERE 0 = 1;

-- 테이블 확인
DESC emp01;
SELECT * FROM emp01;
DESC dept01;
SELECT * FROM dept01;

-- emp01 테이블에서 사용할 시퀀스 생성
-- 사번은 1001번 부터 1씩 증가하는 시퀀스를 생성하여, 사원 테이블에 적용
CREATE SEQUENCE emp01_seq START WITH 1001 INCREMENT BY 1;

-- emp01 테이블 데이터를 추가할 때 시퀀스 사용
INSERT INTO emp01(eno, ename) VALUES(emp01_seq.NEXTVAL, 'person4');
COMMIT;
SELECT * FROM emp01;

-- dept01 테이블에서 사용할 시퀀스 생성
-- 부서번호는 10번 부터 10씩 증가하는 시퀀스를 생성하여, 부서 테이블에 적용
CREATE SEQUENCE dept01_seq START WITH 10 INCREMENT BY 10;

-- dept01 테이블에 데이터를 추가할 때 시퀀스를 사용
INSERT INTO dept01(dno, dname, loc) VALUES(dept01_seq.NEXTVAL, 'P3', 'L3');
COMMIT;
SELECT * FROM dept01;

SELECT * FROM user_sequences;

-- < 2. 시퀀스 변경 >
-- START WITH 는 변경 불가: 유일한 번호를 생성에 위배되기 때문 
ALTER SEQUENCE emp01_seq INCREMENT BY 10;
SELECT * FROM user_sequences;

INSERT INTO emp01(eno, ename) VALUES(emp01_seq.NEXTVAL, 'TOM1');
COMMIT;
SELECT * FROM emp01;

ALTER SEQUENCE dept01_seq MAXVALUE 100;
SELECT * FROM user_sequences;
INSERT INTO dept01(dno, dname, loc) VALUES(dept01_seq.NEXTVAL, 'P10', 'L10');
--> 오류: ORA-01438: value larger than specified presicion allowed for this column
COMMIT;
SELECT * FROM dept01;

SELECT dept01_seq.CURRVAL FROM dual;

-- < 3. 시퀀스 제거 >
DROP SEQUENCE emp01_seq;
SELECT * FROM user_sequences;

----------
/*
< 인덱스 (index) >
- 검색 속도의 향상을 위해서 사용하는 기능
- 직접 인덱스를 생성할 수도 있고, 데이터의 무결성 확인을 위해 수시로 사용하는 기본키는 인덱스가 자동으로 생성됨.

*/

CREATE TABLE emp01 AS SELECT * FROM employee;
CREATE TABLE dept01 AS SELECT * FROM department;

SELECT * FROM user_constraints WHERE table_name IN('EMP01', 'DEPT01');

-- 제약 조건 추가 
ALTER TABLE dept01 MODIFY dno CONSTRAINT dept01_dno_pk PRIMARY KEY;
ALTER TABLE emp01 MODIFY eno CONSTRAINT emp01_eno_pk PRIMARY KEY;
ALTER TABLE emp01 MODIFY dno CONSTRAINT emp01_dno_fk REFERENCES dept01;

-- 제약 조건 확인 : PK에 인덱스가 생성되어 있는 것을 확
SELECT * FROM user_constraints WHERE table_name IN('EMP01', 'DEPT01');

-- 인덱스 확인: user_ind_columns
SELECT * FROM user_ind_columns WHERE table_name IN('EMP01', 'DEPT01');


