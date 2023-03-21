drop function retrive_ordered_customers(int, int);

CREATE OR REPLACE FUNCTION retrive_ordered_customers(
    start int,
    "end" int
)
RETURNS TABLE (
    customer_id int,
    store_id smallint,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
    address_id smallint,
    activebool boolean,
    create_date date,
    last_update timestamp,
    active integer
)
AS $$
BEGIN
    if $1 < 0 or $2 < 0 then
      raise exception 'negative argument';
    end if;
    if $1 > 600 or $2 > 600 then
      raise exception 'argument is more than 600';
    end if;
    RETURN QUERY
        select * from customer
        ORDER BY address_id
        limit ($2 - $1 + 1) offset $1;
END;
$$ LANGUAGE plpgsql;
