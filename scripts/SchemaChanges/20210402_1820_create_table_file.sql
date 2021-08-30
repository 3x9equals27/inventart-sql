DECLARE @v_script_name NVARCHAR(200) =  '20210402_1820_create_table_file.sql';
--
IF (NOT EXISTS (SELECT 1 FROM _provision WHERE script_name = @v_script_name)) BEGIN
	-- DROP TABLE file
	CREATE TABLE [file](
	  id INT NOT NULL IDENTITY PRIMARY KEY
	, id_tenant INT NOT NULL FOREIGN KEY REFERENCES tenant(id)
	, guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, created DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, updated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, name NVARCHAR(200)
	, bytes VARBINARY(max) NOT NULL
	);
--    
    INSERT INTO _provision(script_name) VALUES(@v_script_name);
END;
