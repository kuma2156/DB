/*department table 생성*/
create table department(
deptno int not null primary key,
deptname varchar2(20),
manager varchar2(20)
);

/*employee table  생성*/
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

/*project table 생성*/ 
create table project(
projno int  not null primary key,
projname varchar(20),
deptno int, 
FOREIGN KEY (deptno) REFERENCES department (deptno)
);

/*works table 생성*/
create table works(
projno int not null,
FOREIGN KEY (projno) REFERENCES Project (projno),
empno int not null,
primary key(empno,projno),
FOREIGN KEY (empno) REFERENCES Employee (empno),
hoursworked int
);

insert into department values(1,'IT','고남순');
insert into department values(2,'Marketing', '홍길동');
select * from department;

insert into employee values(1, '김덕성', 01012341232, '서울','여','Programmer',1);
insert into employee values(2, '이서울', 01012323122, '서울','남','Programmer',1);
insert into employee values(3, '박연세', 01076851231, '대전','여','Salesperson',2);
insert into employee values(4, '홍길동', 01012341546, '서울','남','Manager',2);
insert into employee values(5, '고남순', 01012311112, '서울','여','Manager',1);

select * from employee;

/*project table 데이터*/
insert into project values(1,'데이터베이스',1);
insert into project values(2,'시장조사',2);

select * from project;

/*works table 데이터*/
insert into works values(1, 1, 3);
insert into works values(1, 2, 1);
insert into works values(2, 3, 1);
insert into works values(2, 4, 5);
insert into works values(1, 5, 1);

select * from works;
