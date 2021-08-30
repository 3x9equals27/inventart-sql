-- WIP: Tenant in INSERT id hardcoded
CREATE OR ALTER PROCEDURE sp_upload_file_diagnostico(@i_guid UNIQUEIDENTIFIER, @i_name NVARCHAR(200), @i_bytes VARBINARY(max), @o_file_guid UNIQUEIDENTIFIER OUTPUT)
AS
DECLARE @v_id_diagnostico INT = null;
DECLARE @v_id_file INT = null;
BEGIN
--
    SELECT @v_id_diagnostico = d.id
	     , @v_id_file = d.id_file
	  FROM diagnostico d 
	 WHERE d.guid = @i_guid;
    --
    IF (@v_id_diagnostico IS NULL)
        RETURN; -- Diagnostico not found, WIP: throw Exception
    --
    IF (@v_id_file IS NOT NULL) BEGIN
        UPDATE [file]
           SET bytes = @i_bytes
		     , name = @i_name
             , updated = SYSUTCDATETIME()
			 , guid = NEWID()
         WHERE id = @v_id_file
        ;
		--
		SELECT @o_file_guid = guid FROM [file] WHERE id = @v_id_file;
    END;
    --
    IF (@v_id_file IS NULL) BEGIN
        INSERT INTO [file](name,bytes,id_tenant) VALUES(@i_name,@i_bytes,1);
		SELECT @v_id_file = id, @o_file_guid = guid FROM [file] WHERE id = scope_identity();
        UPDATE diagnostico
           SET id_file = @v_id_file
         WHERE id = @v_id_diagnostico
        ;
    END;
--
END
