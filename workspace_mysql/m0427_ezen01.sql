-- 2022년 4월 27일 (수)

-- 여기는 사용자 계정 ezen01 안 ..
-- mysql에서는 oracle처럼 계정안에 바로 테이블이나 뷰를 만들어 사용하지 않고, 
-- 데이터베이스를 만들어서 그 안에서 테이블이나 뷰를 만들어 사용한다.

-- 1. 사용자 확인
SELECT USER();

-- 2. 데이터베이스 확인
SELECT DATABASE();

-- 3. 데이터베이스 생성
CREATE DATABASE db01;
SELECT DATABASE(); -- null -> 사용하겠다고 하지 않았기 때문

-- 4. 데이터베이스 사용
USE db01;
SELECT DATABASE(); -- db01 -> 현재 사용하는 데이터베이스는 db01임.

-- 5. 데이터베이스 삭제
DROP DATABASE db01;
SELECT DATABASE();

CREATE DATABASE db01;
USE db01;
SELECT DATABASE();

-- 6. 현재 계정의 모든 데이터베이스 확인 
CREATE DATABASE db02;
SHOW DATABASES;

-- 7. 현재 데이터베이스 안에 있는 모든 테이블 확인
USE db01;
SELECT DATABASE();
SHOW TABLES;

-- 8. 테이블 생성
/*
< MySQL의 데이터 타입 >
1. 정수
- TINYINT(1B), SMALLINT(2B), MEDIUMINT(3B), INT(4B), BIGINT(8)
- 대게는 INT를 주로 사용

2. 실수
- DECIMAL(전체, 소수점이하 자리수)
- FLOAT(4B), DOUBLE(8B)

3. 문자열
- CHAR : 고정 문자열 ex) CHAR(5)
- VARCHAR : 가변 문자열 ex) VARCHAR(5) 

4. 날짜와 시간
- DATE : 3B
- DATETIME : 8B, 날짜와 시간
- TIMESTAMP : 4B, 날짜와 시간

5. 기타 데이터 타입
- BLOB(Binary Large OBject) : 바이너리 데이터 중에서 아주 큰 데이터 
- TEXT : 문자의 아주 큰 데이터 
< 사원 테이블 설계 >
- oracle에서 사용했던 employee 테이블과 동일한 테이블을 직접 생성
-- 테이블명: employee
-- 필드(컬럼): eno(정수), ename(문자), job(문자), manager(정수), hiredate(날짜), salary(실수), commission(실수), dno(정수)
-- PK(Primary Key) : eno
*/

DROP TABLE employee;

-- employee 테이블 생성
CREATE TABLE employee (
eno INT PRIMARY KEY,
ename VARCHAR(20) NOT NULL,
job VARCHAR(20) NOT NULL,
manager INT,
hiredate DATE,
salary DECIMAL(7, 2),
commission DECIMAL(7, 2),
dno INT
);

-- 데이터베이스와 테이블 확인
USE db01;
SELECT DATABASE();
SHOW TABLES;
DESC employee;
SELECT * FROM employee;

DELETE FROM employee;

-- employee 테이블에 데이터 삽입
INSERT INTO EMPLOYEE VALUES(7369,'SMITH','CLERK', 7902,'1980-12-17',800,NULL,20);
INSERT INTO EMPLOYEE VALUES(7499,'ALLEN','SALESMAN', 7698,'1981-2-20',1600,300,30);
INSERT INTO EMPLOYEE VALUES(7521,'WARD','SALESMAN', 7698,'1981-2-22', 1250,500,30);
INSERT INTO EMPLOYEE VALUES(7566,'JONES','MANAGER', 7839,'1981-4-2',2975,NULL,20);
INSERT INTO EMPLOYEE VALUES(7654,'MARTIN','SALESMAN',7698,'1981-9-28',1250, 1400,30);
INSERT INTO EMPLOYEE VALUES(7698,'BLAKE','MANAGER', 7839,'1981-5-1',2850, NULL,30);
INSERT INTO EMPLOYEE VALUES(7782,'CLARK','MANAGER', 7839, '1981-6-9',2450,NULL,10);
INSERT INTO EMPLOYEE VALUES(7788,'SCOTT','ANALYST', 7566,'1987-07-13',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES(7839,'KING','PRESIDENT', NULL,'1981-11-17',5000,NULL,10);
INSERT INTO EMPLOYEE VALUES(7844,'TURNER','SALESMAN', 7698,'1981-9-8',1500,0,30);
INSERT INTO EMPLOYEE VALUES(7876,'ADAMS','CLERK', 7788,'1987-07-13',1100,NULL, 20);
INSERT INTO EMPLOYEE VALUES(7900,'JAMES','CLERK', 7698,'1981-12-3',950, NULL, 30);
INSERT INTO EMPLOYEE VALUES(7902,'FORD','ANALYST',7566,'1981-12-3', 3000, NULL, 20);
INSERT INTO EMPLOYEE VALUES(7934,'MILLER','CLERK',7782,'1982-1-23', 1300, NULL, 10);

SELECT * FROM employee;
COMMIT;

-- JSP 프로그램에서 DB 연동할 테이블 생성
-- 회원 테이블, member 테이블 생성
-- 필드 : id(아이디, 문자열), pwd(비밀번호, 문자), name(이름, 문자), age(나이, 정수), regDate(가입일, 날짜)
-- id는 PK로 설정
CREATE TABLE member (
id VARCHAR(20) PRIMARY KEY,
pwd VARCHAR(20) NOT NULL,
name VARCHAR(20) NOT NULL,
age INT NOT NULL,
regDate DATETIME NOT NULL
);

DESC member;
INSERT INTO MEMBER VALUES('aaa1111','1234','이현이',35,NOW());
INSERT INTO MEMBER VALUES('bbb1111','1234','송해나',34,NOW());
INSERT INTO MEMBER VALUES('ccc1111','1234','아이린',33,NOW());
SELECT * FROM member;