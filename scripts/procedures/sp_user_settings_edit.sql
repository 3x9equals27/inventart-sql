/*
do $$ 
DECLARE i_user_guid uuid := '';
DECLARE i_first_name VARCHAR := '';
DECLARE i_last_name VARCHAR := '';
DECLARE i_default_tenant VARCHAR := '';
DECLARE i_language VARCHAR := '';
begin
CALL sp_user_settings_edit(i_user_guid, i_first_name, i_last_name, i_default_tenant, i_language);
end; $$
*/
DROP PROCEDURE IF EXISTS sp_user_settings_edit;
CREATE OR REPLACE PROCEDURE sp_user_settings_edit(i_user_guid uuid, i_first_name VARCHAR, i_last_name VARCHAR, i_default_tenant VARCHAR, i_default_language VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
--
   UPDATE user_
	  SET first_name = i_first_name
	    , last_name = i_last_name
		, default_tenant = i_default_tenant
		, default_language = i_default_language
	WHERE guid = i_user_guid
   ;
--
END;
$$;
