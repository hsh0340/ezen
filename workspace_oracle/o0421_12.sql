-- 2022/04/21

/*
< 프로시저 >
-- PL/SQL을 사용하여 자주 사용하는 쿼리문을 모듈화하여 필요할때마다 
 호출하여 사용한다, 재사용이 높아짐
 
< 프로시저의 장점 >
- 복잡한 SQL문을 단순화시켜 줌
- 반복해서 사용이 가능.

< 프로시저의 생성 >
CREATE OR REPLACE 프로시저명
    (변수 선언) -- 프로시저를 호출할 때 사용하는 매개변수, 프로시저를 호출하고 난 후의 결과값을 닫는 변수
IS
    변수 선언; -- 프로시저 안에서 사용되는 지역변수
BEGIN
    실행문;
    ...
END;
*/

-- 문제4) 사원 테이블에서 'SCOTT' 사원의 급여를 구하는 p_emp_salary를 작성하시오.
/*
-- 프로시저의 생성
CREATE OR REPLACE procedure p_emp01
IS
v_salary employee.salary%type;
BEGIN
    SELECT salary into v_salary
    FROM employee
    WHERE ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_line('SCOTT 사원의 급여는 ' || v_salary||'입니다.');
END;
*/

-- 프로시저 확인
SELECT * FROM user_procedures; -- 이름 확인
SELECT * FROM user_source; -- 내용 확인

-- 프로시저 사용
EXECUTE p_emp01;

-- 문제2) 사원 테이블에서 사원명을 매개변수로 받아서 해당 사원의 급여를 바로 출력하는
-- 프로시저를 생성하시오. (in 매개변수를 사용)
/*
create or replace procedure p_emp02
(v_ename in employee.ename%type) -- in 매개변수 : 호출할 때 값을 전달하는 매개변수
is
v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    DBMS_OUTPUT.put_line(v_ename||'사원의 급여는 '||v_salary||'입니다~');
end;
*/
-- 프로시저 확인
-- select * from user_procedures;
-- select * from user_source;

-- 프로시저 사용
/*
execute p_emp02('ALLEN');
execute p_emp02('JONES');
execute p_emp02('MILLIER');
execute p_emp02('TURNER');
*/

-- 문제3) 사원 테이블에서 사원명을 매개변수로 받아서 해당 사원의 급여를 리턴하는 프로시저를 생성하시오.
-- (in 매개변수, out 매개변수)
/*
CREATE OR REPLACE PROCEDURE p_emp03
    (
    v_ename IN employee.ename%type, -- 던져주는 매개변수
    v_salary OUT employee.salary%type -- 리턴
    ) 
IS
BEGIN
    SELECT salary INTO v_salary -- v_salary에 저장 
    FROM employee
    WHERE ename = v_ename;
END;
*/

-- 프로시저 확인
-- SELECT * FROM user_procedures;
-- SELECT * FROM user_source WHERE name = 'P_EMP03';

-- 프로시저 실행
-- 변수 선언: var(variable)
VAR v_salary NUMBER; -- 변수선언
EXECUTE p_emp03('SCOTT', v_salary);
PRINT v_salary;