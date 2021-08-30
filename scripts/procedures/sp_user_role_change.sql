CREATE OR ALTER PROCEDURE sp_user_role_change(@i_user_guid UNIQUEIDENTIFIER, @i_tenant NVARCHAR(10), @i_role NVARCHAR(50))
AS
	DECLARE @v_id_user INT = null;
	DECLARE @v_id_tenant INT = null;
	DECLARE @v_id_role INT = null;
BEGIN
--
	SELECT @v_id_user = id FROM user_ WHERE guid = @i_user_guid;
	SELECT @v_id_tenant = id FROM tenant WHERE code = @i_tenant;
	SELECT @v_id_role = id FROM role WHERE name = @i_role;

	IF (exists(select 1 from user_tenant_role where id_tenant = @v_id_tenant and id_user = @v_id_user)) BEGIN
		UPDATE user_tenant_role
		   SET id_role = @v_id_role
		 where id_tenant = @v_id_tenant 
		   and id_user = @v_id_user
		   ;
		   END
	else BEGIN
		insert into user_tenant_role(id_user, id_tenant, id_role)
		values(@v_id_user, @v_id_tenant, @v_id_role);
    END;
--
END;
