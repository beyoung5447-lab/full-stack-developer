select * from emp;
/*
where 조건문
sql에서 select이 데이블에서 데이터를 열단위로 가져오는 것이라면
where은 데이터를 행단위로 filterling하는 개념이라고 할 수 있다.
기본형식
where 컬럼 비교 연산자 비교할 데이터, 컬럼
where sal >=2000 급여가 2000이상인 데이터를 가져와라
where 비교연산식 논리연산자 비교연산식 
두가지 이상의 비교연산자를 논리연사자(and, or, not)을 이용하여
논리값의 결과를 가져오는 것을 말한다.
where sal >= 2000 and sal <= 3000 3000 사이의 데이터를 가져와라
where 컬럼명 내장키워드연산자 컬럼명
내장된 키워드: between, in 
연산자
프로그래밍에서 ==가 true 처리가 된다(대입연산자)
하지만 sql에서는 = 이다.
> 보다 클때 < 보다 작을때 >= 크거나 같을때 <= 작거나 같을때 
!=, <> 다를때
select * from emf;
select *
from emp
where sal >=3000! 급여가 3000이상인 사원정보를 출력
select * from emp where ename = 'smith' 사원명이 smith인 사람 출력
select ename, jod, deptno from emp where deptno !=10 
부서번호가 10이 아닌 사원의 이름, 직책, 부서번호 출력
직책이 "clerk"인 사원정보를 출력하세요.
SELECT *
FROM emp
WHERE UPPER(job) = 'CLERK';
SELECT *
FROM emp
WHERE LOWER(job) = 'clerk';
사원번호가 7499인 사원의 사원번호, 사원명, 직책을 출력하세요
SELECT empno, ename, job
FROM emp
WHERE empno = 7499;
부서번호가 30인이 아닌 사원정보를 사원번호, 직책명, 부서번호를 출력하세요.
SELECT empno, job, deptno
FROM emp
WHERE deptno != 30;
데이터는 반드시 대소문자를 구분하여 처리
논리연산자
비교연산자와 함수 논리 연산자는 비교연산으로 조합하여 만든 연산자들 말한다.
and  모든 연산식이 true일 때 처리되는 것으로 깐깐한 조건일때 사용된다.
sal >= 1000 and sal  <= 3000 급여가 3000이상이고 급여가 3000이하일 때
or: 하나라도 연산식이 true일 때 처리되는 것으로 느슨한 조건일때 사용된다.
deptno: 10 0r job = 'clerk'부서번호가 10이거나 직책이 clerk인 경우
no: 해당 비교/논리연산식의 반대 연산 핕터링값을 가져온다.
not(deptno = 20) 부서번호가 20이지 않는 조건 데이터르 모두 가져올때 사용
select enmae, sal
from emp
where sal >= 1000 and sal < = 3000;
select ename, deptno, job
from emp
where deptno = 10 or job = 'clerk'
select *
from emp
where not(deptno=20);
직책이 "salesman"이면서 월급이 1000 -20000인 사원 정보를 출력
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND sal >= 1000 
  AND sal <= 20000;
부서번호가 10번이 아니고 직책도 "clerk"이 아닌 사람의 정보를 사원번호, 부서번호, 직책명으로 출력
SELECT empno, deptno, job
FROM emp
WHERE deptno != 10 
  AND job != 'CLERK';
  사원 번호가 7500 미만이고 급여가 2000이상의 해당 하지 않는 사원 정보
  SELECT *
FROM emp
WHERE empno >= 7500 
   OR sal < 2000*/
*/