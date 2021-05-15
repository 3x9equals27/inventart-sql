/*
do $$ 
DECLARE i_password_reset_guid uuid := 'c37edd9d-f8b6-4ac5-813c-5301b1ae8db7'; 
DECLARE o_exists boolean := null; 
begin
CALL sp_auth_password_reset_step2a(i_password_reset_guid, o_exists);
RAISE NOTICE '%', CAST(o_exists AS TEXT);
end; $$
*/
DROP PROCEDURE IF EXISTS sp_auth_password_reset_step2a;
CREATE OR REPLACE PROCEDURE sp_auth_password_reset_step2a(i_password_reset_guid uuid, INOUT o_exists boolean)
LANGUAGE plpgsql
AS $$
BEGIN
--
o_exists := exists(SELECT * FROM user_ WHERE password_reset_guid = i_password_reset_guid);
--
END;
$$;
