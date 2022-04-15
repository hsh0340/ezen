-- 2022/04/14(목) 7일차 수업 

-- 2. 데이터 수정 : UPDATE 테이블명 SET 수정할 필드와 값 WHERE 조건 
-- 2-1. dept01 테이블에서 10번 부서의 부서명을 'PROGRAMMING' 으로 변경하시오.
UPDATE dept01
SET dname = 'PROGRAMMING'
WHERE dno = 10;

SELECT * FROM dept01;
COMMIT;

-- 2-2. dept01 테이블에서 20번 부서의 부서명을 'MARKETING', 지역명을 'TEXAS'로 수정하시오.
UPDATE dept01
SET dname = 'MARKETING', loc = 'TEXAS'
WHERE dno = 20;

SELECT * FROM dept01;
COMMIT;

-- 2-3. WHERE절 생략하면 모든 데이터의 내용이 변경
UPDATE dept01
SET dname = 'TF';

SELECT * FROM dept01;
COMMIT;

-- 2-4. SET절에서는 서브쿼리를 사용.
-- dept01 테이블의 30번 부서의 부서명을 department 테이블의 30번 부서의 부서명으로 수정하시오.
UPDATE dept01
SET dname = (SELECT dname FROM department WHERE dno = 30)
WHERE dno = 30;

SELECT * FROM dept01;
COMMIT;

-- 2-5. SET절에서 서브쿼리를 여러개를 사용 가능
-- dept01 테이블의 20번 부서의 부서명과 지역명을 department 테이블의 20번 부서의 부서명과 지역명으로 수정하시오.
UPDATE dept01
SET dname = (SELECT dname FROM department WHERE dno = 20),
    loc = (SELECT loc FROM department WHERE dno = 20)
WHERE dno = 20;

UPDATE dept01
SET (dname, loc) = (SELECT dname, loc FROM department WHERE dno = 20)
WHERE dno = 20;

SELECT * FROM dept01;
COMMIT;

-- 3. 데이터 삭제
-- DELETE FROM 테이블명 WHERE 조건

-- 3-1. dept01 테이블에서 부서번호 40인 테이블을 삭제하시오.
DELETE FROM dept01 WHERE dno = 40;

SELECT * FROM dept01;
COMMIT;

-- 3-2. where절에서 서브쿼리를 사용
-- dept01 테이블에서 department 테이블의 'SALES' 부서명에 해당하는 부서번호의 데이터를 삭제하시오.
DELETE FROM dept01
WHERE dno = (SELECT dno FROM department WHERE dname = 'SALES');

SELECT * FROM dept01;
COMMIT;

-- 3-3. WHERE절을 생략하면 모든 데이터를 삭제
DELETE FROM dept01;

SELECT * FROM dept01;
COMMIT;

/*
트랜잭션 (transaction)
- 데이터 처리(추가, 수정, 삭제)의 과정을 논리적으로 하나의 작업 단위로 처리하는 것.
- ex) 계좌 이체의 예
- 두 계좌 사이에서 일정한 금액을 이체하려면, 출금 금액과 입금 금액이 동일해야 함.
- 이 두가지 작업은 반드시 함께 처리되거나, 취소되어야 함.
- 출금은 되었으나, 입금이 되지 않았다면 데이터의 일관성을 유지하지 못하므로, 이런 일은 발생하면 안됨.
- 이러한 문제를 막기 위해서 트랜잭션 처리를 함.
- All or Nothing
-- 여러개의 작업이 하나의 논리적인 작업을 이루고 있을 때 모두 다 실행되거나,
-- 중간에 문제가 생겼을 때는 아예 전체를 취소하는 것을 말함.

SQL에서 트랜잭션을 처리하는 명령
- COMMIT, ROLLBACK
*/

INSERT INTO dept01 SELECT * FROM department;
SELECT * FROM dept01;
COMMIT; -- 확정(영구저장)

DELETE FROM dept01 WHERE dno = 40;
SELECT * FROM dept01;
ROLLBACK; -- 취소

