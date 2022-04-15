-- 2022/04/13 6일차 수업

/*
< 4월 11일 과제 >
< 조인 문제 >
과제1) 10번 부서에 속하는 사원의 부서번호, 업무, 지역명을 출력하시오.
과제2) 업무가 'ANALYST'인 사원의 사번, 사원명, 업무, 부서번호, 부서명, 지역명을 출력하시오.
-- self join
과제3) 'SCOTT'과 동일한 부서에서 근무하는 사원의 사원명, 부서번호, 부서명을 'SCOTT'을 제외하고 출력하시오.
과제4) 'WARD' 사원보다 늦게 입사한 사원의 사원명, 입사일을 출력하시오.
과제5) 관리자보다 입먼저 입사한 사원의 사원명, 사원의 입사일, 관리자명, 관리자의 입사일을 출력하시오.
< 서브쿼리 문제 >
과제6) 사번이 7499인 사원보다 급여가 많은 사원의 사번, 사원명, 업무, 급여를 출력하시오.
과제7) 'BLAKE'와 동일한 부서에서 근무하는 사원의 사원명과 입사일, 부서번호를 출력하시오.
과제8) 급여가 평균급여보다 많은 사원의 사번, 사원명, 급여를 출력하시오.
*/

-- 과제1) 10번 부서에 속하는 사원의 부서번호, 업무, 지역명을 출력하시오.
SELECT e.dno, job, loc
FROM employee e, department d
WHERE e.dno = d.dno
AND e.dno = 10;

-- 과제2) 업무가 'ANALYST'인 사원의 사번, 사원명, 업무, 부서번호, 부서명, 지역명을 출력하시오.
SELECT eno, ename, job, e.dno, dname, loc
FROM employee e, department d
WHERE e.dno = d.dno
AND job = 'ANALYST';

-- 과제3) 'SCOTT'과 동일한 부서에서 근무하는 사원의 사원명, 부서번호, 'SCOTT'을 제외하고 출력하시오.
-- self join으로 해결
SELECT s.ename, s.dno, o.ename
FROM employee s, employee o
WHERE s.dno = o.dno
AND s.ename = 'SCOTT'
AND o.ename <> 'SCOTT';

-- 과제4) 'WARD' 사원보다 늦게 입사한 사원의 사원명, 입사일을 출력하시오.
-- 입사일을 기준으로 오름차순 정렬하시오.
-- self join
SELECT o.ename, o.hiredate
FROM employee w, employee o
WHERE w.hiredate < o.hiredate
AND w.ename = 'WARD'
ORDER BY o.hiredate;

-- 과제5) 관리자보다 먼저 입사한 사원의 사원명, 사원의 입사일, 관리자명, 관리자의 입사일을 출력하시오.
-- self join, equi join
SELECT e.ename, e.hiredate, m.ename, m.hiredate
FROM employee e, employee m
WHERE e.manager = m.eno
AND e.hiredate < m.hiredate;

-- 과제6) 사번이 7499인 사원보다 급여가 많은 사원의 사번, 사원명, 업무, 급여를 출력하시오.
-- 서브쿼리: 사번이 7499인 사원의 급여 -> 단일행 서브쿼리
SELECT eno, ename, job, salary
FROM employee
WHERE salary > (SELECT salary FROM employee WHERE eno = 7499);

-- 과제7) 'BLAKE'와 동일한 부서에서 근무하는 사원의 사원명과 입사일, 부서번호를 출력하시오.
-- 서브쿼리: 'BLAKE'가 근무하는 부서번호 -> 단일행 서브쿼리
SELECT ename, hiredate, dno
FROM employee
WHERE dno = (SELECT dno FROM employee WHERE ename = 'BLAKE');

-- 과제8) 급여가 평균급여보다 많은 사원의 사번, 사원명, 급여를 출력하시오.
-- 서브쿼리: 평균급여를 구함 -> 단일행 서브쿼리
SELECT eno, ename, salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

SELECT AVG(salary) FROM employee; -- 평균급여(2073...)

/*
서브쿼리의 종류 
1. 단일행 서브쿼리 - 서브쿼리의 결과가 단 1개일 
- >, >=, <, <=, =, <>

2. 다중행 서브쿼리 - 서브쿼리의 결과가 1개 이상일 때
- in, any(some), all

- in(any): 서브쿼리의 결과가 메인쿼리와 한 개라도 일치한다면 출력
- any : 서브쿼리의 여러 결과 중에서 한 가지만 만족해도 출력
- < any : 서브쿼리의 결과 중에서 최대값보다 작은 값은 출력
- > any : 서브쿼리의 결과 중에서 최소값도 큰 값을 출력
- all : 서브쿼리의 여러 결과가 메인쿼리와 모두 만족해야 출력 
- < all : 서브쿼리의 결과 중에서 최소값보다 작은 값을 출력
- > all : 서브쿼리의 결과 중에서 최대값보다 큰 값을 출력

*/

