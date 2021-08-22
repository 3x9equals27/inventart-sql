DECLARE @v_script_name NVARCHAR(200) =  '20210328_2220_create_table_diagnostico.sql';
--
IF (NOT EXISTS (SELECT 1 FROM _provision WHERE script_name = @v_script_name)) BEGIN
	-- DROP TABLE diagnostico
	CREATE TABLE diagnostico(
	  id INT NOT NULL IDENTITY PRIMARY KEY
	, id_tenant INT NOT NULL FOREIGN KEY REFERENCES tenant(id)
	, guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, created DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, updated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, description NVARCHAR(200)
	, id_file INT NULL FOREIGN KEY REFERENCES [file](id)
	);
--    
    INSERT INTO _provision(script_name) VALUES(@v_script_name);
END;