/*
★★★★★
제약조건(constraint)

데이터 무결성 제약조건(Data Integrity Constraint)
- 테이블에 유효하지 않은(부적절한) 데이터가 입력되는 것을 방지하기 위해서
- 테이블을 생성할 때 각 컬럼에 정의하는 여러가지의 규칙(제약조건)을 정하는 것
- 데이터를 추가/수정/삭제할 때 정의된 제약조건이 적용됨.

제약조건의 종류
1. not null : 컬럼에 null을 포함하지 않도록 하는 제약조건
2. unique : 컬럼에 유일한 값을 갖도록 하는 제약조건, NULL은 유일한 값으로 인정
3. primary key : 기본키, 주키, PK, not null과 unique 제약조건을 모두 만족하는 제약조건
- 다른 행과 구분되는 유일한 키이면서 not null인 데이터를 입력하도록 하는 제약조건 
4. foreign key : 외래키, FK
5. check: 컬럼의 값이 특정한 범위 값을 가지도록 하는 제약조건
# default값 : 아무런 값을 입력하지 않았을 때 디폴트로 설정한 값이 입력

< foreign key와 참조 무결성 >
1. 참조 무결성
- 자식 테이블이 부모 테이블을 참조하고,
- 자식 테이블의 컬럼에 값을 입력할 때, 부모 테이블에 없는 컬럼의 값을 입력하지 못하도록 제약조건을 설정하는 것.

2. foreign key, 외래키, FK
- 참조 무결성을 성립시키기 위해 자식 테이블의 컬럼에 설정하는 제약조건.
- foreign key가 참조하는 부모 테이블의 컬럼은 반드시 primary key로 설정되어야 함.

ex)
- employee 테이블은 department 테이블을 참조하고 있음.
- 참조를 하고 있는 employee의 테이블 : 자식 테이블, 참조를 당하는(해주는) department 테이블 : 부모 테이블
- employee 테이블의 dno 컬럼은 department 테이블 dno 컬럼의 값을 참조하여 사용해야 함.
- employee 테이블에 데이터를 입력할 때 dno 컬럼의 값은 department 테이블의 dno 값을 참조해야 하고,
- department 테이블에 없는 dno의 값을 입력하지 못하도록 제약조건을 설정하는 것 
*/

-- < 테이블 생성 (제약조건 포함) >
-- 1. 테이블 생성 1번 방법 : 컬럼 레벨로 테이블 생성 
CREATE TABLE dept01 (
dno NUMBER(2) CONSTRAINT dept01_dno_pk PRIMARY KEY,
dname VARCHAR2(14),
loc VARCHAR2(13)
);

DESC dept01;
-- 제약조건 확인
SELECT * FROM user_constraints;

-- 2. 테이블 생성 2번 방법 : 테이블 레벨로 테이블 생성 
-- 테이블 레벨로는 not null 제약조건은 설정할 수 없음. 
CREATE TABLE dept01 (
dno NUMBER(2),
dname VARCHAR2(14),
loc VARCHAR2(13),
CONSTRAINTS dept01_dno_pk PRIMARY KEY (dno)
);

DESC dept01;
SELECT * FROM user_constraints;
SELECT OWNER, table_name, constraint_name, constraint_type, status FROM user_constraints;
SELECT OWNER, table_name, constraint_name, constraint_type, status FROM user_constraints
WHERE table_name = 'DEPT01';

-- 1. not null 제약조건
-- not null 제약조건은 컬럼 레벨로만 생성할 수 있음. 테이블 레벨로는 생성 불가
CREATE TABLE dept02 (
dno NUMBER(2) NOT NULL,
dname VARCHAR2(14) NOT NULL,
loc VARCHAR2(13) NOT NULL
);

DESC dept02;
SELECT * FROM user_constraints WHERE table_name = 'DEPT02';

-- 데이터 입력 : not null 제약조건 확인
INSERT INTO dept02(dno, dname) VALUES(10, 'ACCOUNTING');
--> ORA-01400: NULL을 ("ADMIN"."DEPT02"."LOC") 안에 삽입할 수 없습니다.

INSERT INTO dept02(dno, dname, loc) VALUES(10, 'ACCOUNTING', null);
--> ORA-01400: NULL을 ("ADMIN"."DEPT02"."LOC") 안에 삽입할 수 없습니다.

INSERT INTO dept02(dno, dname, loc) VALUES(10, 'ACCOUNTING', 'NEW YORK');
--> 데이터 추가 성공
SELECT * FROM dept02;
COMMIT;

-- 2. unique 제약조건
-- 유일하게 존재하는 컬럼, null은 unique로 인정 
CREATE TABLE dept03 (
dno NUMBER(2) UNIQUE,
dname VARCHAR(14) NOT NULL,
loc VARCHAR(13) NOT NULL
);

DESC dept03;
SELECT * FROM user_constraints WHERE table_name = 'DEPT03';

-- 데이터 추가 : unique 제약조건 확인
INSERT INTO dept03(dno, dname, loc) VALUES(10, 'ACCOUNTING', 'NEW YORK');
SELECT * FROM dept03;
COMMIT;