-- 문제5) 부서별 최소급여를 받는 사원의 사번, 사원명, 부서번호, 최소급여를 구하시오.
-- 해결시간: 3분
SELECT eno, ename, dno, salary
FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee GROUP BY dno);
--> ORA-01427: single-row subquery returns more than one row
--> 다중행 서브쿼리를 단일행 서브쿼리로 풀어서 발생하는 에러

-- 다중행 서브쿼리로 해결 (= 대신에 IN 연산자 or =ANY)
SELECT eno, ename, dno, salary
FROM employee
WHERE salary IN(SELECT MIN(salary) FROM employee GROUP BY dno);

-- 문제6)'SALESMAN'보다 작은 급여를 받는 사원의 사번, 사원명, 직급, 급여를 출력하시오.
-- 직급이 'SALESMAN'은 제외하시오.
-- 서브쿼리: 'SALESMAN'의 급여 
-- 해결시간: 3분

SELECT eno, ename, job, salary
FROM employee
WHERE salary < (SELECT salary FROM employee WHERE job = 'SALESMAN');
-- ORA-01427: single-row subquery returns more than one row

-- 서브쿼리: SELECT salary FROM employee WHERE job = 'SALESMAN'
-- 결과: 4가지, 1600, 1250, 1250, 1500, 1600

SELECT eno, ename, job, salary
FROM employee
WHERE salary < ANY (SELECT salary FROM employee WHERE job = 'SALESMAN')
AND job <> 'SALESMAN';

-- 문제7) 모든 'SALESMAN' 급여보다 작은 급여를 받는 사원의 사번, 사원명, 직급, 급여를 출력하시오.
-- 서브쿼리: SELECT salary FROM employee WHERE job = 'SALESMAN'
-- 결과: 4가지, 1250, 1250, 1500, 1600
-- < all : 서브쿼리의 4가지 결과를 모두 만족해야만 출력
SELECT eno, ename, job, salary
FROM employee
WHERE salary < ALL (SELECT salary FROM employee WHERE job = 'SALESMAN';)
AND job <> 'SALESMAN';

-- < 다중행 서브쿼리 확인 학습 >
-- 해결시간: 10분
-- 확인문제1) 사원명에 'K'가 포함된 사원과 같은 부서에서 근무하는 사원의 사번, 사원명, 부서번호를 출력하시오.
-- 서브쿼리: 사원명에 'K'가 포함된 사원의 부서 -> 여러개 -> 다중행 서브쿼리 
SELECT eno, ename, dno
FROM employee
WHERE dno IN (SELECT dno FROM employee WHERE ename LIKE '%K%');

-- 확인문제2) 업무가 'ANALYST'인 사원이 소속된 부서와 같은 부서에서 근무하는 사원의 부서번호, 사원명, 업무를 출력하시오.
-- 서브쿼리: 업무가 'ANALYST'인 사원이 소속된 부서 -> 여러개 -> 다중행 서브쿼
SELECT dno, ename, job
FROM employee
WHERE dno IN (SELECT dno FROM employee WHERE job = 'ANALYST');

-- 확인문제3) 평균급여보다 많은 급여를 받고, 사원명에 'M'이 포함된 사원과 같은 부서에서 근무하는 사원의 사번, 사원명, 급여를 출력하시오.

SELECT * FROM employee;

-- < 단일행 서브쿼리 확인 학습 >
-- 확인문제4) 평균급여가 가장 작은 업무를 출력하시오.
-- 확인문제5) 부서위치가 'DALLAS'인 사원의 사원명, 부서번호, 업무를 출력하시오.
-- 확인문제6) 'RESEARCH' 부서에서 근무하는 사원의 부서번호, 사원명, 업무를 출력하시오.

---------
-- < 테이블 생성 / 구조 변경 / 제거 > : DDL(데이터 정의어)
/* 테이블 명을 만드는 방법
1. 사용문자는 영어 대소문자, 숫자, 문자(_, $, 
2.
3. 예약어와 중복되지 않도록 정의
4. 대소문자를 구분하지는 않음
*/

-- 1. 테이블 생성 1번 방법 (제약조건은 없이 생성)
-- CREATE TABLE 테이블명 ~
CREATE TABLE dept (
dno NUMBER(2),
dame VARCHAR2(14),
loc VARCHAR2(13)
);

