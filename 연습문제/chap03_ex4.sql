------------------------------------- �������� ----------------------------------------------------------------
-- 04
SELECT * FROM book;

/*1�� ���ο� ����(����������, ���ѹ̵��, 10000��)�� ���缭���� �԰�Ǿ���. ������ �� �� ��� �ʿ��� �����Ͱ� �� �ִ��� ã�ƺ��ÿ�*/
insert into book values(20,'������ ����', '���ѹ̵��',10000);

/*2�� �Ｚ�翡�� ���ǻ� ������ �����Ͻÿ�*/
delete from book where publisher = '�Ｚ��';

/*3�� �̻�̵��� ������ ������ �����Ͻÿ�. ������ �ȵȴٸ� ������ �����غ��ÿ�*/
delete from book where publisher = '�̻�̵��';
/*�ٸ� ���̺��̶� �����Ǿ� �־� �������⸦ �Ƚ��ѵξ �ȵȴ�.
orders ���̺� �ֹ����ѵ� å�� �̻�̵��� �ܷ�Ű ������ ����ȴ�.*/

/*4�� ���ǻ� ���ѹ̵� �������ǻ�� �ٲپ��*/
update book
set publisher = '�������ǻ�'
where publisher = '���ѹ̵��';

/*5�� ���ǻ翡 ���� ������ �����ϴ� ���̺� bookcompany�� �����ϰ��� �Ѵ�. name�� �⺻Ű varchar2(20), address varchar2(20) begin date �������� Ÿ���� �����϶�*/
create table Bookcompany(
name varchar2(20) PRIMARY KEY,
address varchar2(20),
begin date
);

/*6�� bookcompany ���̺� ���ͳ� �ּҸ� �����ϴ� webaddress �Ӽ��� varchar2(30)���� �߰��϶�.*/
alter table Bookcompany add webaddress varchar2(30);

/*7��  bookcompany ���̺� ������ ���� name = �Ѻ���ī���� , address = ����� ������ , begin = 1993-01-01, webaddress = http://hanbit.co.kr�� �����϶�.*/
insert into Bookcompany values('�Ѻ���ī����','����� ������','1998-01-01','http://hanbit.co.kr');

select * from Bookcompany;