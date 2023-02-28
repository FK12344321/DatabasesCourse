-- Exercise 1

drop table if exists buys;
drop table if exists items;
drop table if exists customers;
drop table if exists orders;

CREATE TABLE items (
    itemId INT,
	itemName VARCHAR(15),
	price REAL,
	CONSTRAINT item UNIQUE (itemId),
	PRIMARY KEY (itemId));

CREATE TABLE customers (
    customerId INT,
	customerName VARCHAR(15),
	city VARCHAR(15),
	CONSTRAINT customer UNIQUE (customerId),
	PRIMARY KEY (customerId));

CREATE TABLE orders (
    orderId INT,
	customerId INT,
    date DATE,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customers (customerId));

CREATE TABLE buys
	(orderId INT,
	itemId INT,
	quantity INT,
	UNIQUE (orderId, itemId),
	FOREIGN KEY (orderId) REFERENCES orders (orderId),
	FOREIGN KEY (itemId) REFERENCES items (itemId),
	PRIMARY KEY (orderId, itemId));

INSERT INTO items VALUES ('3786', 'Net', '35.00');
INSERT INTO items VALUES ('4011', 'Racket', '65.00');
INSERT INTO items VALUES ('9132', 'Pack-3', '4.75');
INSERT INTO items VALUES ('5794', 'Pack-6', '5.00');
INSERT INTO items VALUES ('3141', 'Cover', '10.00');

INSERT INTO customers VALUES ('101', 'Martin', 'Prague');
INSERT INTO customers VALUES ('107', 'Herman', 'Madrid');
INSERT INTO customers VALUES ('110', 'Pedro', 'Moscow');

INSERT INTO orders VALUES ('2301', '101', '2011-02-23');
INSERT INTO orders VALUES ('2302', '107', '2012-02-25');
INSERT INTO orders VALUES ('2303', '110', '2011-02-27');

INSERT INTO buys VALUES ('2301', '3786', 3);
INSERT INTO buys VALUES ('2301', '4011', 6);
INSERT INTO buys VALUES ('2301', '9132', 8);
INSERT INTO buys VALUES ('2302', '5794', 4);
INSERT INTO buys VALUES ('2303', '4011', 2);
INSERT INTO buys VALUES ('2303', '3141', 2);

select min(total) from (
    select sum(buys.quantity * items.price) as total
    from orders
    join buys on buys.orderId = orders.orderId
    join items on buys.itemId = items.itemId
    group by (orders.orderId)) as totals;

select quantity, city, customerId from
    (select sum(buys.quantity) as quantity, customers.customerId as customerId,
           customers.city as city
    from customers
    join orders on customers.customerId = orders.customerId
    join buys on buys.orderId = orders.orderId
    group by (customers.customerId, customers.city)) as customers1
order by quantity desc
limit 1;

-- Exercise 2

drop table if exists loans;
drop table if exists sessions;
drop table if exists teachers;
drop table if exists schools;
drop table if exists rooms;
drop table if exists roomNumbers;
drop table if exists grades;
drop table if exists publishers;
drop table if exists books;
drop table if exists courses;
drop table if exists subjects;

create table schools (
    schoolId INT,
    schoolName VARCHAR(50),
    PRIMARY KEY (schoolId)
);

create table teachers (
    teacherId INT,
    schoolId INT,
    teacherName varchar(30),
    PRIMARY KEY (teacherId),
    foreign key (schoolId) references schools(schoolId)
);

create table roomNumbers (
    roomNumberId int,
    roomNumber varchar(10),
    primary key (roomNumberId)
);

create table rooms (
    roomId int,
    roomIndex varchar(10),
    roomNumberId int,
    primary key (roomId),
    foreign key (roomNumberId) references roomNumbers(roomNumberId)
);

create table grades (
    gradeId int,
    gradeName varchar(10),
    primary key (gradeId)
);

create table publishers (
    publisherId int,
    publisherName varchar(30),
    primary key (publisherId)
);

create table subjects (
    subjectId int,
    subjectName varchar(60),
    primary key (subjectId)
);

create table books (
    bookId int,
    publisherId int,
    subjectId int,
    primary key (bookId),
    foreign key (publisherId) references publishers(publisherId),
    foreign key (subjectId) references subjects(subjectId)
);

create table courses (
    courseId INT,
    courseName varchar(40),
    primary key (courseId)
);