-- 2. 테이블 복사방법
-- CREATE TABLE 테이블명 AS SELECT ~
-- 2-1 : 테이블의 구조와 데이터를 모두 복사,
-- 무결성 제약조건은 복사되지 않음 (기본키와 외래키)
CREATE TABLE dept_second
AS SELECT * FROM department;

DESC dept_second;
SELECT * FROM dept_second;

-- 2-2 : 테이블의 특정 컬럼과 모든 데이터를 복사 
CREATE TABLE emp02
AS SELECT eno, ename, job, salary FROM employee;

DESC emp02;
SELECT * FROM emp02;

-- 2-3 : 테이블의 수식 컬럼은 alias를 사용하여 생성해야함.
CREATE TABLE emp03
AS SELECT eno, ename, salary, salary*12 annual_salary FROM employee;

DESC emp03;
SELECT * FROM emp03;

-- 2-4 : 테이블의 조건에 따라 특정 데이터만 복사하여 생성.
CREATE TABLE emp04
AS SELECT * FROM employee WHERE job = 'SALESMAN';

DESC emp04;
SELECT * FROM emp04;

-- 2-5 : 테이블에서 데이터는 복사하지 않고, 구조만 복사하여 생성 
CREATE TABLE emp05
AS SELECT * FROM employee WHERE 0 = 1;

DESC emp05;
SELECT * FROM emp05;

-- 3.  테이블의 구조를 변경하는 방법 : 컬럼 추가, 컬럼 삭제, 컬럼명 변
-- ALTER TABLE 테이블명 ~

-- 3-1. 컬럼 추가, emp02 테이블에 birthday 컬럼을 추가 (date 타입)
-- add 예약어의 괄호 안에 컬럼명과 타입을 나열하면 됨, 여러개도 가능 
DESC emp02;
ALTER TABLE emp02 ADD (birthday DATE);
DESC emp02;
ALTER TABLE emp02 ADD (sex CHAR(1), hobby VARCHAR2(30));
DESC emp02;

-- 3-2. 컬럼명 변경, emp02 테이블의 birthday를 b_day 로 변경 
-- rename 예약어를 사용 
ALTER TABLE emp02 RENAME COLUMN birthday TO b_day;
DESC emp02;

-- 3-3. 컬럼의 타입 변경, ex) emp02 테이블의 sex 타입을 VARCHAR(6)로 변경
-- MODIFY의 괄호 안에 변경하고자 하는 컬럼명과 타입을 나열하면 여러개를 동시에 변경도 가능
ALTER TABLE emp02 MODIFY sex VARCHAR(6);
DESC emp02;

ALTER TABLE emp02 MODIFY (ename VARCHAR2(20), job VARCHAR2(18));
DESC emp02;

-- 3-4. 컬럼의 제거, ex) emp02 테이블의 hobby 컬럼을 제거
-- 컬럼의 삭제는 한번에 하나씩만 가능함.
ALTER TABLE emp02 DROP COLUMN hobby;
DESC emp02;

-- 4. 테이블 제거  
SELECT * FROM TAB;
DROP TABLE dept_second;
SELECT * FROM TAB;

-- 5. 테이블명 변경 ex)emp03 테이블의 이름을 emp_copy로 변경 
RENAME emp03 TO emp_copy;
SELECT * FROM TAB;

-- 6. 테이블의 모든 데이터를 삭제(테이블의 구조는 유지하고), ex) dept의 모든 데이터를 삭제 
-- 6-1. TRUNCATE 명령 - DDL(데이터 정의어)
SELECT * FROM emp02;
TRUNCATE TABLE emp02;
DESC emp02;
SELECT * FROM emp02;

-- 6.2. DELETE 명령 - DML(데이터 조작어_)
SELECT * FROM emp04;
DELETE FROM emp04;
DESC emp04;
SELECT * FROM emp04;

