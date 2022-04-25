-- 2022/04/18(월) 9일차 수업

/*
< 인덱스 (index) >
- 검색 속도의 향상을 위해서 사용하는 기능
- 직접 인덱스를 생성할 수도 있고, 데이터의 무결성 확인을 위해 수시로 사용하는 기본키는 인덱스가 자동으로 생성됨.

튜닝 - 인덱스를 통해서 검색 속도를 향상시키는 기법 

*/

CREATE TABLE emp01 AS SELECT * FROM employee;
CREATE TABLE dept01 AS SELECT * FROM department;

SELECT * FROM user_constraints WHERE table_name IN('EMP01', 'DEPT01');

-- 제약 조건 추가 
ALTER TABLE dept01 MODIFY dno CONSTRAINT dept01_dno_pk PRIMARY KEY;
ALTER TABLE emp01 MODIFY eno CONSTRAINT emp01_eno_pk PRIMARY KEY;
ALTER TABLE emp01 MODIFY dno CONSTRAINT emp01_dno_fk REFERENCES dept01;

-- 제약 조건 확인 : PK에 인덱스가 생성되어 있는 것을 확인 
SELECT * FROM user_constraints WHERE table_name IN('EMP01', 'DEPT01');

-- 인덱스 확인: user_ind_columns(인덱스가 생성된 컬럼), user_indexes(인덱스 전체)
SELECT * FROM user_ind_columns WHERE table_name IN('EMP01', 'DEPT01');

/*
< 인덱스를 사용해야 하는 경우 >
1. 테이블의 행(데이터)이 아주 많은 경우(수 만건 이상의 데이터가 있을 때)
2. WHERE 절에서 해당 컬럼이 자주 사용되는 경우
3. 검색 결과가 전체 데이터의 2%~4% 정도인 경우
4. join에 자주 사용되는 컬럼이 있는 경우
5. 데이터에 NULL을 포함하는 컬럼이 많은 경우

< 인덱스를 사용하지 말아야 하는 경우 >
1. 테이블의 행이 적은 경우
2. WHERE절에서 해당 컬럼이 자주 사용되지 않는 경우
3. 검색 결과가 전체 데이터의 10% 이상인 경우
4. 테이블에서 SELECT를 제외한 DML 작업(INSERT, UPDATE, DELETE)

< 인덱스의 종류 >
1. 인덱스가 유일한 값을 갖는지의 여부에 따라
- 고유 인덱스(unique index) : 유일한 값을 가지는 인덱스, ex) primary key(기본키), unique key(유일키), 
- 비고유 인덱스(non-unique index) : 중복된 데이터를 갖는 컬럼에 생성되는 인덱스 

2. 인덱스를 구성하는 컬럼의 개수에 따라
- 단일 인덱스 : 한 개의 컬럼으로 구성되는 인덱스
- 결합 인덱스 : 두 개 이상의 컬럼으로 구성되는 인덱스

*/

CREATE TABLE emp01 AS SELECT * FROM employee;
CREATE TABLE dept01 AS SELECT * FROM department;

ALTER TABLE emp01 MODIFY eno CONSTRAINT emp01_eno_pk PRIMARY KEY;
ALTER TABLE dept01 MODIFY dno CONSTRAINT dept01_dno_pk PRIMARY KEY;

SELECT table_name, constraint_name, constraint_type, status FROM user_constraints
WHERE table_name IN('EMP01', 'DEPT01');

-- emp01, dept01 테이블의 PK인 eno, dno 컬럼에 생성된 인덱스 확인
-- 고유 인덱스이고, 단일 인덱스
SELECT * FROM user_ind_columns WHERE table_name IN('EMP01', 'DEPT01');

-- 문제1) dept01 테이블의 dname 컬럼에 고유 인덱스를 생성하시오.
CREATE UNIQUE INDEX idx_dept01_dname ON dept01(dname);

SELECT * FROM user_indexes WHERE table_name = 'DEPT01';
