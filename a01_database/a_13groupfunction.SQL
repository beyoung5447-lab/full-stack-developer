select * from emp;
/* 그룹함수/집계함수
그룹함수는 여러 행의 데이터를 묶어 하나의 결과 값을 변환
하는 함수입니다. 테이블 전체를 하나의 덩어리로 보거나 
부서별/ 직급별등 특정 기준으로 나누어 계산할때 사용합니다.
count: 데이터의 총 건수
sum: 데이터의 합계 반환
avg: 데이터의 평균 반환
max: 데이터 중 최대값 반환
min: 데이터 중 최소값 반환
특징및 주의사항
그룹 함수는 계산 할때 기본적으로 null 값을 무시합니다.
단, count는 null 값 여부와 상관없이 무조건 테이블 전체 
행 수를 셉니다. 그룹 함수 결과와 일반 컬럼을 select절에
함께 출력하려면 반드시 'group by'절이 필요합니다
where절에서는 그룹 함수를 조건으로 사용할 수 없습니다. 
(대신 having절 사용)
기본형식
select 기준컬럼, 그룹함수명()
from 테이블
group by 기준컬럼
having 그룹함수의 조건
select deptno, sal
from emp
order by deptno;
select deptno, count(sal)
from emp
group by deptno
order by deptno; 
SELECT DEPTNO, SUM(SAL), AVG(SAL), MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
-- 전체 함수 처리
SELECT COUNT(), SUM(SAL)
FROM EMP;
위 그룹함수 선언 기본규칙에 의해서 직책별, 건수, 최대 급여, 최소급여 출력
SELECT job, 
       COUNT(*) AS employee_count, 
       MAX(sal) AS max_sal, 
       MIN(sal) AS min_sal
FROM emp
GROUP BY job
ORDER BY job;
having group by에서 묶인 결과에 조건을 둘때 사용하는 절입니다.
where 절과 having 절의 차이점
where 절은 데이터를 그룹으로 묶기 전 개별 행을 필터링 함
having 절은 데이터를 그룹으로 묶은 후 그룹의 집계 결과에 조건을 부여함
select DEPTNO, max(SAL)
from EMP
group by DEPTNO; 

select deptno, max(SAL)
from  emp
group by DEPTNO
having max(SAL) >= 3000;
직책별로 급여의 평균을 구하되 평균 급여가 2000이상인 데이터를 출력
SELECT job, 
       AVG(sal) AS avg_sal
FROM emp
GROUP BY job
HAVING AVG(sal) >= 2000
ORDER BY avg_sal DESC;
그룹 함수내 null 데이터 통계치 처리
그룹 함수에서 *는 하나의 컬럼이 아니라 전체 컬럼 기준으로 확인할 때 사용한다
그룹 함수 적용에 있어서 null값을 제외되기 때문에 위와 같이 전체 통계치를 사용할때는 *를
사용한다.alter
사원정보의 전체 건수
select count(*)
from emp;
select count(mgr)
from emp;
SELECT sum(comm) AS sum_count
FROM emp;
SELECT avg(comm) AS avg_count
FROM emp
사원정보 테이블을 기준으로 재무팀에서 이번 달 직원들에게 지급될 커미션의 총합을 구하려고 한다
커미션이 책정 되지 않아 comm값이 null인 직원 때문에 계산시 에러가 발생할까? 총합을 구하는 sql과
함께 예상되는 결과를 정리해보자.
사장님이 묻습니다. "인사팀에서 올린 커미션(COMM) 평균은 커미션을 받는 4명만의 평균이잖아! 
나는 전체 직원 14명을 기준으로 한 커미션 평균이 궁금하네. 
커미션을 못 받는 직원은 0원으로 계산해서 진짜 회사 전체의 커미션 평균을 구해보게!"
NULL 값을 무시하지 않고 0으로 바꾸어 전체 직원 기준으로 평균을 계산하려면 
어떤 함수를 조합해야 할까요? SQL을 작성해 보세요.
SELECT AVG(NVL(comm, 0)) AS total_emp_avg_comm
FROM emp;
*/