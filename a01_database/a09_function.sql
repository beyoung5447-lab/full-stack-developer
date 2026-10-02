select * from emp;
오라클 함수
ORACLE의 함수는 데이터베이스 내에서 데이터를 처리하고 계산하는 데, 중요한 역할을 합니다.
SQL 함수는 데이터를 변환하거나 계산하여 원하는 결과를 도출하는 데 사용합니다. 함수는 크게 집계합수,
문자열함수, 수학함수, 날짜 함수 등으로 구분할 수 있습니다.
    1) 스칼라 함수 : 하나의 입력값을 받아서 하나의 출력 값을 반환하는 함수 입니다.
        예를들어 UPPER, LOWER, ROUND, TRUNC 등이 있다.
    2) 집계 함수 : 여러 개의 입력 값들을 처리하여 하나의 출력 값을 반환하는 함수입니다.
        예를들어 SUM, COUNT, AVG, MAX, MIN 등이 있다.
ORACLE 함수의 분류 기준
 1) 문자열 함수(String Functions) : 문자열 데이터를 처리하는 함수입니다. 주로 텍스트의 조작,
     변환 등을 수행합니다.
     ex) UPPER, LOWER, SUBSTR, CONCAT
 2) 수학 함수(Mathematical Functions) : 숫자 데이터를 처리하는 함수로, 숫자 계산이나 반올림
     내림 등을 수행합니다.
     ex) ROUND, CEIL, FLOOR, MOD
 3) 날짜 함수(Date Functions) : 날짜와 시간을 처리하는 함수입니다. 날짜 간의 차이 계산, 날짜
     포맷 조정 등을 수행합니다.
     ex) SYSDATE, TO_DATE, ADD_MONTHS, MONTHS_BETWEEN
 4) 집계 함수(Aggregate Functions) : 여러 개의 값들을 처리하여 하나의 결과값을 반환하는 함수
     ex) SUM, COUNT, AVG, MAX, MIN
 5) 변환 함수(Conversion Functions) : 데이터 타입을 변환하는 함수입니다.
     ex) TO_NUMBER, TO_CHAR, TO_DATE


*/
-- 문자열 함수 
-- lower, upper : 모두다 소문자로 변경, substr(컬럼, 시작, 마지막): 추출함수
-- 사원 이름을 모두 소문자로 바꾸거나, 첫 3글자만 잘라서 데이터를 확인
SELECT ENAME, LOWER(ENAME), SUBSTR(ENAME, 1, 3)  FROM EMP;
-- 문자열 함수 
-- lower, upper : 모두다 소문자로 변경, substr(컬럼, 시작위치, 갯수): 추출함수
-- 사원 이름을 모두 소문자로 바꾸거나, 첫 3글자만 잘라서 데이터를 확인
SELECT ENAME, LOWER(ENAME), SUBSTR(ENAME, 2, 3)  FROM EMP;
SELECT * FROM EMP;
-- EX1) JOB명도 소문자로 변환하고, JOB도 2번째부터 2글짜만 추출해서 처리하라.
-- EX2) 이름 숨바꼭질
/*
사원들의 이름(ENAME)을 출력하되, 이름의 첫 글자만 남기고 나머지는 전부 '*'로 가려서 보여주세요. 
편의상 뒤에 별 4개를 붙인다고 가정하고 SUBSTR 함수와 문자열 결합 기호(||)를 사용해 보세요. (예: SMITH -> S**)
*/
양현수 강사 — 10:38 AM
-- EX1) JOB명도 소문자로 변환하고, JOB도 2번째부터 2글짜만 추출해서 처리하라.
SELECT JOB, LOWER(JOB), SUBSTR(JOB,2, 2) 
FROM EMP;
-- EX2) 이름 숨바꼭질
/*
사원들의 이름(ENAME)을 출력하되, 이름의 첫 글자만 남기고 나머지는 전부 '*'로 가려서 보여주세요. 
편의상 뒤에 별 4개를 붙인다고 가정하고 SUBSTR 함수와 문자열 결합 기호()를 사용해 보세요. (예: SMITH -> S**)
*/
SELECT ENAME,
       SUBSTR(ENAME, 1, 1) 
 '**' HIDDEN_NAME