INSERT INTO dept03(dno, dname, loc) VALUES(10, 'MARKETING', 'LA');
-- ORA-00001: 무결성 제약 조건(ADMIN.SYS_C0022181)에 위배됩니다.

INSERT INTO dept03(dno, dname, loc) VALUES(20, 'MARKETING', 'LA');
--> 추가 성공
SELECT * FROM dept03;
COMMIT;

INSERT INTO dept03(dno, dname, loc) VALUES(null, 'TF', 'Seatle');
--> 추가 성공
COMMIT;

INSERT INTO dept03(dno, dname, loc) VALUES(null, 'IT', 'San Francisco');
--> 추가 성공, 모든 null은 unique한 것으로 판단 
SELECT * FROM dept03;
COMMIT;

-- 3. check 제약조건
-- salary 컬럼의 데이터를 입력할 때 반드시 3000~5000 사이의 연봉만 입력가능하도록 설정.
CREATE TABLE emp01 (
eno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9) NOt NULL,
salary NUMBER(7, 2) CONSTRAINT emp01_salary_ck CHECK(salary BETWEEN 3000 and 5000)
);

DESC emp01;
SELECT * FROM user_constraints WHERE table_name = 'EMP01';

-- 데이터 추가 : salary 컬럼의 check 제약조건 확인
INSERT INTO emp01(eno, ename, job, salary) VALUES(1001, 'TOM', 'ACTOR', 6000);
-- ORA-02290: 체크 제약조건(ADMIN.EMP01_SALARY_CK)이 위배되었습니다.

INSERT INTO emp01(eno, ename, job, salary) VALUES(1001, 'TOM', 'ACTOR', 5000);
--> 추가 성공
SELECT * FROM emp01;
COMMIT;

-- 4. default 값
CREATE table emp02 (
eno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9) NOT NULL,
salary NUMBER(7,2) DEFAULT 3000
);

DESC emp02;
SELECT * FROM user_constraints WHERE table_name = 'EMP02'; -- default 값 확인 불가
SELECT * FROM user_tab_columns WHERE table_name = 'EMP02'; -- default 값 확인
SELECT table_name, column_name, data_default FROM user_tab_columns WHERE table_name = 'EMP02';

-- 데이터 추가 : default값 확인
INSERT INTO emp02(eno, name, job) VALUES(1001, 'Sandra', 'ACTRESS');
SELECT * FROM emp02;
COMMIT;

-- 5. primary key 제약조건
SELECT * FROM user_constraints WHERE table_name = 'DEPT01';

-- 데이터 추가 : primary key 확인
INSERT INTO dept01(dno, dname, loc) VALUES('10', 'A', 'Seoul');
SELECT * FROM dept01;

INSERT INTO dept01(dno, dname, loc) VALUES (10, 'B', 'Busan');
--> 에러: ORA-00001: unique constraint (EZEN01.DEPT01_DNO_PK) violated

INSERT INTO dept01(dno, dname, loc) VALUES ('B', 'Busan');
--> 에러: ORA-01400: cannot insert NULL into ("EZEN01"."DEPT01"."DNO"), 동일한 dno 값 입력불가 

INSERT INTO dept01(dno, dname, loc) VALUES (null, 'B', 'Busan');
--> 에러: ORA-01400: cannot insert NULL into ("EZEN01"."DEPT01"."DNO"), dno에 null 값 입력불가

INSERT INTO dept01(dno, dname, loc) VALUES (20, 'B', 'Busan');
-- 추가 성공, dno의 컬럼값이 null이 아니고, 유일한 값일 때 입력 성공

------------
-- < 제약 조건을 포함하여 employee 테이블과 department 테이블 생성 >
-- employee 테이블은 department 테이블을 참조함.
-- department : 부모 테이블
-- employee : 자식 테이블

-- 테이블 생성 : dept01, 부모 테이블
CREATE TABLE dept01 (
dno NUMBER(2) CONSTRAINT dept01_dno_pk PRIMARY KEY,
dname VARCHAR2(14) CONSTRAINT dept01_dname_nn NOT NULL,
loc VARCHAR2(13) CONSTRAINT dept01_loc_nn NOT NULL
);

