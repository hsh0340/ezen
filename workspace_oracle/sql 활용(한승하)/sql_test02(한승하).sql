select eno, ename, salary, e.dno, dname
from employee e, department d
where e.dno = d.dno
and salary >= 2000
order by dno;

select ename, job, hiredate, dname, loc
from employee join department using(dno)
where substr(hiredate, 4, 2) = 12
order by ename;

select o.ename, o.hiredate
from employee w, employee o
where w.hiredate > o.hiredate
and w.ename = 'MARTIN'
order by o.hiredate desc;

select e.ename 사원명, e.eno 사번, m.ename 관리자명, m.eno 관리자번호
from employee e left outer join employee m
on e.manager = m.eno
order by 사번;

select *
from employee
where salary < (select salary from employee where ename = 'ALLEN');

select ename, job
from employee
where dno in (select dno from employee where job = 'ANALYST');

select eno, ename, salary
from employee
where dno in (select dno from employee where ename like '%A%')
and salary > (select avg(salary) from employee)
order by eno;

create table emp01
as select eno, ename, job, salary 
from employee;

desc emp01;

alter table emp01
modify (ename varchar2(12), job varchar2(10));

desc emp01;

drop table emp01;
select table_name from user_tables;