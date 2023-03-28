set transaction isolation level read uncommitted;

-- step 2
begin transaction;
update account
set username = 'ajones'
where fullname = 'Alice Jones';

-- step 4
select * from account;

-- step 5
commit;
select * from account;

-- step 6
begin transaction;

-- step 8
update account
set balance = balance + 20
where fullname = 'Alice Jones';
select * from account;

-- step 10
rollback;

-- Isolation levels

begin transaction;
update account
set group_id = 2
where fullname = 'Bob Brown';

commit;