-- 테이블 생성 : emp01, 자식 테이블
CREATE TABLE emp01 (
eno NUMBER(4) CONSTRAINT emp01_eno_pk, PRIMARY KEY,
ename VARCHAR2(10) CONSTRAINT emp01_ename_nn NOT NULL,
job VARCHAR2(9) CONSTRAINT emp01_job_nn NOT NULL,
manager NUMBER(4),
hiredate DATE CONSTRAINT emp01_hiredate_nn NOT NULL,
salary NUMBER(7,2) CONSTRAINT emp01_salary_nn NOT NULL,
commission NUMBER(7,2),
dno NUMBER(2) CONSTRAINT emp01_dno_nn NOT NULL CONSTRAINT emp01_dno_fk REFERENCES dept01
);

-- 테이블의 구조와 제약조건 확인
DESC dept01;
SELECT * FROM user_constraints WHERE table_name = 'DEPT01';
DESC emp01;
SELECT * FROM user_constraints WHERE table_name = 'EMP01';

-- 부모 테이블 dept01 테이블에 데이터 입력
INSERT INTO dept01 VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept01 VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept01 VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO dept01 VALUES(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM dept01;
COMMIT;

-- 자식 테이블인 emp01 테이블에 데이터 입력 : 참조 무결성 확인
INSERT INTO emp01 VALUES(1001, 'TOM', 'ACTOR', NULL, TO_DATE('2015,4,14', 'yyyy,mm,dd'), 3000, NULL, 40);
--> 추가 성공 : 참조 무결성의 규칙이 지켜짐.
SELECT * FROM emp01;
COMMIT;

INSERT INTO emp01 VALUES(1002, 'JULLIA', 'ACTRESS', NULL, TO_DATE('2017,7,17', 'yyyy,mm,dd'), 2500, NULL, 50);
--> 에러: ORA-02291: integrity constraint (EZEN01.EMP01_DNO_FK) violated - parent key not found
-- 참조 무결성 위배됨, 부모 테이블의 컬럼 dno에 존재하지 않는 값을 자식 테이블에서 추가할 수 없음.

--> 위의 참조 무결성 위배 문제를 해결하는 방법
-- 1. emp01 테이블의 dno 컬럼의 값을 10, 20, 30, 40 중에 하나로 수정한다.
-- 2. emp01 테이블의 참조 무결성을 제거한다. (권장하지는 않음)
-- 3. 부모 테이블인 dept01 테이블에 dno가 50인 값을 넣는다.

-- 3번 방법으로 해결
INSERT INTO dept01 VALUES(50, 'IT', 'SEOUL');
SELECT * FROM dept01;
COMMIT;

INSERT INTO emp01 VALUES(1002, 'JULLIA', 'ACTRESS', NULL, TO_DATE('2017,7,17', 'yyyy,mm,dd'), 2500, NULL, 50);
SELECT * FROM emp01;
COMMIT;

---------------
-- < 테이블 구조 변경 > 제약 조건의 추가 / 변경 / 삭제
-- 테이블을 복사해서 생성하면 제약조건은 복사되지 않음
CREATE TABLE dept02 AS SELECT * FROM employee;
CREATE TABLE emp02 AS SELECT * FROM employee;

DESC dept02;
SELECT * FROM dept02;
SELECT * FROM user_constraints WHERE table_name = 'DEPT02';

DESC emp02;
SELECT * FROM emp02;
SELECT * FROM user_constraints WHERE table_name = 'EMP02';

-- constraint_type - P : Primary Key, R : Foreign Key, U : Unique, C : Not Null, Check

-- 1. 제약조건의 추가 : 부모 테이블의 제약조건부터 추가하고, 자식 테이블의 제약조건을 추가해야 함.

/* 1-1. ADD 명령으로 추가하는 방법, 단점) null, not null 제약조건이 변경되지 않음.
-- 부모 테이블 : dept02 테이블의 dno 컬럼에 Primary Key를 추가함.
ALTER TABLE dept02 ADD CONSTRAINT dept02_pk PRIMARY KEY(dno);
SELECT * FROM user_constraint WHERE table_name = 'DEPT02';

-- 자식 테이블 : emp02 테이블의 eno 컬럼에 PRIMARY KEY를 추가함
ALTER TABLE emp02 ADD CONSTRAINT emp02_eno_pk PRIMARY KEY(eno);
SELECT * FROM user_constraint WHERE table_name = 'EMP02';
ALTER TABLE emp02 ADD CONSTRAINT emp02_dno_fk FOREIGN KEY(dno) REFERENCES dept02(dno);
SELECT * FROM user_constraint WHERE table_name = 'EMP02';
*/

-- 1-2. modify 명령으로 추가하는 방법. 장점) 식이 간결, not null 제약조건 변경도 가능. 권장 
-- 부모 테이블: dept02 테이블의 dno 컬럼의 primary key를 추가함
ALTER TABLE dept02 MODIFY dno CONSTRAINT dept02_dno_pk PRIMARY KEY;
SELECT * FROM user_constraints WHERE table_name = 'DEPT02';
-- 자식 테이블 : emp02 테이블의 eno 컬럼에 Primary Key를 추가함, dno 컬럼에 foreign 키를 추가함.
ALTER TABLE emp02 MODIFY eno CONSTRAINT emp02_eno_pk PRIMARY KEY;
SELECT * FROM user_constraints WHERE table_name = 'EMP02';
ALTER TABLE emp02 MODIFY dno CONSTRAINT emp02_dno_fk REFERENCES dept02;
SELECT * FROM user_constraints WHERE table_name = 'EMP02';

