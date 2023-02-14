create table university (
  name varchar(50) not null, 
  location varchar(100) not null, 
  primary key (name)
);

create table course (
  name varchar(50) not null, 
  credit int not null, 
  universityName varchar(50) not null, 
  primary key (name), 
  foreign key (universityName) references university(name)
); 

create table student (
  id int, 
  universityName varchar(50) not null, 
  name varchar(50), 
  nativeLanguage varchar(50), 
  primary key (id), 
  foreign key (universityName) references university(name)
);

create table enrollment (
  courseName varchar(50), 
  studentId int, 
  foreign key (courseName) references course(name),
  foreign key (studentId) references student(id)
);

insert into university (name, location) values 
('a', 'Russia'), ('b', 'USA'); 

insert into student (id, universityName, name, nativelanguage) values 
(1, 'b', 'st1', 'Russain'), 
(2, 'a', 'st2', 'English');

insert into university (name, location) values 
('Innopolis University', 'Russia'); 

insert into student (id, universityName, name, nativelanguage) values 
(3, 'Innopolis University', 'st3', 'Russain'), 
(4, 'Innopolis University', 'st4', 'English');

insert into course(name, credit, universityName) values 
('math', 1, 'a'), 
('programming', 6, 'Innopolis University'), 
('russian language', 10, 'Innopolis University'); 

select * from university where location = 'Russia'; 

select university.name from university 
join student on university.name = universityName 
where nativeLanguage = 'Russain' and location != 'Russia'; 

select student.id from student 
join university on universityName = university.name 
where university.name = 'Innopolis University'; 

select university.name, course.name from university 
join course on universityName = university.name 
where credit > 5; 

select distinct university.name from university 
join student on universityName = university.name 
where nativelanguage = 'english'; 