/*
데이터 사전 (data dictionary) - 오라클에서만 존재하는 기능
- 사용자가 데이터베이스의 자원을 효율적으로 관리할 수 있도록 다양한 정보를 제공하는 시스템 테이블의 집합
- 사용자가 테이블을 생성하거나 사용자를 변경하는 등의 작업을 할 때 데이터베이스 서버에 의해서 자동으로 갱신되는 테이블
- 사용자는 데이터 사전의 내용을 변경하거나 제거할 수 없고 사용자는 데이터 사전의 내용을 확인만 가능하다.
- 데이터 사전은 읽기 전용 뷰 형태로 제공됨

데이터 사전의 종류 - 접두어에 따라
user_ : 자신의 계정이 소유한 객체의 정보를 확인 
all_ : 자신의 계정 또는 권한을 부여받은 객체의 정보를 확인
dba_ : 데이터베이스 관리자가 접근 가능한 객체의 정보를 확인 

user_tables: 자신의 계정이 소유한 테이블의 정보를 확인
user_sequences: 자신의 계정이 소유한 시퀀스의 정보를 확인 
user_indexes: 자신의 계정이 소유한 인덱스의 정보를 확인 
user_views: : 자신의 계정이 소유한 뷰의 정보를 확인 

all_tables: 전체 사용자(자신의 계정과 권한을 부여받은 객체)가 소유한 테이블의 정보를 확인 
dba_tables: 관리자가 접근 가능한 테이블의 정보를 확읺나다.
*/

SELECT * FROM user_tables;
SELECT table_name FROM user_tables;
SELECT * FROM tab;

SELECT * FROM all_tables;
SELECT * FROM dba_tables;

-- 테이블 생성
CREATE TABLE dept01 (
dno NUMBER(2),
dname VARCHAR2(14),
loc VARCHAR2(13)
);

DESC dept01;
SELECT * FROM dept01;

/*
< 데이터 추가 / 데이터 수정 / 데이터 삭제 >  : DML(데이터 조작어)
DML - INSERT, UPDATE, DELETE, SELECT
CRUD - CREATE(INSERT), READ(SELECT), UPDATE, DELETE
*/

-- 1. 데이터 추가 : insert into 테이블명 (컬럼명 ...) values (값 ...)
-- 1-1. 데이터 추가 1번 : 모든 컬럼에 값을 추가 
 INSERT INTO dept01(dno, dname, loc) values (10, 'ACCOUNTING', 'NEW YORK');
SELECT * FROM dept01;

-- 1-2. 데이터 추가 4번 : 컬럼명을 생략하면, 모든 컬럼에 대한 값을 만든 순서대로 적어줌.
INSERT INTO dept01 VALUES(40, 'OPERATIONS', 'BOSTON');
SELECT * FROM dept01;
COMMIT;

-- 1-3. 데이터 추가 3번 : 컬럼명을 명시하면, 값의 순서는 컬럼명의 순서를 따르면 됨.
INSERT INTO dept01(loc, dno, dname) VALUES('CHICAGO', 30, 'SALES');
SELECT * FROM dept01;
COMMIT;

-- 1-4. 데이터 추가 2번 : null인 컬럼을 생략하고 값을 추가(NOT NUll인 컬럼은 반드시 사용해야함)
-- 명시하지 않은 컬럼에 대해 암묵적으로 NULL을 삽입
INSERT INTO dept01(dno) VALUES(20);
SELECT * FROM dept01;
COMMIT; -- 확정 

-- 1-5. 데이터 추가 5번 : 명시적으로 NULL을 삽입
INSERT INTO dept01(dno, dname, loc) VALUES(50);
SELECT * FROM dept01;
COMMIT;

-- 1-6. 데이터 추가 6번 : 명시적으로 빈 문자열을 삽입 
INSERT INTO dept01(dno, dname, loc) VALUES(60, '', '');
SELECT * FROM dept01;
COMMIT;

-- 1-7. 데이터 추가 7번 : 다른 테이블의 데이터를 복사해서 추가하는 방법
TRUNCATE TABLE dept01;
SELECT * FROM dept01;
COMMIT;

-- 테이블의 내용을 복사하여 추가, AS는 사용 불가 
INSERT INTO dept01 SELECT * FROM department;
-- INSERT INTO dept01(dno, dname, loc) SELECT dno, dname, loc FROM department;
SELECT * FROM dept01;
COMMIT;

/*
< 확인 학습 >
문제1) employee 테이블에서 데이터는 복사하지 않고, 구조만 복사하여 emp01 테이블을 생성하시오.
문제2) emp01 테이블에 데이터를 5개를 추가하여 확인하시오. (EMPLOYEE 테이블 참고)
해결시간: 10분

*/

CREATE TABLE emp01
AS SELECT * FROM employee WHERE 0 = 1;

DESC emp01;
SELECT * FROM emp01;

INSERT INTO emp01 VALUES(7369, 'SMITH', 'CLERK', 7902, to_date('1980,12,27', 'yyyy,MM,DD'), 800, null, 20);
SELECT * FROM emp01;
COMMIT;

TRUNCATE TABLE emp01;
INSERT INTO emp01 SELECT * FROM employee;
COMMIT;

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





