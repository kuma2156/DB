select Customer.name , book.bookname
from Customer , Orders, Book
where Customer.custid = Orders.custid AND Orders.bookid = Book.bookid and Book.price = 20000;
---------------------------------------------------------------------------------------------------------
-- 외부 조인 (왼쪽) +를 사용하여 간략하게 표시
select Customer.name , saleprice
from Customer, Orders
where Customer.custid = Orders.custid(+);

-- 외부 조인 (오른쪽) +를 사용하여 간략하게 표시 (주문하지 않은 고객의 이름과 가격)
select Customer.name , saleprice
from Customer, Orders
where Customer.custid(+) = Orders.custid;

-- 외부 조인 (왼쪽) left outer join "조인될 대상"  on "동등 조인"
select Customer.name ,saleprice
from Customer LEFT outer join Orders
                        on Customer.custid = Orders.custid;

-- 동등 조인
select name , saleprice
from customer, Orders
where customer.custid = orders.custid;
---------------------------------------------------------------------------------------------------------
-- 가장 비싼 도서의 이름 찾아보기
-- (1) 하위질의 (가장 비싼 책의 가격 정보 출력)
select max(price)
from Book;

-- (2) 하위질의 ((1)에서 찾은 가격으로 책의 이름 찾기)
select bookname
from Book
where price = 35000;

-- (1) + (2) 한 결과 부속질의 (두 지문을 합쳐서 where 절에 이런 식으로 표시할 수 있다.)
select bookname --(2)
from Book
where price = (select max(price) from Book);--(1)
---------------------------------------------------------------------------------------------------------
-- 주문한 고객의 이름 찾기
-- a (먼저 주문자 아이디를 찾는다.)
select custid
from Orders;

-- b (알아낸 주문자의 아이디를 in 으로 여러개를 검색하고 이름을 출력한다.)
select name
from customer  
where custid IN(1,2,3,4);

-- (a) + (b) (부속질의로 합쳐서 해봤다.)
select name -- b
from Customer
where custid in(select custid from Orders); -- a
---------------------------------------------------------------------------------------------------------
-- '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 보이시오.(하위 부속질의)
select name -- 3 2에서 알아낸 주문자의 아이디로 이름을 출력한다.
from Customer
where custid in(select custid 
                from Orders
                where bookid in(select bookid -- 2 알아낸 책 아이디로 주문자의 아이디를 알아낸다.
                                from Book
                                where publisher = '대한미디어')); -- 1 먼저 대한미디어의 책 아이디를 알아낸다.
---------------------------------------------------------------------------------------------------------
-- 상관 부속질의
-- 임의의 별명을 만들어서 실행한다.
-- 테이블 이름을 별명을 지을 수 있다.... 이를 튜플의 변수라고 한다. ex) Book b1, Book b2

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select b1.bookname
from Book b1 -- (1) b1이라는 별명을 지어줬다
where b1.price > ( select avg(b2.price) -- (2) b2의 가격의 평균을 구하라.
                    from Book b2 -- (2) b2라는 별명
                    where b2.publisher = b1.publisher); -- b2와 b1의 출판사가 같은 것을 조건
                    
---------------------------------------------------------------------------------------------------------
-- 집합연산
-- 도서를 주문하지 않은 고객의 이름을 구하시오
select name -- 모든 고객의 이름
from Customer
Minus -- 차집합
select name -- 주문한 고객의 이름
from Customer
where custid in(select custid from Orders);
---------------------------------------------------------------------------------------------------------
--EXISTS
-- 주문이 있는 고객의 이름과 주소를 보이시오.
select name ,address
from Customer cs
where EXISTS (select *
              from Orders od
              where cs.custid = od.custid);