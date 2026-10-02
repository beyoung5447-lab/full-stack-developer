--------------------------------------------------
-- 1. 기존 테이블 안전 삭제 (초기화)
--------------------------------------------------
DECLARE
    v_count NUMBER;
BEGIN
    -- CASTING 테이블 삭제
    SELECT COUNT(*) INTO v_count FROM user_tables WHERE table_name = 'CASTING';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE casting PURGE';
    END IF;

    -- ACTOR 테이블 삭제
    SELECT COUNT(*) INTO v_count FROM user_tables WHERE table_name = 'ACTOR';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE actor PURGE';
    END IF;

    -- MOVIE 테이블 삭제
    SELECT COUNT(*) INTO v_count FROM user_tables WHERE table_name = 'MOVIE';
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE movie PURGE';
    END IF;
END;
/

--------------------------------------------------
-- 2. DDL: 테이블 생성
--------------------------------------------------
-- 배우 테이블
CREATE TABLE actor (
    actor_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actor_name VARCHAR2(50) NOT NULL
);

-- 영화 테이블
CREATE TABLE movie (
    movie_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title       VARCHAR2(100) NOT NULL
);

-- 출연 테이블 (교차 테이블)
CREATE TABLE casting (
    casting_id  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actor_id    NUMBER NOT NULL,
    movie_id    NUMBER NOT NULL,
    CONSTRAINT fk_casting_actor 
        FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_casting_movie 
        FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
        ON DELETE CASCADE,
    CONSTRAINT unique_actor_movie 
        UNIQUE (actor_id, movie_id)
);

--------------------------------------------------
-- 3. DML: 샘플 데이터 삽입
--------------------------------------------------
INSERT INTO actor (actor_name) VALUES ('송강호');
INSERT INTO actor (actor_name) VALUES ('이정재');
INSERT INTO actor (actor_name) VALUES ('최민식');

INSERT INTO movie (title) VALUES ('기생충');
INSERT INTO movie (title) VALUES ('관상');
INSERT INTO movie (title) VALUES ('신세계');

-- N:M 관계 매핑
INSERT INTO casting (actor_id, movie_id) VALUES (1, 1); -- 송강호 - 기생충
INSERT INTO casting (actor_id, movie_id) VALUES (1, 2); -- 송강호 - 관상
INSERT INTO casting (actor_id, movie_id) VALUES (2, 2); -- 이정재 - 관상
INSERT INTO casting (actor_id, movie_id) VALUES (2, 3); -- 이정재 - 신세계
INSERT INTO casting (actor_id, movie_id) VALUES (3, 3); -- 최민식 - 신세계

COMMIT;

--------------------------------------------------
-- 4. DQL: 조회 및 검증 쿼리
--------------------------------------------------
-- 영화별 출연 배우 목록
SELECT 
    m.title AS 영화제목,
    a.actor_name AS 출연배우,
    c.casting_id AS 출연번호
FROM casting c
JOIN movie m ON c.movie_id = m.movie_id
JOIN actor a ON c.actor_id = a.actor_id
ORDER BY m.movie_id, a.actor_id;

-- 배우별 총 출연 영화 수
SELECT 
    a.actor_name AS 배우이름,
    COUNT(c.movie_id) AS 총출연영화수
FROM actor a
LEFT JOIN casting c ON a.actor_id = c.actor_id
GROUP BY a.actor_id, a.actor_name
ORDER BY a.actor_id;