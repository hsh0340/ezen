-- 2022/04/19(화) 10일차 수업

/*
< 동의어 > synonym
1. 동의어
- 데이터베이스 객체에 대한 별칭

2. 동의어의 종류
- 전용 동의어 : 개별 사용자를 대상으로 하는 동의어,
  객체의 접근 권한을 부여받은 사용자가 정의하고, 해당 사용자만 사용할 수 있음.
- 공용 동의어 : 전체 사용자를 대상으로 하는 동의어,
  dba 권한을 가진 사용자만 생성할 수 있음.
  권한을 주는 사용자가 정의한 동의어를 누구나 사용할 수 있음.
*/

/*
2. PL/SQL 구성 요소
declare -- 선언부 (선택)
begin -- 실행부 (필수)
exception -- 예외부 (선택)
end

3. PL/SQL의 구성 요소 설명
declare - 변수 또는 상수를 선언하는 부분 (선택)
begin - 조건문, 반복문, 함수 등을 선언해서 사용하는 부분 (필수)
exception - PL/SQL 실행 도중에 에러가 발생했을 때 처리하는 부분 (선택)

4. 변수
(1) 스칼라(Scalar) 변수 - 값을 가지는 일반적인 변수
- 숫자, 문자, 날짜, boolean
- 값을 할당하는 연산자 ( := )
(2) 레퍼런스(Reference) 변수 - 테이블의 컬럼을 참조하는 변수
- 테이블명.컬럼명%type -> 테이블의 컬럼 한개를 참조
- 테이블명%rowtype -> 테이블의 컬럼 전체를 참조
*/

SET SERVEROUTPUT ON; -- put_line() 함수를 사용하기 위함. 사용하기 전에 한번만 실행 
/*
BEGIN
    dbms_output.put_line('Welcome to Oracle!');
END;
*/

-- 사원 테이블에서 사번이 7788인 사원의 사번, 사원명, 업무, 급여를 출력하시오.
DECLARE
    v_eno NUMBER(4);
    v_ename employee.ename%TYPE;
    v_job employee.job%TYPE;
    v_salary employee.salary%TYPE;
BEGIN
    SELECT eno, ename, job, salary INTO v_eno, v_ename, v_job, v_salary
    FROM employee
    WHERE eno = 7788;
    dbms_output.put_line('사번 ' || '사원명 ' || '업무 ' || '연봉 '); 
    dbms_output.put_line(v_eno || ' ' || v_ename || ' ' || v_job || ' ' || v_salary); 
END;

DECLARE
    v_eno employee.eno%TYPE;
    