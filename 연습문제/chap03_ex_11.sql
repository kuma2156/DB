
-- 극장
CREATE TABLE theater_01 (
  theater_id INT PRIMARY KEY,
  theater_name VARCHAR(50),
  location VARCHAR(100)
);
insert into theater_01 values(1,'롯데','잠실');
insert into theater_01 values(2,'메가','강남');
insert into theater_01 values(3,'대한','잠실');

select * from theater_01;

-- 상영관
CREATE TABLE screening_room_01 (
  theater_id INT,
  room_number INT,
  movie_title VARCHAR(50),
  price NUMERIC CHECK (price < 20000),
  seat_count INT,
  PRIMARY KEY (theater_id, room_number),
  FOREIGN KEY (theater_id) REFERENCES theater_01(theater_id)
);
alter table screening_room_01 modify room_number number check(0<room_number and room_number<11);

insert into screening_room_01 values(1,1,'어려운 영화',15000,48);
insert into screening_room_01 values(3,1,'멋진 영화',7500,120);
insert into screening_room_01 values(3,2,'재밌는 영화',8000,110);

select * from screening_room_01;

-- 예약
CREATE TABLE reservation_01 (
  theater_id number,
  room_number number,
  customer_id number,
  seat_number number UNIQUE,
  date2 DATE,
  PRIMARY KEY (theater_id, room_number, seat_number, date2),
  FOREIGN KEY (theater_id, room_number) REFERENCES screening_room_01(theater_id, room_number),
  FOREIGN KEY (customer_id) REFERENCES customer_01(customer_id)
);

insert into reservation_01 values(3,2,3,15,'2020-09-01');
insert into reservation_01 values(3,1,4,16,'2020-09-01');
insert into reservation_01 values(1,1,9,48,'2020-09-01');

select * from reservation_01;

-- 고객
CREATE TABLE customer_01 (
  customer_id INT PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(100)
);

insert into customer_01 values(3,'홍길동','강남');
insert into customer_01 values(4,'김철수','잠실');
insert into customer_01 values(9,'박영희','강남');

select * from customer_01;

--------------------------------------------------------------------------------------

--(1) 단순 질의
    -- 1 모든 극장의 이름과 위치를 보이시오
    select theater_name,location
    from theater_01;
    -- 2 잠실에 있는 극장을 보이시오
    select *
    from theater_01
    where location='잠실';
    -- 3 잠실에 사는 고객의 이름을 오름차순으로 보이시오.
    select name
    from customer_01
    order by name ASC; 
    -- 4 가격이 8000원 이하인 영화의 극장번호, 상영관번호, 영화제목을 보이시오.
    select theater_01.theater_id,screening_room_01.room_number,screening_room_01.movie_title
    from theater_01,screening_room_01
    where theater_01.theater_id = screening_room_01.theater_id and screening_room_01.price <= 8000;
    -- 5 극장 위치와 고객의 주소가 같은 고객을 보이시오
    select *
    from theater_01,customer_01
    where theater_01.location = customer_01.address;
    
--------------------------------------------------------------------------------------

-- (2) 집계 질의
    -- 1 극장의 수는 몇 개인가?
    select count(theater_id) as "극장의 수"
    from theater_01;
    -- 2 상영되는 영화의 평균가격은 얼마인가?
    select avg(price) as "영화 평균가격"
    from screening_room_01;
    -- 3 2020년 9월 1일에 영화를 관람한 고객의 수는 얼마인가?
    select count(customer_id) as "2020년 9월 1일에 영화를 관람한 고객 수"
    from reservation_01
    where date2 = '2020-09-01';

--------------------------------------------------------------------------------------

-- (3) 부속 질의
    -- 1 대한 극장에서 상영된 영화제목을 보이시오.
    select movie_title as "대한극장에서 상영하는 영화"
    from screening_room_01
    join theater_01 on screening_room_01.theater_id = theater_01.theater_id
    where theater_name = '대한';
    
    select movie_title 
    from screening_room_01, theater_01
    where theater_01.theater_id = screening_room_01.theater_id and theater_name = '대한';
    
    -- 2 대한 극장에서 영화를 본 고객의 이름을 보이시오
    select name
    from customer_01,theater_01,reservation_01
    where reservation_01.customer_id = customer_01.customer_id and theater_name = '대한';
    -- 3 대한 극장의 전체 수입을 보이시오
    select SUM(price) as "대한극장 전체 수입"
    from theater_01, screening_room_01, reservation_01
    where theater_01.theater_id = screening_room_01.theater_id AND screening_room_01.theater_id = reservation_01.theater_id
            AND screening_room_01.room_number = reservation_01.room_number and theater_name = '대한';

--------------------------------------------------------------------------------------

-- (4) 그룹 질의
    -- 1 극장별 상영관의 수를 보이시오
    select theater_01.theater_name as "극장 이름", count(*) as "상영관의 수"
    from screening_room_01
    join theater_01 on screening_room_01.theater_id = theater_01.theater_id
    group by theater_01.theater_name;
    -- 2 잠실에 있는 극장의 상영관을 보이시오
    select *
    from theater_01
    join screening_room_01 on theater_01.theater_id = screening_room_01.theater_id
    where location = '잠실';

    SELECT * 
    FROM screening_room_01, theater_01 
    WHERE theater_01.theater_id=screening_room_01.theater_id AND location LIKE '잠실';
    
    -- 3 2020년 9월 1일에 극장별 평균 관람 고객의 수를 보이시오.
    SELECT theater_01.theater_name as "극장 이름", COUNT(*) as "고객 수"
    FROM reservation_01 
    join theater_01 on reservation_01.theater_id = theater_01.theater_id
    WHERE date2 = '2020-09-01'
    GROUP BY theater_01.theater_name;
    
    -- 4 2020년 9월 1일에 가장 많은 고객이 관람한 영화를 보이시오.
    SELECT *
    from screening_room_01
    join reservation_01 on screening_room_01.theater_id = reservation_01.theater_id
    where date2 = '2020-09-01' ;

    
