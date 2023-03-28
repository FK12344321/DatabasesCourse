alter table account
add bankname varchar(255);

update account
set bankname = 'SberBank'
where id = 1 or id = 3;

update account
set bankname = 'Tinkoff'
where id = 2;

CREATE OR REPLACE PROCEDURE trans(
    senderid bigint,
    recieverid bigint,
    amount bigint)
AS $$
BEGIN
    update account
    set credit = credit - amount
    where id = senderid;

    update account
    set credit = credit + amount
    where id = recieverid;

    if (select bankname from account where id = senderid) != (select bankname from account where id = recieverid) then
        update account
        set credit = credit - 30
        where id = senderid;

        update account
        set credit = credit + 30
        where id = 4;
    end if;
END;
$$ LANGUAGE plpgsql;

begin;
    savepoint t1;

    call trans(1, 3, 500);

    savepoint t2;

    call trans(2, 1, 700);

    savepoint t3;

    call trans(2, 3, 100);

    select * from account;

    rollback to savepoint t3;
    rollback to savepoint t2;
    rollback to savepoint t1;

commit;