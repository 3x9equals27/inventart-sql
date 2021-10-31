CREATE OR ALTER PROCEDURE sp_diagnostico_create(@i_tenant NVARCHAR(10), @i_description NVARCHAR(200), @o_diagnostico_guid UNIQUEIDENTIFIER OUTPUT)
AS
	DECLARE @v_id_tenant INT = null;
BEGIN
	SELECT @v_id_tenant = id FROM tenant WHERE code = @i_tenant;
	INSERT INTO diagnostico(id_tenant, description) values(@v_id_tenant, @i_description);
	SELECT @o_diagnostico_guid = guid from diagnostico where id = scope_identity();
END

