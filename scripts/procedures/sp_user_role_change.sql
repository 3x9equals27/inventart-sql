/*
do $$ 
DECLARE i_user_guid uuid := '';
DECLARE i_tenant VARCHAR := '';
DECLARE i_role VARCHAR := 'role:';
begin
	CALL sp_user_role_change(i_user_guid, i_tenant, i_role);
end; $$
*/
DROP PROCEDURE IF EXISTS sp_user_role_change;
CREATE OR REPLACE PROCEDURE sp_user_role_change(i_user_guid uuid, i_tenant VARCHAR, i_role VARCHAR)
LANGUAGE plpgsql
AS $$
	DECLARE v_id_user INT := null;
	DECLARE v_id_tenant INT := null;
	DECLARE v_id_role INT := null;
BEGIN
--
	SELECT id INTO v_id_user FROM user_ WHERE guid = i_user_guid;
	SELECT id INTO v_id_tenant FROM tenant WHERE code = i_tenant;
	SELECT id INTO v_id_role FROM role WHERE name = i_role;

	IF (exists(select 1 from user_tenant_role where id_tenant = v_id_tenant and id_user = v_id_user)) then
		UPDATE user_tenant_role
		   SET id_role = v_id_role
		 where id_tenant = v_id_tenant 
		   and id_user = v_id_user
		   ;
	else
		insert into user_tenant_role(id_user, id_tenant, id_role)
		values(v_id_user, v_id_tenant, v_id_role);
    END IF;

--
END;
$$;
