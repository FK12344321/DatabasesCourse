set transaction isolation level read uncommitted;

-- step 1
begin transaction;
select * from account;

-- step 3
select * from account;

-- step 7
update account
set balance = balance + 10
where fullname = 'Alice Jones';

-- step 9
commit;

-- Isolation levels

begin transaction isolation level read uncommitted;
select * from account
where group_id = 2;

select * from account
where group_id = 2;

update account
set balance = balance + 15
where group_id = 2;

commit;