select Customer.name , book.bookname
from Customer , Orders, Book
where Customer.custid = Orders.custid AND Orders.bookid = Book.bookid and Book.price = 20000;
---------------------------------------------------------------------------------------------------------
-- �ܺ� ���� (����) +�� ����Ͽ� �����ϰ� ǥ��
select Customer.name , saleprice
from Customer, Orders
where Customer.custid = Orders.custid(+);

-- �ܺ� ���� (������) +�� ����Ͽ� �����ϰ� ǥ�� (�ֹ����� ���� ���� �̸��� ����)
select Customer.name , saleprice
from Customer, Orders
where Customer.custid(+) = Orders.custid;

-- �ܺ� ���� (����) left outer join "���ε� ���"  on "���� ����"
select Customer.name ,saleprice
from Customer LEFT outer join Orders
                        on Customer.custid = Orders.custid;

-- ���� ����
select name , saleprice
from customer, Orders
where customer.custid = orders.custid;
---------------------------------------------------------------------------------------------------------
-- ���� ��� ������ �̸� ã�ƺ���
-- (1) �������� (���� ��� å�� ���� ���� ���)
select max(price)
from Book;

-- (2) �������� ((1)���� ã�� �������� å�� �̸� ã��)
select bookname
from Book
where price = 35000;

-- (1) + (2) �� ��� �μ����� (�� ������ ���ļ� where ���� �̷� ������ ǥ���� �� �ִ�.)
select bookname --(2)
from Book
where price = (select max(price) from Book);--(1)
---------------------------------------------------------------------------------------------------------
-- �ֹ��� ���� �̸� ã��
-- a (���� �ֹ��� ���̵� ã�´�.)
select custid
from Orders;

-- b (�˾Ƴ� �ֹ����� ���̵� in ���� �������� �˻��ϰ� �̸��� ����Ѵ�.)
select name
from customer  
where custid IN(1,2,3,4);

-- (a) + (b) (�μ����Ƿ� ���ļ� �غô�.)
select name -- b
from Customer
where custid in(select custid from Orders); -- a
---------------------------------------------------------------------------------------------------------
-- '���ѹ̵��'���� ������ ������ ������ ���� �̸��� ���̽ÿ�.(���� �μ�����)
select name -- 3 2���� �˾Ƴ� �ֹ����� ���̵�� �̸��� ����Ѵ�.
from Customer
where custid in(select custid 
                from Orders
                where bookid in(select bookid -- 2 �˾Ƴ� å ���̵�� �ֹ����� ���̵� �˾Ƴ���.
                                from Book
                                where publisher = '���ѹ̵��')); -- 1 ���� ���ѹ̵���� å ���̵� �˾Ƴ���.
---------------------------------------------------------------------------------------------------------
-- ��� �μ�����
-- ������ ������ ���� �����Ѵ�.
-- ���̺� �̸��� ������ ���� �� �ִ�.... �̸� Ʃ���� ������� �Ѵ�. ex) Book b1, Book b2

-- ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
select b1.bookname
from Book b1 -- (1) b1�̶�� ������ �������
where b1.price > ( select avg(b2.price) -- (2) b2�� ������ ����� ���϶�.
                    from Book b2 -- (2) b2��� ����
                    where b2.publisher = b1.publisher); -- b2�� b1�� ���ǻ簡 ���� ���� ����
                    
---------------------------------------------------------------------------------------------------------
-- ���տ���
-- ������ �ֹ����� ���� ���� �̸��� ���Ͻÿ�
select name -- ��� ���� �̸�
from Customer
Minus -- ������
select name -- �ֹ��� ���� �̸�
from Customer
where custid in(select custid from Orders);
---------------------------------------------------------------------------------------------------------
--EXISTS
-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
select name ,address
from Customer cs
where EXISTS (select *
              from Orders od
              where cs.custid = od.custid);