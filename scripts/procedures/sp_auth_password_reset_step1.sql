/*
do $$ 
DECLARE i_email VARCHAR := ''; 
DECLARE o_guid uuid := null; 
begin
CALL sp_auth_password_reset_step1(i_email, o_guid);
RAISE NOTICE '%', CAST(o_guid AS TEXT);
end; $$
*/
DROP PROCEDURE IF EXISTS sp_auth_password_reset_step1;
CREATE OR REPLACE PROCEDURE sp_auth_password_reset_step1(i_email VARCHAR, INOUT o_guid uuid)
LANGUAGE plpgsql
AS $$
BEGIN
--
   UPDATE user_
	  SET password_reset_guid = uuid_generate_v4()
	    , password_reset_guid_date = NOW()::timestamp
	WHERE email = i_email
	  and (password_reset_guid is null or password_reset_guid_date < (NOW() - INTERVAL '5 minute')::timestamp)
	RETURNING password_reset_guid INTO o_guid
   ;
--
END;
$$;
