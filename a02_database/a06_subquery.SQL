select * from emp;
/*
서브쿼리
서브쿼리란 sql문 내에서 다른 sql문을 내부 쿼리로 포함하여
그 결과를 외부 쿼리의 조건이나 데이터로 사용하는 방식입니다. 서브쿼리는 가상의 테이블 처럼
작동 하며 복잡한 데이터를 처리할 때 매우 유용합니다. 서브쿼리는 조건문의 값으로 사용 하거나
테이블을 가상으로 만들어서 다른 테이블과 조인 하는데 사용할 수 있습니다. 서브쿼리의 결과는
외부 쿼리에서 처리된 데이터를 기반으로 다른 작업을 수행 하는데 도움을 줍니다
서브쿼리 기본 형식
서브쿼리는 where, from, select절에서 사용될 수 있습니다. 각기 다른 상황에 맞는 서브쿼리 
사용 방법을 아래에서 다뤄 보겠습니다.
조건문의 데이터로 사용되는 서브쿼리
서브쿼리를 조건문에서 사용하면 먼저 내부 쿼리를 데이터를 조회한 후 
결과를 외부 쿼리에서 사용하여 조건을 적용합니다. 
select max(SAL) from emp;
SELECT *
FROM EMP
WHERE SAL = (SELECT MAX(SAL) FROM EMP);
최저 급여자의 min()의 정보를 위와 같이 subquery를 이용해서 출력 하세요.
SELECT *
FROM EMP
WHERE SAL = (SELECT MIN(SAL) FROM EMP);
사원중에 가장 마지막에 입사한 사원의 정보를 출력
SELECT *
FROM EMP
WHERE HIREDATE = (SELECT MAX(HIREDATE) FROM EMP);
*/
