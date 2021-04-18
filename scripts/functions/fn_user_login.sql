-- select * from fn_user_login(guid)
CREATE OR REPLACE FUNCTION fn_user_login(guid uuid) RETURNS TABLE(email VARCHAR, password VARCHAR, verified BOOLEAN)
LANGUAGE SQL
AS $$ 
SELECT email, password, verified 
  FROM user_
 WHERE guid = guid;
$$;