-- 참조 무결성 테스트 
INSERT INTO emp02 VALUES(9000, 'KIM', 'DOCTOR', null, to_date('2020,10,12', 'yyyy,mm,dd'), 5000, null, 40);
SELECT * FROM emp02;
COMMIT;

INSERT INTO emp02 VALUES(9100, 'LEE', 'TEACHER', NULL, TO_DATE('2021,7,17', 'yyyy,mm,dd'), 4000, NULL, 50);
--> 에러: ORA-02291: integrity constraint (EZEN01.EMP02_DNO_FK) violated - parent key not found
-- 참조 무결성에 위배됨.

-- 2. 제약조건의 변경
-- emp02 테이블의 ename 컬럼의 제약조건을 NOT NULL로 변경
ALTER TABLE emp02 MODIFY ename CONSTRAINT emp02_ename__nn NOT NULL; -- 성공, ename 컬럼에 null 값이 없기 때문
SELECT * FROM user_constraints WHERE table_name = 'EMP02';

-- emp02 테이블의 commission 컬럼의 제약조건을 NOT NULL로 변경
ALTER TABLE emp02 MODIFY commission CONSTRAINT emp02_commission_nn NOT NULL; -- 실패, commission 컬럼에 null 값이 때

-- 3. 제약조건의 제거
-- emp02 테이블의 ename 컬럼의 not null 제약조건 제거
-- 3-1. 제약조건의 이름으로 제거
ALTER TABLE emp02 DROP CONSTRAINT emp02_ename_nn;
SELECT * FROM user_constraint WHERE table_name = 'EMP02';

-- 3-2. 제약조건으로 제거 - 자식을 먼저 제거하고, 부모를 제거
-- emp02 테이블의 pk와 fk를 제거
ALTER TABLE emp02 DROP PRIMARY KEY;
SELECT * FROM user_constraint WHERE table_name = 'EMP02';
ALTER TABLE emp2 DROP CONSTRAINT emp02_dno_fk;
SELECT * FROM user_constraint WHERE table_name = 'EMP02';

-- dept02 테이블의 pk를 제거
ALTER TABLE dept02 DROP CONSTRAINT dept02_dn_pk;
SELECT * FROM user_constraint WHERE table_name = 'EMP02';

-- 3-3. 종속 관계 (부모 자식간의 관계를 모두 제거하는 명령)
-- 부모의 pk와 자식의 fk를 함께 제거하는 명령 
ALTER TABLE dept02 DROP PRIMARY KEY CASCADE;


------------------

SELECT * FROM user_constraints WHERE table_name IN('EMP02', 'DEPT02');
SELECT * FROM user_constraints WHERE table_name IN('EMP01', 'DEPT01');

-- 4. 제약조건의 활성화/비활성화 (enable, disable)
-- emp02 테이블의 eno컬럼의 primary key 제약조건 
ALTER TABLE emp02 DISABLE CONSTRAINT emp_eno_pk;
SELECT * FROM user_constraints WHERE table_name = 'EMP02';

SELECT * FROM emp02;
DESC emp02;

-- eno 컬럼의 PK 제약조건 비활성한 후 eno 컬럼에 이미 존재하는 데이터 삽입 확인
--> PK 제약조건을 비활성화 하였으므로 삽입 가능 
INSERT INTO emp02(eno) VALUES(9000); -- 성공 
SELECT * FROM emp02;
COMMIT;

INSERT INTO emp02(eno) VALUES(NULL); -- 성공
SELECT * FROM emp02;
COMMIT;

-- 4-2. emp02 테이블의 eno 컬럼을 disable(비활성화)에서 enable(활성화)로 변경
ALTER TABLE emp02 ENABLE CONSTRAINT emp02_eno_pk;