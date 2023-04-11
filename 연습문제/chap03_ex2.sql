-- 마당서점의 도서의 총 수
SELECT COUNT(*) AS "마당서점의 도서의 총 수"
FROM Book;

-- 마당서점에 도서를 출고하는 출판사의 총 수
SELECT COUNT(distinct publisher) AS "마당서점에 도서를 출고하는 출판사의 총 수"
FROM Book;

-- Customer 테이블에서 고객명과 주소를 조회합니다.
SELECT name, address 
FROM Customer ;

-- Orders 테이블에서 2020년 7월 4일부터 7월 7일 사이에 발생한 주문번호를 조회합니다.
SELECT orderid AS "2020년 7월 4일 ~ 7월 7일 사이에 발생한 주문번호"
FROM Orders
WHERE orderdate BETWEEN '2020-07-04' AND '2020-07-07';

-- Orders 테이블에서 2020년 7월 4일부터 7월 7일 사이에 발생하지 않은 주문번호를 조회합니다.
SELECT orderid AS " 2020년 7월 4일부터 7월 7일 사이에 발생하지 않은 주문번호"
FROM Orders
WHERE orderdate NOT BETWEEN  '2020-07-04' AND '2020-07-07';

-- 성이 김씨인 고객의 이름과 주소
SELECT name , address
FROM Customer
WHERE name LIKE '김%';

-- Customer 테이블에서 이름이 '김'으로 시작하고 뒤에 한 글자가 있고, 뒤에 '아'가 붙은 고객의 이름과 주소를 조회합니다.
SELECT name, address
FROM Customer
WHERE name LIKE '김%아';
