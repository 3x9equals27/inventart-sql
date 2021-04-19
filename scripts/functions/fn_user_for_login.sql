-- select * from fn_user_for_login(email)
CREATE OR REPLACE FUNCTION fn_user_for_login(i_email VARCHAR) RETURNS TABLE(guid uuid, password_hash VARCHAR, verified BOOLEAN)
language plpgsql
AS $$
begin
return query
SELECT u.guid, u.password_hash, u.verified 
  FROM user_ as u
 WHERE u.email = i_email;
end;
$$;