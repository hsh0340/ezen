-- 1번
select ename, salary, commission 
from employee 
where commission is not null 
order by salary desc, commission desc;

-- 2번
select ename, salary, dno
from employee 
where salary between 2000 and 3000 and dno in(20, 30) 
order by ename;

-- 3번
select ename, job, salary 
from employee 
where job in('CLERK', 'SALESMAN') and salary not in(1300, 1600) 
order by salary desc;

-- 4번
select eno, ename 
from employee 
where ename not like '%A%' and ename not like '%E%' 
order by eno;

-- 5번
select ename 사원명, salary 급여, salary*12+nvl(commission,0) 연봉 
from employee 
order by 연봉 desc;

-- 6번
select * 
from employee 
where substr(hiredate,4,2) = 09;

-- 7번
select eno 사번, ename 사원명, job 직무, salary 급여, case 
when job = 'ANALYST' then salary + 200 
when job = 'SALESMAN' then salary + 180 
when job = 'MANAGER' then salary + 150
when job = 'CLERK' then salary + 100
end "인상된 급여" 
from employee;

-- 8번
select dno 부서번호, count(*) 사원수, sum(salary) 급여총액 
from employee 
group by dno 
having sum(salary) >= 10000;

-- 9번
select job 직급별, min(salary) 최저급여 
from employee 
where manager is not null 
group by job 
having not min(salary) < 2000 
order by 최저급여 desc;

-- 10번
select dno 부서별, count(ename) 사원수, round(avg(salary),2) 평균급여 
from employee 
group by dno 
order by dno;