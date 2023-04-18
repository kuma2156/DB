/*department table ����*/
create table department(
deptno int not null primary key,
deptname varchar2(20),
manager varchar2(20)
);

/*employee table  ����*/
create table employee(
empno int not null primary key,
name varchar2(20),
phoneno int,
address varchar2(20),
sex varchar2(20),
position varchar2(20),
deptno int,
FOREIGN KEY (deptno) REFERENCES department (deptno)
);

/*project table ����*/ 
create table project(
projno int  not null primary key,
projname varchar(20),
deptno int, 
FOREIGN KEY (deptno) REFERENCES department (deptno)
);

/*works table ����*/
create table works(
projno int not null,
FOREIGN KEY (projno) REFERENCES Project (projno),
empno int not null,
primary key(empno,projno),
FOREIGN KEY (empno) REFERENCES Employee (empno),
hoursworked int
);

insert into department values(1,'IT','����');
insert into department values(2,'Marketing', 'ȫ�浿');
select * from department;

insert into employee values(1, '�����', 01012341232, '����','��','Programmer',1);
insert into employee values(2, '�̼���', 01012323122, '����','��','Programmer',1);
insert into employee values(3, '�ڿ���', 01076851231, '����','��','Salesperson',2);
insert into employee values(4, 'ȫ�浿', 01012341546, '����','��','Manager',2);
insert into employee values(5, '����', 01012311112, '����','��','Manager',1);

select * from employee;

/*project table ������*/
insert into project values(1,'�����ͺ��̽�',1);
insert into project values(2,'��������',2);

select * from project;

/*works table ������*/
insert into works values(1, 1, 3);
insert into works values(1, 2, 1);
insert into works values(2, 3, 1);
insert into works values(2, 4, 5);
insert into works values(1, 5, 1);

select * from works;
