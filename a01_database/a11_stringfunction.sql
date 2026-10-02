select * from emp;
/*
문자열 주요 함수
문자열 데이터를 효과적으로 원하는 데이터 형식으로 처리 하는 것을 말한다.
instr() 함수
문자열 데이터에서 특정 문자열을 찾아 해당 위치를 인덱스로 반환하는 함수
대용량의 문자열에서 해당 문자열이 있는지 여부와 그 위치를 확인할때 주로 사용
기본형식
instr(문자열 데이터|컬럼, '검색문자'): 문자열의 처음부터 끝까지 검색
instr(문자열 데이터|컬럼, '검색문자',검색 시작 위치,검색마지막위치): 
지정된 위치부터 시작하여 특정 횟수만큼 검색하여 위치를 반환
직책에서 man이 포함된 경우 그 위치를 직책과 함께 출력
SELECT 
    ename AS "사원명",
    job AS "직책",
    CASE 
        WHEN INSTR(LOWER(job), 'man') > 0 THEN TO_CHAR(INSTR(LOWER(job), 'man'))
        ELSE '미포함'
    END AS "MAN 위치"
FROM emp;
사원명에 k가 포함된 경우 그 위치를 사원명과 함께 출력
SELECT 
    ename AS "사원명",
    CASE 
        WHEN INSTR(UPPER(ename), 'K') > 0 THEN TO_CHAR(INSTR(UPPER(ename), 'K'))
        ELSE '미포함'
    END AS "K의 위치"
FROM emp;
e가 들어간 데이터와 포함되지 않은 데이터를 구분하고 출력
SELECT 
    ename AS "사원명",
    CASE 
        WHEN INSTR(UPPER(ename), 'E') > 0 THEN 'E 포함'
        ELSE 'E 미포함'
    END AS "포함 여부",
    INSTR(UPPER(ename), 'E') AS "E 위치(0은 미포함)"
FROM emp;
 instr을 이용하여 직책에서 man이 포함된 데이터와 그 위치를 출력 하세요.
 사원명, 직책, 직책에서 man 키워드
 SELECT 
    ename AS "사원명",
    job AS "직책",
    INSTR(LOWER(job), 'man') AS "man 위치"
FROM emp
WHERE INSTR(LOWER(job), 'man') > 0;
select ename, job, instr(job, 'man') "man 위치"
from emp
where instr(job, 'man')>0;
특정한 문자열을 채워서 처리해야 하는 경우 lpad(), rapd()
문자열에서 특정 크기 이하일때 사용한 크기를 설정하여 다른 문자열로 채우서 처리 하는것을 말한다
예를 들면 크기가 10자리를 기준으로 해당 문자열보다 적으면 공백이나 '#'문자로 채워서 처리하고
크기보다 같거나 넣는 경우는 그대로 출력하게 할 필요성이 있을때 활용된다.
pad는 덧붙인다는 기본 키워드르 중심으로 left lpad는 ㅣpad로 right pad는 rpad로
기본형식
lpad(데이터, 기준크기, 왼쪽에 덧붙일 문자열)
rpad(데이터, 기준크기, 오른쪽에 덧붙일 문자열)
참고) 가변형 문자열을 고정할 문자열로 변환할때 이외의 자리수에 있는 문자를 특정문자로 채울때
사용된다.
-- 1. ename의 최대 글자 수 확인 (SCOTT.EMP 기준 결과: 6)
SELECT MAX(LENGTH(ename)) AS "최대 길이"
FROM emp;

-- 2. RPAD / LPAD를 활용한 문자열 패딩 처리
SELECT 
    ename AS "사원명",
    RPAD(ename, 6, '#') AS "변형된 사원명1",
    LPAD(ename, 6, '#') AS "변형된 사원명2"
FROM emp;
job 글자의 최대 크기를 위 sql에서 확인하고 job 글자의 최대 크기보다 작은 문자열 데이터 
왼쪽에 @로 채워서, 사원명, 직책명, @를 채운 직책명을 출력
SELECT 
    ename AS "사원명",
    job AS "직책명",
    LPAD(job, (SELECT MAX(LENGTH(job)) FROM emp), '@') AS "@를 채운 직책명"
FROM emp;
양쪽 끝에서부터 반복적으로 문자를 제거 하는 함수 lrim rtrim, trim
필요없는 문자열을 좌우에서 절삭해서 처리하는 함수
trim이라는 말은 절삭이라는 말로 왼쪽이나 오른쪽 끝에서 부터 반대 방향으로 특정한 문자열을
반복적으로 삭제할때 사용
주요기능함수
ltrim: 왼쪽 끝에서 부터 시작하여 제거할 문자를 반복적으로 없애준다
rtrim: 오른쪽 끝에서 부터 시작하여 제거할 문자를 반복적으로 없애준다.
trim('양쪽에 제거할 문자 처리, from 컬럼|데이터): 양쪽끝에서부터 반복적으로 제거할 문자 처리
SELECT 'AAAAAhimanAAAA' "기본문자",
        LTRIM('AAAAAhimanAAAA', 'A') "왼쪽 끝에서부터 A삭제",
        RTRIM('AAAAAhimanAAAA', 'A') "오른쪽 끝에서부터 A삭제",
        TRIM('A' FROM 'AAAAAhimanAAAA') "양쪽 끝에서부터 A삭제"
   FROM DUAL;
dual 키워드 이용해서 '@@@@@홍길동@@@@@' 데이터를 기준으로 왼쪽에 @ 삭제, 오른쪽 삭제, 
양옆 @ 삭제 처리를 출력
SELECT 
    '@@@@@홍길동@@@@@' AS "원본 데이터",
    LTRIM('@@@@@홍길동@@@@@', '@') AS "왼쪽 @ 삭제",
    RTRIM('@@@@@홍길동@@@@@', '@') AS "오른쪽 @ 삭제",
    TRIM('@' FROM '@@@@@홍길동@@@@@') AS "양옆 @ 삭제(TRIM)",
    LTRIM(RTRIM('@@@@@홍길동@@@@@', '@'), '@') AS "양옆 @ 삭제(LTRIM+RTRIM)"
FROM dual;
emp  테이블 사원이름에 왼쪽에 a를 절삭해서 출력
SELECT 
    ename AS "원본 사원명",
    LTRIM(ename, 'Aa') AS "A/a 삭제 결과"
FROM emp;
*/