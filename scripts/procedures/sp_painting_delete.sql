CREATE OR ALTER PROCEDURE sp_painting_delete @i_tenant NVARCHAR(10), @i_guid UNIQUEIDENTIFIER
AS
BEGIN
--
	DECLARE @id_file INT = NULL;

    SELECT @id_file = f.id
      FROM painting d
	 INNER JOIN tenant t on t.id = d.id_tenant
     INNER JOIN [file] f ON f.id = d.id_file
	 WHERE d.guid = @i_guid
	   AND t.code = @i_tenant
	;
--
    DELETE d
      FROM painting d
	 INNER JOIN tenant t on t.id = d.id_tenant
	 WHERE d.guid = @i_guid
	   AND t.code = @i_tenant
	;
--
	DELETE f
	  FROM [file] f
	 WHERE f.id = @id_file
	;
--
END
