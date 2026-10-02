--------------------------------------------------
-- 1. 기존 테이블 및 시퀀스 삭제 (초기화)
--------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE enrollments PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE students PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE courses PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

--------------------------------------------------
-- 2. DDL: 테이블 생성
--------------------------------------------------
-- 학생 테이블
CREATE TABLE students (
    student_id VARCHAR2(20) PRIMARY KEY,
    name       VARCHAR2(50) NOT NULL,
    major      VARCHAR2(50)
);

-- 과목 테이블
CREATE TABLE courses (
    course_id   VARCHAR2(20) PRIMARY KEY,
    course_name VARCHAR2(100) NOT NULL,
    credits     NUMBER NOT NULL CHECK (credits > 0)
);

-- 수강 테이블 (Oracle 전용 IDENTITY 컬럼 적용)
CREATE TABLE enrollments (
    enrollment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id    VARCHAR2(20) NOT NULL,
    course_id     VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_enrollments_student 
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_enrollments_course 
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,
    CONSTRAINT unique_student_course 
        UNIQUE (student_id, course_id)
);

--------------------------------------------------
-- 3. DML: 샘플 데이터 삽입
--------------------------------------------------
INSERT INTO students (student_id, name, major) VALUES ('20240001', '김철수', '컴퓨터공학과');
INSERT INTO students (student_id, name, major) VALUES ('20240002', '이영희', '전자공학과');
INSERT INTO students (student_id, name, major) VALUES ('20240003', '박민수', '컴퓨터공학과');

INSERT INTO courses (course_id, course_name, credits) VALUES ('CS101', '데이터베이스 개론', 3);
INSERT INTO courses (course_id, course_name, credits) VALUES ('CS102', '파이썬 프로그래밍', 3);
INSERT INTO courses (course_id, course_name, credits) VALUES ('EC201', '회로이론', 4);

-- enrollment_id는 IDENTITY 컬럼이므로 자동 생성됩니다.
INSERT INTO enrollments (student_id, course_id) VALUES ('20240001', 'CS101');
INSERT INTO enrollments (student_id, course_id) VALUES ('20240001', 'CS102');
INSERT INTO enrollments (student_id, course_id) VALUES ('20240002', 'EC201');
INSERT INTO enrollments (student_id, course_id) VALUES ('20240003', 'CS101');

COMMIT;

--------------------------------------------------
-- 4. DQL: 조회 및 검증 쿼리
--------------------------------------------------
-- 특정 학생(김철수)의 수강 과목 조회
SELECT 
    s.student_id AS 학번,
    s.name AS 학생이름,
    c.course_id AS 과목번호,
    c.course_name AS 과목명,
    c.credits AS 학점
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = '20240001';

-- 과목별 수강 인원수 집계
SELECT 
    c.course_id AS 과목번호,
    c.course_name AS 과목명,
    COUNT(e.student_id) AS 수강인원수
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_id;