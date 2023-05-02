/*7�� Summer table*/
-- 1 ���̺��� �����ϱ� ���� �Ȱ��� �̸��� ����ϴ� ���̺��� ���� �� �� ������ ����
drop table Summer;
-- 2 ���̺� ����
create table Summer(
sid number,
class varchar2(20),
price number
); 
-- 2.1 �� ����
insert into summer values(100,'FORTRAN',20000);
insert into summer values(150,'PASCAL',15000);
insert into summer values(200,'C',10000);
insert into summer values(250,'FORTRAN',20000);

-- 3 ������ summer ���̺� Ȯ��
select * from summer;

/*����*/
-- �����б⸦ ��� �л��� �й��� �����ϴ� ������?
select sid,class
from summer;

-- C ������ �������?
select price
from summer
where class='C';

-- �����ᰡ ���� ��� ������?
select distinct class
from summer
where price = (select max(price) from summer);

-- �����б⸦ ��� �л� �� �� ������ �Ѿ���?
select count(*)"�л� ��", sum(price)"������ �Ѿ�"
from summer;

/* 7.1 C ���� ������ ��ȸ*/
select price "C ������"
from summer
where class ='C';
-------------------------------------------------------------------------
/*���� �̻�*/
-- 200�� �л��� �����б� ������û�� ����Ͻÿ�
delete from summer where sid=200;

select price from summer where class = 'C';
-- C ������ ��� �л��� 200�� �л� ���̶� C �� ���õ� ���ݰ� �Բ� ������ ���ŵƴ�.
-- �̰��� ���� �̻��̶�� �Ѵ�.

/*���� �̻�*/
-- �����б⿡ ���ο� ���� �ڹٰ� �����Ǿ���.
insert into summer values(null,'JAVA',25000);

select count(*) as "�����ο�" from summer;
-- ���� ������ �־����� ������û�� �ο��� ������ ���� �׷����� �����ο��� 5������ ����Ǿ���.
-- �̰��� ���� �̻��̶�� �Ѵ�.
select count(sid) as "�����ο�" from summer;
-- �̷� ������ �����Լ� ���� null�� �� �ִٸ� ������ �ʴ� ���� ����� ���� �ִ�.
select count(*) as "�����ο�" from summer where sid is not null;

/*���� �̻�*/
-- FORTRAN ������ �����ᰡ 20000������ 15000������ �����Ǿ���.
update summer set price = 15000 where class = 'FORTRAN';

select * from summer;

select distinct price"fortran ������" from summer where class = 'FORTRAN';
-- ������� 20000������ ����
update summer set price = 20000 where class = 'FORTRAN';
-- ���࿡ �̷� ������ �Ѵٸ�.?
update summer set price = 15000 where class = 'FORTRAN' and sid = 100;
-- 100�� �л��� FORTRAN�� ���ݸ� �����Ǿ� ���� �����ε� ������ ����ġ�̴�
-- �̷� ������ ���� �̻��̶�� �Ѵ�.


--------------------------------------------------------------------------------
/*�̷��� �̻������� �������� "����ȭ"��� ������ ���ľ��Ѵ�.*/
/*���̺��� �������ִ� ���� ����ȭ�̴�.*/
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
-- �����б⸦ ��� �л��� �й��� �����ϴ� ������?
select sid,class
from summerenroll;
-- C ������ �������?
select price from summerPrice where class ='C';
-- �����ᰡ ���� ��� ������?
select distinct class from summerPrice where price = (select max(price) from summerPrice);
-- �����б⸦ ��� �л� ���� �������� �Ѿ���?
select count(*) as "�л� ��", sum(Price) as "������ �Ѿ�"
from summerenroll,summerPrice
where summerPrice.class = summerEnroll.class;
--------------------------------------------------------------------------------------------
-- �̻������� �߻��ϴ°�?
-- 200�� �л��� �����б� ������û�� ����Ͻÿ�
delete from summerEnroll where sid=200;
select * from summerEnroll;
-- C ������ �����ᰡ �����ϴ��� Ȯ��
select price "C ������"
from summerPrice
where class = 'C';
-- ���̺��� ������ ��⿡ ���� �̻��� �߻����� �ʴ´�.

-- ���� �̻�
-- �����б⿡ ���ο� ���� �ڹٰ� �����Ǿ���.
insert into summerPrice values('JAVA',25000);
select * from summerPrice;

select count(*) as "�����ο�" from summerEnroll;
-- summerEnroll ���̺��� ������û�� �ο��� ������ ������ �����̻��� �ذ�ƴ�.

-- ���� �̻�
update summerPrice set price = 15000 where class = 'FORTRAN';
select * from summerPrice;

select price from summerPrice where class='FORTRAN';
-- �� ���� ���̺��� ������ �ξ��⿡ �����̻��� �߻����� �ʴ´�.
