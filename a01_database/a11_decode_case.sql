select * from emp;
/*DECODE 함수
=========================================
DECODE 함수는 오라클(ORACLE)에서만 지원하는 아주 강력하고 편리한 함수입니다.
IF-THEN-ELSE 논리를 SQL 문장 안에서 아주 짧고 간결하게 구현할 수 있도록 해줍니다.
단순 CASE WHEN 구문과 역할이 100% 동일하지만, 코드를 훨씬 짧게 작성할 수 있습니다.
기본 형식
 SELECT DECODE(컬럼명또는표현식, 
               조건값1, 처리결과1,
               조건값2, 처리결과2,...
               기본결과)
 FROM 테이블명;
컬럼명또는표현식 : 비교할 대상
조건값1 : 대상과 같은지 비교할 값
처리결과1 : 조건값1과 같을 때 반환할 값
기본결과 : 위 나열된 조건값들과 일치하는 것이 없을 때 반환할 값 (ELSE 역할, 생략 시 NULL 반환)
특징 및 주의사항
DECODE는 동등 비교(=)만 가능합니다. (크다, 작다 등 부등호 사용 불가)
부등호나 복잡한 조건(IS NULL, AND, OR 등)이 필요할 때는 반드시 CASE WHEN을 사용해야 합니다.

데이터의 조건문 처리 decode, case when
부서 번호별로 부서명 출력
SELECT 
    ename AS "사원명",
    deptno AS "부서번호",
    DECODE(deptno, 
           10, 'ACCOUNTING',
           20, 'RESEARCH',
           30, 'SALES',
           40, 'OPERATIONS',
           '기타') AS "부서명"
FROM emp;
job을 기준으로 clerk일때는 15%, salesman일때는 20%,manager 10%, analyst 9%, 그외는 5%
를 보너스를 주기로 했다. 사원명, 직책, 보너스를 출력 하세요.
SELECT 
    ename AS "사원명",
    job AS "직책",
    sal AS "급여",
    DECODE(UPPER(job),
        'CLERK',    sal * 0.15,
        'SALESMAN', sal * 0.20,
        'MANAGER',  sal * 0.10,
        'ANALYST',  sal * 0.09,
        sal * 0.05
    ) AS "보너스"
FROM emp;
mod를 활용해서 사원번호가 2로 나누었을때 0이면 홈팀 1이면 청팀으로 사원번호, 팀을 출력
SELECT 
    ename AS "사원명",
    empno AS "사원번호",
    DECODE(MOD(empno, 2), 0, '홈팀', '청팀') AS "팀"
FROM emp;
csse when 구문
해당 구문은 조건에 따라 다른 값을 반환하는 구문입니다. sql 쿼리내에서 
다양한 조건을 평가 하여 해당 조건에 맞는 값을 출력 하거나 계산 할 수 있습니다. case when은 
주로 select, update, delete 구문에서 조건을 설정 할때 사용합니다.
유형에 따른 구분
단순 case 구문(simple case expression)
단순 case 구문은 특정 컬럼의 값을 다른 값과 비교 하여 결과를 반환 합니다.
해당 방식은 주어진 값과 일치하는 조건을 찾아서 대응되는 값을 변환하는 방식
기본 형식
select case 컬럼명
when 값1 then 처리결과1
when 값2 then 처리결과2
......elese 처리결과 마지막
from  테이블명
컬럼명: 비교할 컬럼
값1,값2.........: 조건에 해당하는 값을 반환
처리 결과 마지막: 위의 나열된 when값이 아닐때 처리할 값
검색 case 구문
해당 구문은 복잡한 조건을 평가하여 여러 조건에서 참인 조건을 찾아 결과를 반환
해당 방식은 조건식을 사용할수도 있어 더 유연하고 복잡한 로직을 처리 할 수 있다.
기본형식
when 조건 1 then  결과1
when 조건 2 then 결과2
....
else 기본결과
end
from 테이블명
조건1, 조건2: 평가할 조건식
결과1, 결과2: 조건이 참일때 반환될 값
기본 결과: when 구문의 조건에 해당 하지 않을때 반환되는 기본값
CASE WHEN에서 NULL처리
        CASE WHEN 구문에서 NULL을 처리할 때도 매우 유용합니다. 예를들어, 특정 컬럼 값이 NULL인 경우 
        다른 값을 출력하거나 조건을 적용할 수 있습니다.
       
기본 형식
     SELECT CASE
                WHEN 컬럼 IS NULL THEN '처리할문자열1'
                WHEN 조건 THEN '처리할문자열2'
                ELSE '처리할문자열3'
            END 
       FROM 테이블명
     컬럼 IS NULL : 데이터가 없을 때, '처리할문자열1'로 수행 처리
     그외 조건일 때 처리할 문자열2로 수행
     위 나열된 조건 이외일 대, 처리할 문자열3으로 수행
 select ename, deptno,
        case deptno
           when 10 then '인사부'
           when 20 then ' 회계부'
           when 30 then '아이티부'
           else '기타부서'
        end "부서명"
from emp;    
mgr 기준으로 7839이면 고위직 7566 중간관리직 그외는 일반직원으로 case when 구문으로 
사원정보에서 관리자 구분 출력
SELECT 
    ename AS "사원명",
    empno AS "사원번호",
    mgr AS "상사번호(MGR)",
    CASE mgr
        WHEN 7839 THEN '고위직'
        WHEN 7566 THEN '중간관리직'
        ELSE '일반직원'
    END AS "관리자 구분"
FROM emp;
급여의 범위별로 고임금자(5000이상), 중간임금자(5000 미만 3000이상), 저임금자(3000미만)로 나누어 처리하라
SELECT 
    ename AS "사원명",
    sal AS "급여",
    CASE 
        WHEN sal >= 5000 THEN '고임금자'
        WHEN sal >= 3000 THEN '중간임금자'
        ELSE '저임금자'
    END AS "임금 구분"
FROM emp;
회사에서 체육 대회를 개최 하는데 사원번호를 기준으로 나누기로 함. 홍팀: 7654 이상, 청팀: 7654 초과 7839 이하
그외는 백팀 사원번호, 사원명, 팀구분을 출력
SELECT 
    empno AS "사원번호",
    ename AS "사원명",
    CASE 
        WHEN empno > 7654 AND empno <= 7839 THEN '청팀'
        WHEN empno > 7839 THEN '홍팀'
        ELSE '백팀'
    END AS "팀구분"
FROM emp;
comm 기준으로 null 이면 보너스 없음, 500 이상이면 고급보너스, 그외는 하급 보너스
SELECT 
    ename AS "사원명",
    sal AS "급여",
    comm AS "원래 보너스",
    CASE 
        WHEN comm IS NULL THEN '보너스 없음'
        WHEN comm >= 500  THEN '고급보너스'
        ELSE '하급 보너스'
    END AS "보너스 구분"
FROM emp;
mgr을 기준으로 null일때 최고관리자, 7389일때는 중간관리자, 그외는 일반 사람으로 처리해서
사원명, 관리자번호, 관리자분류로 출력
SELECT 
    ename AS "사원명",
    mgr AS "관리자번호",
    CASE 
        WHEN mgr IS NULL THEN '최고관리자'
        WHEN mgr = 7839  THEN '중간관리자'
        ELSE '일반 사람'
    END AS "관리자분류"
FROM emp;
*/