-- �������� ������ ������ ���ǻ� �� 1.5
SELECT COUNT(DISTINCT publisher) AS "�������� ������ ������ ���ǻ� ��"
FROM Book
WHERE bookid IN (SELECT bookid
                 FROM Orders
                 WHERE custid = (SELECT custid 
                                 FROM Customer 
                                 WHERE name = '������'));
                                 
select count(distinct publisher)
from customer,orders,book
where customer.custid = orders.custid and orders.bookid = book.bookid and customer.name like '������';
/*from�� customer, orders, book ���̺��� �����ְ� where ���� ���̺���� ���ν����ش�.*/
--------------------------------------------------------------------------------------------------------------
-- �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ���� 1.6
SELECT Book.bookname, Book.price, (Book.price - Orders.saleprice) AS "������ �ǸŰ����� ����"
FROM Book
JOIN Orders ON Book.bookid = Orders.bookid
JOIN Customer ON Orders.custid = Customer.custid
WHERE Customer.name = '������';

select book.bookname , book.price, (book.price - orders.saleprice)
from book, orders , customer
where customer.custid = orders.custid and orders.bookid = book.bookid and customer.name like '������';
---------------------------------------------------------------------------------------------------------------
-- �������� �������� ���� ������ �̸� 1.7
SELECT Book.bookname AS "�������� �������� ���� å �̸�"
FROM Book
WHERE bookid NOT IN (SELECT DISTINCT bookid FROM Orders WHERE custid = (SELECT custid FROM Customer WHERE name = '������'));

select bookname
from book
where not exists (
                  select bookname
                  from customer, orders
                  where customer.custid = orders.custid and 
                        orders.bookid = book.bookid and 
                        customer.name like '������');
                  
---------------------------------------------------------------------------------------------------------------
-- �ֹ����� ���� ���� �̸�(�μ���) 2.8
SELECT name
FROM Customer
WHERE custid NOT IN (SELECT DISTINCT custid FROM Orders);

select name
from customer
where custid not in (select distinct custid
                     from orders);
                     
select distinct custid
from orders;
---------------------------------------------------------------------------------------------------------------
-- �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ� 2.9
SELECT SUM(saleprice) AS "�ֹ� �ݾ��� �Ѿ�", AVG(saleprice) AS "�ֹ��� ��� �ݾ�"
FROM Orders;

select sum(saleprice), avg(saleprice)
from orders;
---------------------------------------------------------------------------------------------------------------
-- ���� �̸��� ���� ���ž� 2.10
SELECT customer.name AS "���� �̸�", SUM(orders.saleprice) AS "�� �� ���ž�"
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name;

select name , sum(saleprice) as "total"
from customer, orders
where customer.custid = orders.custid
group by name;
---------------------------------------------------------------------------------------------------------------
-- ���� �̸��� ���� ������ ���� ��� 2.11
SELECT customer.name, book.bookname
FROM Orders
JOIN Customer ON Orders.custid = Customer.custid
JOIN Book ON Orders.bookid = Book.bookid
GROUP BY customer.name, book.bookname;

select name as "�� �̸�", bookname as "������ �����̸�"
from customer, book , orders
where customer.custid = orders.custid and orders.bookid = book.bookid
group by name, bookname;
---------------------------------------------------------------------------------------------------------------
-- ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ� 2.12
SELECT *
FROM book, ORDERS
WHERE book.BOOKID = orders.BOOKID AND book.PRICE-orders.SALEPRICE = (SELECT max(book.PRICE-orders.SALEPRICE) FROM book, ORDERS WHERE book.BOOKID = orders.BOOKID);

select *
from book, orders
where orders.bookid = book.bookid and book.price - orders.saleprice = (select max(book.price - orders.saleprice)
                                                                       from book, orders
                                                                       where orders.bookid = book.bookid);
---------------------------------------------------------------------------------------------------------------
-- ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸� 2.13
SELECT Customer.name
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name
HAVING AVG(Orders.saleprice) > (SELECT AVG(saleprice) FROM Orders);

select name , avg(saleprice)
from customer,orders,book
where customer.custid = orders.custid and orders.bookid = book.bookid
group by name
having avg(saleprice) > (select avg(saleprice) from orders);