FROM EMP;
양현수 강사 — 10:47 AM
/*
수학 및 함수 처리
CEIL() : 올림처리, FLOOR():내림처리, ROUND() 반올림처리, MOD(컬럼, 나머지단위) 나머지값 처리
/
SELECT SAL, SAL/3 "기본3나누기", CEIL(SAL/3) "올림", FLOOR(SAL/3) "내림", ROUND(SAL/3) "반올림", 
        MOD(SAL, 3) "3으로나눈나머지"
FROM EMP;
/
ex1)사원번호(EMPNO)가 홀수인지 짝수인지 알기 위해 2로 나눈 나머지(MOD) 구하기
-- 2로 나누었을 때 남는 숫자가 0이면 짝수, 1이면 홀수입니다.
-- 홀수 사원만 조회
SELECT empno, ename
FROM emp
WHERE MOD(empno, 2) = 1;

-- 짝수 사원만 조회
SELECT empno, ename
FROM emp
WHERE MOD(empno, 2) = 0;
ex2)(급여 지급 룰).
-- 이번 달 급여(SAL)를 줄 때, 100달러 단위 밑으로는 무조건 깎아서(내림) 주기로 했습니다.
-- 즉, 2450달러라면 2400달러만 줍니다. 어떻게 계산할까요?
-- (먼저 100으로 나누고 내림을 한 뒤, 다시 100을 곱해줍니다.)
SELECT 
    ename,
    sal AS original_sal,
    TRUNC(sal / 100) * 100 AS pay_sal
FROM emp;
SYSDATE: 데이터베이스 서버의 '현재 시간'을 알려주는 전자시계입니다. 
(예: 지금 당장 몇 년/월/일/시/분/초 인지 확인)
TO_DATE: 평범한 글자(텍스트)를 데이터베이스가 계산할 수 있는 '진짜 달력 날짜'로 변신시켜 줍니다.
(예: "2024-12-25"라는 단순한 글자를 진짜 크리스마스 날짜로 인식하게 만듦)
ADD_MONTHS: 특정 날짜에서 원하는 개월 수만큼 달력을 휙휙 넘겨서 미래나 과거의 날짜를 찾아냅니다. 
(예: 오늘부터 딱 6개월 뒤는 며칠일까?)
MONTHS_BETWEEN: 두 날짜 사이에 달력이 몇 장이나 있는지(총 몇 개월 차이인지)
자로 재듯 정확히 계산해 줍니다. (예: 입사일부터 오늘까지 총 몇 달을 일했을까?)

핵심코드 연관관계에 의한 암기법
날짜 함수는 달력에 쾅쾅 찍는 "STAM(스탬프)" 로 기억하세요! 흐름대로 이어집니다.
S (SYSDATE - Start): 우선 현재 시간을 기준점으로 잡습니다.
T (TO_DATE - Transform): 글자로 적힌 과거나 미래의 특정 시점을 날짜로 변환해 준비합니다.
A (ADD_MONTHS - Add): 기준 날짜에서 달력을 넘기며(개월 수를 더해) 새로운 날짜로 이동해 봅니다.
M (MONTHS_BETWEEN - Measure): 그렇게 생성된 두 날짜 사이의 간격(차이)이 얼마나 되는지 측정합니다.
dual: 오라클에서 지원하는 가상테이블(연산이나, 데이터를 간단하게 확인할때 사용)
SELECT 
    SYSDATE AS "현재 날짜와 시간", 
    SYSDATE - 1 AS "전날", 
    SYSDATE + 1 AS "내일" 
FROM dual;
sysdate, 날짜 데이터
기본 연산 기준 : 날짜 데이터에 더하기, 빼기 연산이 가능하다
날짜 데이터 + 숫자: 해당 일자에 일수를 가산하여 처리가 된다
날짜 데이터 + 1?/24: 시간 단위+ 1시간 처리가 된다
결국 +1은 일단위이기에 이것을 
/24: 시간 단위
/60: 분 단위
/60: 초 단위로 처리가 된다
현재 시간 처리에서 sysdate를 처리 하는 내장된 객체
SELECT 
    empno,
    ename,
    TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') AS "입사일",
    TO_CHAR(hiredate - 1, 'YYYY-MM-DD HH24:MI:SS') AS "입사일 -1일(전날)",
    TO_CHAR(hiredate + 1, 'YYYY-MM-DD HH24:MI:SS') AS "입사일 +1일(내일)"
FROM emp;
emp 입사일 기준으로 입사일 하루전, 입사일 5일후, 입사일 기준으로 5시간전을 출력
SELECT 
    empno,
    ename,
    TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') AS "입사일",
    TO_CHAR(hiredate - 1, 'YYYY-MM-DD HH24:MI:SS') AS "1일 전",
    TO_CHAR(hiredate + 5, 'YYYY-MM-DD HH24:MI:SS') AS "5일 후",
    TO_CHAR(hiredate - (5/24), 'YYYY-MM-DD HH24:MI:SS') AS "5시간 전"
FROM emp;
월단위로 증가 또는 감소
add_months(기준 날짜데이터, 증/감 개월 수): 특정 추가 개월 수 후에 날짜를 가져다 준다
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 3) "입사 3개월후", ADD_MONTHS(HIREDATE, -2) "입사2개월전"
FROM EMP;
사원정보를 기준으로 사원명과 입사일, 입사후 3개월후가 인턴 마지막 날이라고 할때 해당 날짜를 
처리 하여 출력 하세요. 사원명, 입사일, 인턴 마지막날.
SELECT 
    ename AS "사원명",
    TO_CHAR(hiredate, 'YYYY-MM-DD') AS "입사일",
    TO_CHAR(ADD_MONTHS(hiredate, 3) - 1, 'YYYY-MM-DD') AS "인턴 마지막날"
FROM emp;
위의 내용에서 추가하여 정규직 첫째날도 출력
사원명, 정규직 첫째날
SELECT 
    ename AS "사원명",
    TO_CHAR(ADD_MONTHS(hiredate, 3), 'YYYY-MM-DD') AS "정규직 첫째날"
FROM emp;
월단위 특정한 월 사이를 월기준(1개월 -1,15일 -0.5 표현
날짜 1, 날짜 2 사이의 개월 수를 계산 하여 숫자로 리턴한다. 1개월 단위로 1이 리턴 되므로
만약 해당 월의 중간이라면 0.5가 리턴된다.
기본 형식
months _ betweens(날짜 데이터1, 날짜데이터2)
주의) 날마다 날짜가 28,29,30,31인 경우가 있어서 이를 반영하여 날짜 사이를 개월로 계산하여
실수값을 리턴 해준다
SELECT 
    SYSDATE AS "현재 날짜",
    MONTHS_BETWEEN(SYSDATE + 30, SYSDATE) AS "현재와 30일 개월 수"
FROM dual;
입사후 45일 후는 몇 개월 차이인지(소수점까지 표현)
SELECT 
    ename AS "사원명",
    TO_CHAR(hiredate, 'YYYY-MM-DD') AS "입사일",
    TO_CHAR(hiredate + 45, 'YYYY-MM-DD') AS "입사 45일 후",
    MONTHS_BETWEEN(hiredate + 45, hiredate) AS "개월 수 차이"
FROM emp;
사원명, 입사일, 입사일로  15일후 개월수, 
위 내용에 추가 하여 입사일로 부터 30일 전과 입사일과 개월 수를 표시하라.
SELECT 
    ename AS "사원명",
    TO_CHAR(hiredate, 'YYYY-MM-DD') AS "입사일",
    
    -- 1. 입사일 기준 15일 후 날짜 및 개월 수
    TO_CHAR(hiredate + 15, 'YYYY-MM-DD') AS "15일 후 날짜",
    ROUND(MONTHS_BETWEEN(hiredate + 15, hiredate), 2) AS "15일 후 개월수",
    
    -- 2. 입사일 기준 30일 전 날짜 및 개월 수
    TO_CHAR(hiredate - 30, 'YYYY-MM-DD') AS "30일 전 날짜",
    ROUND(MONTHS_BETWEEN(hiredate, hiredate - 30), 2) AS "30일 전 개월수"
FROM emp;
next_day(기준일, 요일)
해당 날짜를 기준으로 명시된 요일이 첫 날짜를 반환하는 함수
오늘로 부터 다가오는 첫 일요일의 날짜?
SELECT SYSDATE "오늘", NEXT_DAY(SYSDATE, '일') "다가올 첫 일요일", NEXT_DAY(SYSDATE,'수') "다가올 첫 수요일"
FROM DUAL;
emp의 입사일 기준으로 사원명과 입사일 입사후 첫번째 토요일을 출력 하세요
-- 언어 설정에 구애받지 않고 숫자로 처리할 경우 (7 = 토요일)
SELECT 
    ename AS "사원명",
    TO_CHAR(hiredate, 'YYYY-MM-DD') AS "입사일",
    TO_CHAR(NEXT_DAY(hiredate, 7), 'YYYY-MM-DD') AS "첫번째 토요일"
FROM emp;
 last_day
 해당 날짜가 속한 달의 마지막 날짜
 SELECT 
    SYSDATE AS "현재 날짜",
    LAST_DAY(SYSDATE) AS "이번달 마지막일",
    LAST_DAY(SYSDATE) + 1 AS "다음달 첫날"
FROM dual;
입사할 날짜에 속한 마지막 날짜와 그 다음 날을 출력하되 급여일이 입사한 날짜의 다음날 10일째
되는 날이라고 할 때 해당 사원의 첫급여일을 출력
SELECT 
    ename AS "사원명",
    TO_CHAR(hiredate, 'YYYY-MM-DD') AS "입사일",
    TO_CHAR(LAST_DAY(hiredate), 'YYYY-MM-DD') AS "입사월 마지막날",
    TO_CHAR(LAST_DAY(hiredate) + 1, 'YYYY-MM-DD') AS "다음달 1일",
    TO_CHAR(LAST_DAY(hiredate) + 10, 'YYYY-MM-DD') AS "첫 급여일(다음달 10일)"
FROM emp;
*/