create table account (
    id bigint primary key,
    "name" varchar(255),
    credit bigint,
    currency varchar(255),
    unique(id)
);

insert into account values
    (1, 'A1', 1000, 'RUB'),
    (2, 'A2', 1000, 'RUB'),
    (3, 'A3', 1000, 'RUB'),
    (4, 'A4', 1000, 'RUB');

begin;
    savepoint t1;

    update account
    set credit = credit - 500
    where id = 1;

    update account
    set credit = credit + 500
    where id = 3;

    savepoint t2;

    update account
    set credit = credit - 700
    where id = 2;

    update account
    set credit = credit + 700
    where id = 1;

    savepoint t3;

    update account
    set credit = credit - 100
    where id = 2;

    update account
    set credit = credit + 100
    where id = 3;

    select * from account;

    rollback to savepoint t3;
    rollback to savepoint t2;
    rollback to savepoint t1;

commit;

