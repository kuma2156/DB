
-- ����
CREATE TABLE theater_01 (
  theater_id INT PRIMARY KEY,
  theater_name VARCHAR(50),
  location VARCHAR(100)
);
insert into theater_01 values(1,'�Ե�','���');
insert into theater_01 values(2,'�ް�','����');
insert into theater_01 values(3,'����','���');

select * from theater_01;

-- �󿵰�
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

insert into screening_room_01 values(1,1,'����� ��ȭ',15000,48);
insert into screening_room_01 values(3,1,'���� ��ȭ',7500,120);
insert into screening_room_01 values(3,2,'��մ� ��ȭ',8000,110);

select * from screening_room_01;

-- ����
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

-- ��
CREATE TABLE customer_01 (
  customer_id INT PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(100)
);

insert into customer_01 values(3,'ȫ�浿','����');
insert into customer_01 values(4,'��ö��','���');
insert into customer_01 values(9,'�ڿ���','����');

select * from customer_01;

--------------------------------------------------------------------------------------

--(1) �ܼ� ����
    -- 1 ��� ������ �̸��� ��ġ�� ���̽ÿ�
    select theater_name,location
    from theater_01;
    -- 2 ��ǿ� �ִ� ������ ���̽ÿ�
    select *
    from theater_01
    where location='���';
    -- 3 ��ǿ� ��� ���� �̸��� ������������ ���̽ÿ�.
    select name
    from customer_01
    order by name ASC; 
    -- 4 ������ 8000�� ������ ��ȭ�� �����ȣ, �󿵰���ȣ, ��ȭ������ ���̽ÿ�.
    select theater_01.theater_id,screening_room_01.room_number,screening_room_01.movie_title
    from theater_01,screening_room_01
    where theater_01.theater_id = screening_room_01.theater_id and screening_room_01.price <= 8000;
    -- 5 ���� ��ġ�� ���� �ּҰ� ���� ���� ���̽ÿ�
    select *
    from theater_01,customer_01
    where theater_01.location = customer_01.address;
    
--------------------------------------------------------------------------------------

-- (2) ���� ����
    -- 1 ������ ���� �� ���ΰ�?
    select count(theater_id) as "������ ��"
    from theater_01;
    -- 2 �󿵵Ǵ� ��ȭ�� ��հ����� ���ΰ�?
    select avg(price) as "��ȭ ��հ���"
    from screening_room_01;
    -- 3 2020�� 9�� 1�Ͽ� ��ȭ�� ������ ���� ���� ���ΰ�?
    select count(customer_id) as "2020�� 9�� 1�Ͽ� ��ȭ�� ������ �� ��"
    from reservation_01
    where date2 = '2020-09-01';

--------------------------------------------------------------------------------------

-- (3) �μ� ����
    -- 1 ���� ���忡�� �󿵵� ��ȭ������ ���̽ÿ�.
    select movie_title as "���ѱ��忡�� ���ϴ� ��ȭ"
    from screening_room_01
    join theater_01 on screening_room_01.theater_id = theater_01.theater_id
    where theater_name = '����';
    
    select movie_title 
    from screening_room_01, theater_01
    where theater_01.theater_id = screening_room_01.theater_id and theater_name = '����';
    
    -- 2 ���� ���忡�� ��ȭ�� �� ���� �̸��� ���̽ÿ�
    select name
    from customer_01,theater_01,reservation_01
    where reservation_01.customer_id = customer_01.customer_id and theater_name = '����';
    -- 3 ���� ������ ��ü ������ ���̽ÿ�
    select SUM(price) as "���ѱ��� ��ü ����"
    from theater_01, screening_room_01, reservation_01
    where theater_01.theater_id = screening_room_01.theater_id AND screening_room_01.theater_id = reservation_01.theater_id
            AND screening_room_01.room_number = reservation_01.room_number and theater_name = '����';

--------------------------------------------------------------------------------------

-- (4) �׷� ����
    -- 1 ���庰 �󿵰��� ���� ���̽ÿ�
    select theater_01.theater_name as "���� �̸�", count(*) as "�󿵰��� ��"
    from screening_room_01
    join theater_01 on screening_room_01.theater_id = theater_01.theater_id
    group by theater_01.theater_name;
    -- 2 ��ǿ� �ִ� ������ �󿵰��� ���̽ÿ�
    select *
    from theater_01
    join screening_room_01 on theater_01.theater_id = screening_room_01.theater_id
    where location = '���';

    SELECT * 
    FROM screening_room_01, theater_01 
    WHERE theater_01.theater_id=screening_room_01.theater_id AND location LIKE '���';
    
    -- 3 2020�� 9�� 1�Ͽ� ���庰 ��� ���� ���� ���� ���̽ÿ�.
    SELECT theater_01.theater_name as "���� �̸�", COUNT(*) as "�� ��"
    FROM reservation_01 
    join theater_01 on reservation_01.theater_id = theater_01.theater_id
    WHERE date2 = '2020-09-01'
    GROUP BY theater_01.theater_name;
    
    -- 4 2020�� 9�� 1�Ͽ� ���� ���� ���� ������ ��ȭ�� ���̽ÿ�.
    SELECT *
    from screening_room_01
    join reservation_01 on screening_room_01.theater_id = reservation_01.theater_id
    where date2 = '2020-09-01' ;

    