create table sessions (
    sessionId int,
    teacherId int,
    courseId int,
    roomId int,
    bookId int,
    schoolId int,
    gradeId int,
    primary key (sessionId),
    foreign key (schoolId) references schools(schoolId),
    foreign key (bookId) references books(bookId),
    foreign key (roomId) references rooms(roomId),
    foreign key (teacherId) references teachers(teacherId),
    foreign key (courseId) references courses(courseId),
    foreign key (gradeId) references grades(gradeId)
);

create table loans (
    loanId int,
    sessionId int,
    loanDate date,
    primary key (loanId),
    foreign key (sessionId) references sessions(sessionId)
);

insert into schools values ('0', 'Horizon Education Institute');
insert into schools values ('1', 'Bright Institution');

insert into teachers values ('0', '0', 'Chad Russell');
insert into teachers values ('1', '0', 'E.F.Codd');
insert into teachers values ('2', '0', 'Jones Smith');
insert into teachers values ('3', '1', 'Adam Baker');

insert into roomNumbers values ('0', 'A01');
insert into roomNumbers values ('1', 'B01');

insert into rooms values ('0', '1', '0'); -- 1.A01
insert into rooms values ('1', '1', '1'); -- 1.B01
insert into rooms values ('2', '2', '1'); -- 2.B01

insert into grades values ('0', '1st grade');
insert into grades values ('1', '2nd grade');

insert into publishers values ('0', 'BOA Editions');
insert into publishers values ('1', 'Taylor & Francis Publishing');
insert into publishers values ('2', 'Prentice Hall');
insert into publishers values ('3', 'McGraw Hill');

insert into subjects values ('0', 'Learning and teaching in early childhood education');
insert into subjects values ('1', 'Preschool N56');
insert into subjects values ('2', 'Early Childhood Education N9');
insert into subjects values ('3', 'Know how to educate: guide for Parents and Teachers');

insert into books values ('0', '0', '0'); -- 'Learning and teaching in early childhood education'
insert into books values ('1', '1', '1'); -- 'Preschool N56'
insert into books values ('2', '2', '2'); -- 'Early Childhood Education'
insert into books values ('3', '3', '3'); -- 'Know how to educate: guide for Parents and Teachers'

insert into courses values ('0', 'Logical Thinking');
insert into courses values ('1', 'Writing');
insert into courses values ('2', 'Numerical Thinking');
insert into courses values ('3', 'Spatial, Temporal and Causal Thinking');
insert into courses values ('4', 'English');

insert into sessions values('0', '0', '0', '0', '0', '0', '0');
insert into sessions values('1', '0', '1', '0', '1', '0', '0');
insert into sessions values('2', '0', '2', '0', '0', '0', '0');
insert into sessions values('3', '1', '3', '1', '2', '0', '0');
insert into sessions values('4', '1', '2', '1', '0', '0', '0');
insert into sessions values('5', '2', '1', '0', '0', '0', '1');
insert into sessions values('6', '2', '4', '0', '3', '0', '1');
insert into sessions values('7', '3', '0', '2', '3', '1', '0');
insert into sessions values('8', '3', '2', '2', '0', '1', '0');

insert into loans values('0', '0', '2010-09-09');
insert into loans values('1', '1', '2010-05-05');
insert into loans values('2', '2', '2010-05-05');
insert into loans values('3', '3', '2010-05-06');
insert into loans values('4', '4', '2010-05-06');
insert into loans values('5', '5', '2010-09-09');
insert into loans values('6', '6', '2010-05-05');
insert into loans values('7', '7', '2010-12-18');
insert into loans values('8', '8', '2010-05-06');

-- I assume that the books are uniquely identified by its name
-- i.e. books that have the same name are the same
select publisherName, schoolName, subjectName as bookName
from publishers
join books on books.publisherId = publishers.publisherId
join subjects on books.subjectId = subjects.subjectId
join sessions on sessions.bookId = books.bookId
join schools on sessions.schoolId = schools.schoolId;

select p.publisherName, s.subjectName, dates.schoolName from schools join
    (select schoolName, max(date) as closestDate from schools
    join
        (select schoolId, loanDate as date, bookId from loans
        join sessions on loans.sessionId = sessions.sessionId) as loans1
    on loans1.schoolId = schools.schoolId
    group by (schools.schoolName)) as dates
on dates.schoolName = schools.schoolName
join loans on dates.closestDate = loans.loanDate
join sessions on loans.sessionId = sessions.sessionId
join books on sessions.bookId = books.bookId
join subjects s on books.subjectId = s.subjectId
join publishers p on books.publisherId = p.publisherId
group by p.publisherName, s.subjectName, dates.schoolName

