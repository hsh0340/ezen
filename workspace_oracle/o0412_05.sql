-- 2022/04/12(화) - 5일차 수업

SELECT table_name FROM user_tables;
DESC employee;
SELECT * FROM employee;

/*
2. 넌이퀴 조인(non-equi join)
- 조인 조건이 =(equal) 이 아닌 연산자를 사용하는 조인
- 조인 조건이 특정 범위 내에 있는지를 조사하기 위해 사용
*/

-- 문제21) 사원의 급여에 해당하는 급여 등급을 출력하시오.
-- 사번, 사원명, 업무, 연봉, 연봉등급의 5개 필드 -> employee, salgrade 테이블 사용
-- equi join
SELECT eno, ename, job, salary, grade
FROM employee, salgrade
WHERE salary BETWEEN losal AND hisal;

-- join ~ on
SELECT eno, ename, job, salary, grade
FROM employee JOIN salgrade
ON salary BETWEEN losal AND hisal;

-- 문제22) 사원명, 부서명, 연봉, 연봉등급을 출력하시오.
-- employee, department, salgrade 테이블 사용
-- 해결시간: 3분
-- equi join
SELECT ename, dname, salary, grade
FROM employee e, department d, salgrade s
WHERE salary BETWEEN losal AND hisal
AND e.dno = d.dno;

-- join ~ on
SELECT ename, dname, salary, grade
FROM employee e
JOIN department d ON e.dno = d.dno
JOIN salgrade s ON salary BETWEEN losal AND hisal;

/*
3. self join (셀프 조인)법
- 하나의 테이블에 있는 필드끼리 조인하는 방법
- 하나의 테이블을 두 개 이상의 테이블로 활용하여 조인하는 방법
*/

-- 문제23) 사번, 사원명, 사원의 직속상관번호, 사원의 직속상관 이름을 출력하시오.
SELECT eno, ename, manager FROM employee; -- 사번, 사원명, 직속상관번호만 출력가능, 직속상관이름은 불가능

-- self join 사용, e는 사원 테이블, m은 직속상관 테이블
SELECT e.eno 사번, e.ename 사원명, m.eno 관리자번호, m.ename 관리자명
FROM employee e, employee m -- 테이블 두 개 사용
WHERE e.manager = m.eno; -- 조인 조건

-- join ~ on
SELECT e.eno 사번, e.ename 사원명, m.eno 관리자번호, m.ename 관리자이름
FROM employee e JOIN employee m
ON e.manager = m.eno;

SELECT e.ename 사원명, m.ename 관리자명
FROM employee e JOIN employee m
ON e.manager = m.eno;

SELECT e.ename || '의 관리자는 ' || m.ename || '입니다.'
FROM employee e JOIN employee m
ON e.manager = m.eno;

/*
4. outer join
- 기본적인 join의 결과는 두 테이블 중에서 어느 한 개의 필드의 값이 null이면 결과를 출력하지 않음.
- outer join은 어느 한개의 필드의 값이 null이라도 결과를 출력하도록 함.
*/

-- oracle에서 사용 가능한 방식, null값이 존재하는 쪽에 +를 사용
SELECT e.eno 사번, e.ename 사원명, m.eno 관리자번호, m.ename 관리자명
FROM employee e, employee m
WHERE e.manager = m.eno; -- king의 정보는 나오지 않음.

-- 표준 방식, 기준이 되는 쪽의 예약어를 사용, 대개는 left outer join을 사용
-- left, right
SELECT e.eno 사번, e.ename 사원명, m.eno 관리자번호, m.ename 관리자명
FROM employee e LEFT OUTER JOIN employee m
ON e.manager = m.eno;

/*
서브 쿼리(Sub Query)
- 여러 개의 쿼리문을 통해서 결과를 확인해야 하는 것을 하나의 쿼리문으로 결과를 확인하도록 하는 방법
- 메인 쿼리 안에 서브 쿼리가 존재하는 형태를 가지는 쿼리
*/

