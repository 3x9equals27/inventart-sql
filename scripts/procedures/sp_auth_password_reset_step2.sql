/*
do $$ 
DECLARE i_password_reset_guid uuid := null;
DECLARE i_password_hash VARCHAR := null;
DECLARE o_success BOOLEAN := false;
begin
CALL sp_auth_password_reset_step2(i_password_reset_guid, i_password_hash, o_success);
RAISE NOTICE '%', CAST(o_success AS TEXT);
end; $$
*/
DROP PROCEDURE IF EXISTS sp_auth_password_reset_step2;
CREATE OR REPLACE PROCEDURE sp_auth_password_reset_step2(i_password_reset_guid uuid, i_password_hash VARCHAR, INOUT o_success boolean)
LANGUAGE plpgsql
AS $$
BEGIN
--
	o_success := false;
	--
   UPDATE user_
	  SET password_reset_guid = null
	    , password_hash = i_password_hash
	WHERE password_reset_guid = i_password_reset_guid
	RETURNING true INTO o_success
   ;
--
END;
$$;
