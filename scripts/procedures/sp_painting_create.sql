CREATE OR ALTER PROCEDURE sp_painting_create(@i_tenant NVARCHAR(10), @i_description NVARCHAR(200), @o_painting_guid UNIQUEIDENTIFIER OUTPUT)
AS
	DECLARE @v_id_tenant INT = null;
BEGIN
	SELECT @v_id_tenant = id FROM tenant WHERE code = @i_tenant;
	INSERT INTO painting(id_tenant, description) values(@v_id_tenant, @i_description);
	SELECT @o_painting_guid = guid from painting where id = scope_identity();
END