-- Q1) 'SCOTT' 사원보다 연봉을 많이 받는 사원을 검색하시오.
-- 1단계 : 'SCOTT' 사원의 연봉을 알아내야함.
SELECT salary FROM employee WHERE ename = 'SCOTT';
-- 2단계 : 알아낸 연봉보다 높은 연봉을 받는 사원과 연봉을 알아냄.
SELECT ename, salary FROM employee WHERE salary > 3000;

--> 위의 문제를 하나의 서브쿼리문으로 해결하고자함.
-- 아래 문제는 조인 문제로 해결할 수도 있음. 서브쿼리가 훨씬 보기 편함.
SELECT ename, salary
FROM employee
WHERE salary > (SELECT salary FROM employee WHERE ename = 'SCOTT');

-- 문제2) 'MARTIN'과 같은 부서에서 일하는 모든 사원의 사번, 사원명, 부서번호를 검색하시오.
SELECT eno 사번, ename 사원명, dno 부서번호
FROM employee
WHERE dno = (SELECT dno FROM employee WHERE ename = 'MARTIN');

/*
문제10) 사원 테이블에서 최고 연봉을 받는 사원의 사원명과 연봉을 구하시오.
SELECT ename, MAX(salary) FROM employee;
-> 문제점) 에러 발생, not a single-group function
-> ename은 14개의 행, MAX(salary)는 1개의 행, 따라서 행의 개수가 일치하지 않아서 발생하는 문제
-> 해결책) 서브쿼리로 해결
*/

-- 문제3) 사원 테이블에서 최고 연봉을 받는 사원의 사원명과 연봉을 구하시오.
-- 서브쿼리: 최고연봉
-- 메인쿼리: 최고연봉과 같은 연봉을 받는 사원, 연봉
-- 해결시간: 3분
SELECT ename 사원명, salary 연봉 FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

-- 문제4) 부서별 최소급여가 30번 부서의 최소급여보다 큰 부서의 최소급여를 구하시오.
SELECT dno, MIN(salary) 
FROM employee
GROUP BY dno 
HAVING MIN(salary) > (SELECT MIN(salary) FROM employee WHERE dno=30);

-- 부서별 최소급여를 확인
SELECT dno, MIN(salary)
FROM employee
group by dno;

/*
서브쿼리의 종류 
1. 단일행 서브쿼리
- 서브쿼리의 결과가 1개의 행일 때
- >, >=, <, <=, =, <>

2. 다중행 서브쿼리
- 서브쿼리의 결과가 2개 이상일 때
- in, any(some), all

*/

-- 문제5) 부서별 최소급여를 받는 사원의 사번, 사원명, 부서번호, 최소급여를 구하시오.
-- 해결시간: 3분
SELECT eno, ename, dno, salary
FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee GROUP BY dno);
--> ORA-01427: single-row subquery returns more than one row
--> 다중행 서브쿼리를 단일행 서브쿼리로 풀어서 발생하는 에러

-- 다중행 서브쿼리로 해결 (= 대신에 IN 연산자)
SELECT eno, ename, dno, salary
FROM employee
WHERE salary IN(SELECT MIN(salary) FROM employee GROUP BY dno);

-- 문제6) 직급이 'SALESMAN'이 아니면서, 급여가 'SALESMAN'보다 작은 급여를 받는 사원의 사번, 사원명, 직급, 급여를 출력하시오.
-- 서브쿼리: 'SALESMAN'의 급여 
SELECT eno, ename, job, salary
FROM employee
WHERE salary < (SELECT salary FROM employee WHERE job IN 'SALESMAN')
AND job <> 'SALESMAN';
-- ORA-01427: single-row subquery returns more than one row

SELECT eno, ename, job, salary
FROM employee
WHERE salary < ANY(SELECT salary FROM employee WHERE job IN 'SALESMAN')
AND job <> 'SALESMAN';
-- 다중행 서브쿼리로 해결함.

