CREATE OR ALTER PROCEDURE sp_painting_update(@i_tenant NVARCHAR(10), @i_guid UNIQUEIDENTIFIER, @i_name NVARCHAR(500), @i_author NVARCHAR(500), @i_description NVARCHAR(500))
AS
	DECLARE @v_id_tenant INT = null;
	DECLARE @v_id_painting INT = null;
BEGIN
	SELECT @v_id_tenant = id FROM tenant WHERE code = @i_tenant;
	SELECT @v_id_painting = id FROM painting WHERE guid = @i_guid;

	UPDATE P
	   SET P.name = @i_name
	     , P.author = @i_author
		 , P.description = @i_description
	  FROM painting P
	 WHERE P.id = @v_id_painting
	   AND P.id_tenant = @v_id_tenant
--
END

