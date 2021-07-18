/*
do $$ 
DECLARE i_user_guid uuid := '';
DECLARE i_tenant VARCHAR := '';
DECLARE i_role VARCHAR := '';
begin
CALL sp_user_role_change(i_user_guid, i_tenant, i_role);
end; $$
*/
DROP PROCEDURE IF EXISTS sp_user_role_change;
CREATE OR REPLACE PROCEDURE sp_user_role_change(i_user_guid uuid, i_tenant VARCHAR, i_role VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
--
   SELECT * FROM user_;
--
END;
$$;
