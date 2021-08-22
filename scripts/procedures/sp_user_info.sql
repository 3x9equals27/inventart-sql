-- select * from fn_user_info(guid)
CREATE OR REPLACE FUNCTION fn_user_info(i_guid uuid) RETURNS TABLE(email VARCHAR, first_name VARCHAR, last_name VARCHAR, default_tenant VARCHAR, default_language VARCHAR)
language plpgsql
AS $$
begin
return query
SELECT u.email
     , u.first_name
     , u.last_name
     , u.default_tenant
	 , u.default_language
  FROM user_ as u
 WHERE u.guid = i_guid;
end;
$$;