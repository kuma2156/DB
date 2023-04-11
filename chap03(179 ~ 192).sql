--------------------------------------- ���̺� -----------------------------------------------------------
-- newbook ���̺� ����
CREATE TABLE newbook (
bookid NUMBER PRIMARY KEY, -- �⺻Ű
bookname VARCHAR2(20) not null ,-- ��ĭ X
publisher VARCHAR2(20) unique ,-- �ߺ� X
price NUMBER default 10000 check(price > 1000)-- �⺻ 10000  , Check (������� 1000�� �̻�)
);

-- newCustomer ���̺� ����
CREATE TABLE newCustomer(
custid  number PRIMARY KEY,
name varchar2(20),
address varchar(20),
phone varchar(20)
);

-- newOrders ���̺� ����
CREATE TABLE newOrders(
orderid number  PRIMARY KEY, -- �⺻Ű
custid number   not null, -- ��������
bookid number   not null, -- ��������
saleprice number,
orderdate date ,
FOREIGN KEY(custid) REFERENCES newCustomer(custid) ON DELETE CASCADE -- �ܷ�Ű , �������
);

------------------------------------- �Ӽ� ----------------------------------------------------------------

-- �Ӽ� �߰�
ALTER TABLE newbook add isbn varchar2(13); 

-- ������� ����
alter table newbook modify isbn number;

-- ���̺� ����
drop table newbook;

------------------------------------- ������ ���۾� ----------------------------------------------------------------

select * from book;

-- Ʃ�� �߰�       ( �Ӽ��� �ְ� ���� ������ )
Insert into book(bookid, bookname, publisher, price) 
values (11,'����������','�Ѽ����м���',90000);
/* not null ��������� ���� ���� �Ӽ��� ���� �ȳְ� �����Ҽ��ִ�.*/
insert into book(bookid, bookname, publisher )
values (14,'����������','�Ѽ����м���');

select * from imported_book;

-- �뷮 ����
insert into book(bookid, bookname, publisher, price)
select bookid, bookname, publisher, price
from imported_book;


-- ������Ʈ
UPDATE customer
SET address = '���ѹα� �λ�'
where custid = 5;
/*�̷� ������ �������Ƿε� �����ϴ�.*/
update customer
set address = (select address from customer where name = '�迬��')
where name = '�ڼ���';

-- Ʃ�� ����
DELETE 
from customer 
where name = '�ڼ���';

-- �ѹ� (Ctrl + Z)
ROLLBACK;



