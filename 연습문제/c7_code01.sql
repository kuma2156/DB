/*7장 Summer table*/
-- 1 테이블을 생성하기 전에 똑같은 이름을 사용하는 테이블이 있을 수 도 있으니 제거
drop table Summer;
-- 2 테이블 생성
create table Summer(
sid number,
class varchar2(20),
price number
); 
-- 2.1 값 삽입
insert into summer values(100,'FORTRAN',20000);
insert into summer values(150,'PASCAL',15000);
insert into summer values(200,'C',10000);
insert into summer values(250,'FORTRAN',20000);

-- 3 생성된 summer 테이블 확인
select * from summer;

/*질의*/
-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid,class
from summer;

-- C 강좌의 수강료는?
select price
from summer
where class='C';

-- 수강료가 가장 비싼 과목은?
select distinct class
from summer
where price = (select max(price) from summer);

-- 계절학기를 듣는 학생 수 와 수강료 총액은?
select count(*)"학생 수", sum(price)"수강료 총액"
from summer;

/* 7.1 C 강좌 수강료 조회*/
select price "C 수강료"
from summer
where class ='C';
-------------------------------------------------------------------------
/*삭제 이상*/
-- 200번 학생의 계절학기 수강신청을 취소하시오
delete from summer where sid=200;

select price from summer where class = 'C';
-- C 과목을 듣는 학생은 200번 학생 뿐이라 C 에 관련된 가격과 함께 정보가 제거됐다.
-- 이것을 삭제 이상이라고 한다.

/*삽입 이상*/
-- 계절학기에 새로운 강좌 자바가 개설되었다.
insert into summer values(null,'JAVA',25000);

select count(*) as "수강인원" from summer;
-- 강좌 정보만 넣었지만 수강신청한 인원의 정보가 없다 그렇지만 수강인원이 5명으로 집계되었다.
-- 이것을 삽입 이상이라고 한다.
select count(sid) as "수강인원" from summer;
-- 이런 식으로 집계함수 값에 null이 들어가 있다면 원하지 않는 값이 도출될 수도 있다.
select count(*) as "수강인원" from summer where sid is not null;

/*수정 이상*/
-- FORTRAN 강좌의 수강료가 20000원에서 15000원으로 수정되었다.
update summer set price = 15000 where class = 'FORTRAN';

select * from summer;

select distinct price"fortran 수강료" from summer where class = 'FORTRAN';
-- 원래대로 20000원으로 변경
update summer set price = 20000 where class = 'FORTRAN';
-- 만약에 이런 식으로 한다면.?
update summer set price = 15000 where class = 'FORTRAN' and sid = 100;
-- 100번 학생의 FORTRAN의 가격만 수정되어 같은 강좌인데 가격이 불일치이다
-- 이런 현상을 수정 이상이라고 한다.


--------------------------------------------------------------------------------
/*이러한 이상현상을 막기위해 "정규화"라는 과정을 거쳐야한다.*/
/*테이블을 나누어주는 것이 정규화이다.*/
create table SummerPrice(
class varchar2(20),
price integer
);
insert into SummerPrice values ('FORTRAN',20000);
insert into SummerPrice values ('PASCAL',15000);
insert into SummerPrice values ('C',10000);

select * from SummerPrice;

create table SummerEnroll(
sid integer,
class varchar2(20)
);

insert into summerenroll values(100,'FORTRAN');
insert into summerenroll values(150,'PASCAL');
insert into summerenroll values(200,'C');
insert into summerenroll values(250,'FORTRAN');

select * from summerenroll;

/*7.2 summerPrice , summerEncroll*/
-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid,class
from summerenroll;
-- C 강좌의 수강료는?
select price from summerPrice where class ='C';
-- 수강료가 가장 비싼 과목은?
select distinct class from summerPrice where price = (select max(price) from summerPrice);
-- 계절학기를 듣는 학생 수와 수강료의 총액은?
select count(*) as "학생 수", sum(Price) as "수강료 총액"
from summerenroll,summerPrice
where summerPrice.class = summerEnroll.class;
--------------------------------------------------------------------------------------------
-- 이상현상이 발생하는가?
-- 200번 학생의 계절학기 수강신청을 취소하시오
delete from summerEnroll where sid=200;
select * from summerEnroll;
-- C 강좌의 수강료가 존재하는지 확인
select price "C 수강료"
from summerPrice
where class = 'C';
-- 테이블을 나누어 줬기에 삭제 이상이 발생하지 않는다.

-- 삽입 이상
-- 계절학기에 새로운 강좌 자바가 개설되었다.
insert into summerPrice values('JAVA',25000);
select * from summerPrice;

select count(*) as "수강인원" from summerEnroll;
-- summerEnroll 테이블에는 수강신청한 인원의 정보만 나오니 삽입이상이 해결됐다.

-- 수정 이상
update summerPrice set price = 15000 where class = 'FORTRAN';
select * from summerPrice;

select price from summerPrice where class='FORTRAN';
-- 이 또한 테이블을 나누어 두었기에 수정이상이 발생하지 않는다.