/*
조인 문제
과제1) 10번 부서에 속하는 사원의 부서번호, 업무, 지역명을 출력하시오.

과제2) 업무가 'ANALYST'인 사원의 사번, 사원명, 업무, 부서번호, 부서명, 지역명을 출력하시오.

과제3) 'SCOTT'과 동일한 부서에서 근무하는 사원의 사원명, 부서번호, 부서명을 'SCOTT'을 제외하고 출력하시오.

과제4) 'WARD' 사원보다 늦게 입사한 사원의 사원명, 입사일을 출력하시오.

과제5) 관리자보다 먼저 입사한 사원의 사원명, 사원의 입사일, 관리자명, 관리자의 입사일을 출력하시오.

< 서브쿼리 문제 >
과제6) 사번이 7499인 사원보다 급여가 많은 사원의 사번, 사원명, 업무, 급여를 출력하시오.

과제7) 'BLAKE'와 동일한 부서에서 근무하는 사원의 사원명과 입사일, 부서번호를 출력하시오.

과제8) 급여가 평균급여보다 많은 사원의 사번, 사원명, 급여를 출력하시오.
*/

-- 과제1) 10번 부서에 속하는 사원의 부서번호, 업무, 지역명을 출력하시오.
-- EQUI JOIN 1-1
SELECT employee.dno 부서번호, employee.job 업무, department.loc 지역명
FROM employee, department
WHERE employee.dno = 10 -- JOIN
AND employee.dno = department.dno;

-- EQUI JOIN 1-2 : 해당 테이블에만 존재하는 필드는 생략 가능
SELECT employee.dno 부서번호, job 업무, loc 지역명
FROM employee, department
WHERE employee.dno = 10
AND employee.dno = department.dno;

-- EQUI JOIN 1-3 : 테이블에 대한 alias를 사용하여 표현
SELECT e.dno 부서번호, e.job 업무, d.loc 지역명
FROM employee e, department d
WHERE e.dno = 10
AND e.dno = d.dno;

-- EQUI JOIN 1-4 : 해당 테이블에만 존재하는 필드는 alias를 사용하여 표현
SELECT e.dno 부서번호, job 업무, loc 지역명
FROM employee e, department d
WHERE e.dno = 10
AND e.dno = d.dno;

-- natural join 
SELECT 

-- 과제2) 업무가 'ANALYST'인 사원의 사번, 사원명, 업무, 부서번호, 부서명, 지역명을 출력하시오.
-- EQUI JOIN 1-1
SELECT employee.eno 사번, employee.ename 사원명, employee.job 업무, employee.dno 부서번호, department.dname 부서명, department.loc 지역명
FROM employee, department
WHERE job = 'ANALYST'
AND employee.dno = department.dno;

-- EQUI JOIN 1-2
SELECT eno 사번, ename 사원명, job 업무, employee.dno 부서번호, dname 부서명, loc 지역명
FROM employee, department
WHERE job = 'ANALYST'
AND employee.dno = department.dno;

-- EQUI JOIN 1-3
SELECT e.eno 사번, e.ename 사원명, e.job 업무, e.dno 부서번호, d.dname 부서명, d.loc 지역명
FROM employee e, department d
WHERE job = 'ANALYST'
AND e.dno = d.dno;

-- EQUI JOIN 1-4
SELECT eno 사번, ename 사원명, job 업무, e.dno 부서번호, dname 부서명, loc 지역명
FROM employee e, department d
WHERE job = 'ANALYST'
AND e.dno = d.dno;

-- natural join
SELECT eno 사번, ename 사원명, job 업무, dno 부서번호, dname 부서명, loc 지역명
FROM employee NATURAL JOIN department
WHERE job = 'ANALYST';

-- join ~ using
SELECT eno 사번, ename 사원명, job 업무, dno 부서번호, dname 부서명, loc 지역명
FROM employee JOIN department USING(dno)
WHERE job = 'ANALYST';

-- join ~ on
SELECT eno 사번, ename 사원명, job 업무, e.dno 부서번호, dname 부서명, loc 지역명
FROM employee e JOIN department d ON e.dno = d.dno
WHERE job = 'ANALYST';


-- 과제3) 'SCOTT'과 동일한 부서에서 근무하는 사원의 사원명, 부서번호, 부서명을 'SCOTT'을 제외하고 출력하시오.
-- EQUI JOIN 1-1
SELECT employee.ename 사원명, employee.dno(SELECT dno FROM employee WHERE dno`  부서번호, department.dname 부서명
FROM employee, department
WHERE ename NOT IN 'SCOTT'
AND employee.dno = department.dno;








SELECT * FROM employee;

