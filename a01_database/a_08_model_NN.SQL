/*
N:N 관계 설정
데이터베이스 설계에 있어서 나도 여러개 복잡한 관계를 깔끔하게 풀어주는 마법의 단어
같은 내용으로 처리하는 경우가 종종 발생한다.
예를 들어 대학교에서 학생 한명을 여러개의 과목을 수강할 수 있지만 반대로 하나의 과목 
입장에서 여러 명의 학생이 수업을 듣습니다.
이외에도 배우와 출연하는 영화, 동아리와 회원, 고객과 상품은 다대다 관계의
구성 할 수 있는 내용입니다.
기본 예제로 학생과 수강 과목을 진행 해보겠습니다.
1단계: 개념적 모델링 (엔티티, 속성, 관계)
엔티티: 학생, 과목, 수강
속성:  학생(학번, 이름, 전공)
        과목(과목번호, 과목명, 학점)
        수강(수강번호, 학번, 과목번호)
2단계: 논리적 모델링(구체적 물리적 모델링으로 가기 위한
컬럼명, 타입, PK, FK 설정, 연관 관계 설정)
엔티티 ==> 테이블명 STUDENT
COURSE, ENROLLMENT
속성 ==> 컬럼명/ 데이터 유형/ PK
STUDENT03
            STUD_NO(학번) NUMBER - PK
            STUD_NAME(이름) VARCAHR2(50)
            MAJOR(전공) VARCHAR2(50)
        COURSE
            COURSE_NO(과목번호) NUMBER - PK
            COURSE_NAME(과목명) VARCHAR2(100)
            CREDIT(학점) NUMBER
        ENROLLMENT
            ENROLL_NO(수강번호) NUMBER - PK
            STUD_NO(학번) NUMBER - FK 
            COURSE_NO(과목번호) NUMBER - FK
연관관계설정 1:N (학생과 수강), 1:N(과목 수강)
FK가 설정 처리*/