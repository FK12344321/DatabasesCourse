drop table account;

create table account (
    username varchar(255),
    fullname varchar(255),
    balance bigint,
    group_id bigint
);

insert into account values
('jones', 'Alice Jones', 82, 1),
('bitdiddl', 'Ben Bitdiddle', 65, 1),
('mike', 'Michael Dole', 73, 2),
('alyssa', 'Alyssa P. Hacker', 79, 3),
('bbrown', 'Bob Brown', 100, 3);

select * from account;