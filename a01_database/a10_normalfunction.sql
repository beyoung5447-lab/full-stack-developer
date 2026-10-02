select * from emp;
/* 자주 사용되는 오라클 기능함수
length
문자열의 길이를 반환
띄어쓰기 포함, 한글도 1글자씩 계산
기본형식
length()
lengthb 함수
문자열을 byte 단위로 반환
영문의 경우 1글자가 1byte이지만 한글의 경우 3byte 처리
기본형식
lengthb()
select 'hitman', length('hitman') "영문글자수", lengthb('hitman') "영문 byte"
from dual;
select '홍길동', length('홍길동') "한글자수", lengthb('홍길동') "한글 byte"
from dual;
직책의 글자수를 직책명, 직책의 글자수로 표현 하여 출력
SELECT DISTINCT 
    job AS "직책명",
    LENGTH(job) AS "직책 글자수"
FROM emp;
사원명과 사원을 글자수로 출력하되 길이가 5보다 큰 사람만 출력
SELECT 
    ename AS "사원명",
    LENGTH(ename) AS "사원명 글자수"
FROM emp
WHERE LENGTH(ename) > 5;
nvl(컬럼, 대체값)
컬럼 값이 null인 경우 지정한 대체값으로 변환하여 null을 의미 있는 값으로 치환
기본 형식
nvl(컬럼명/데이터, 대체할 값)
데이터 타입이 컬럼명과 일치 해야 함.
주로 select, 계산식, where절 등에서 사용된다.
보너스(comm)이 null이면 0으로 출력
SELECT 
    ename AS "사원명",
    sal AS "급여",
    comm AS "커미션",
    sal + comm AS "합산(NULL포함시 NULL)",
    NVL(comm, 0) AS "보너스가 NULL이면 0 처리",
    sal + NVL(comm, 0) AS "합산2(실제 수령액)"
FROM emp;
사람들의 보너스(comm)가 null인 경우를 0으로 처리 하여 0 초과 사원정보인 사원명, 급여, 보너스,
를 출력 하세요.
SELECT 
    ename AS "사원명",
    sal AS "급여",
    comm AS "원래 보너스",
    NVL(comm, 0) AS "보너스(NULL은 0)"
FROM emp
WHERE NVL(comm, 0) > 0;
사원 정보중에 직책을 출력 하되 직첵이 null인 경우 '미배정'으로 출력 하여 사원명, 직책으로 출력
SELECT 
    ename AS "사원명",
    NVL(job, '미배정') AS "직책"
FROM emp;
도서 정보중에 도서 아이디와 도서명을 출력 하되 null인 경우는 타이틀 없음으로 출력
SELECT 
    bookid AS "도서 아이디",
    NVL(bookname, '타이틀 없음') AS "도서명"
FROM book;
nullif(표현식1,표현식2)
표현식 1과 표현식2가 같으면 null, 다르면 표현식1만 반환
중복값을 제거 하거나 구분 할때 유용(컬럼 비교해서)
기본형식
nullif(표현식1, 표현식2)
decode(조건데이터 처리해주는 함수) 보다 간결하게 특정 비교 처리 가능
급여가 3000인 사원은 null 그외는 급여 출력
SELECT 
    ename AS "사원명",
    sal AS "원래 급여",
    NULLIF(sal, 3000) AS "급여(3000은 NULL)"
FROM emp;
job이 clerk인 경우 null
SELECT 
    ename AS "사원명",
    job AS "원래 직책",
    CASE 
        WHEN job = 'CLERK' THEN NULL 
        ELSE job 
    END AS "직책(CLERK은 NULL)"
FROM emp;
 부서번호가 10일때 null 그외는 부서번호를 출력해서 사원명, 부서번호를 출력 하세요.
 SELECT 
    ename AS "사원명",
    deptno AS "원래 부서번호",
    NULLIF(deptno, 10) AS "부서번호(10은 NULL)"
FROM emp;
0으로 나누기 오류
SELECT 
    ename AS "사원명",
    sal AS "급여",
    comm AS "커미션",
    sal / NULLIF(comm, 0) AS "급여대비 성과급 비율",
    NVL(sal / NULLIF(comm, 0), 0) AS "비율2(NULL은 0)"
FROM emp;*/SELECT 
    ename AS "사원명",
    sal AS "급여",
    comm AS "커미션",
    sal / NULLIF(comm, 0) AS "급여대비 성과급 비율",
    NVL(sal / NULLIF(comm, 0), 0) AS "비율2(NULL은 0)"
FROM emp;

