drop function get_addresses();

CREATE OR REPLACE FUNCTION get_addresses()
RETURNS TABLE (address varchar(255))
AS $$
BEGIN
  RETURN QUERY
    SELECT address.address FROM address
    WHERE address.address LIKE '%11%' AND city_id BETWEEN 400 AND 600;
END;
$$ LANGUAGE plpgsql;