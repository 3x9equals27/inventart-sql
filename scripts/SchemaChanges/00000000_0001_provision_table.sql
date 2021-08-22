DECLARE @v_script_name NVARCHAR(200) = '00000000_0001_provision_table.sql';
--
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_CATALOG = DB_NAME() AND TABLE_SCHEMA = SCHEMA_NAME() 
				   AND TABLE_NAME = '_provision')
				 ) BEGIN
	-- DROP TABLE _provision;
	CREATE TABLE _provision(
	  script_name NVARCHAR(200) PRIMARY KEY
	, provisioned DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	);
	
	INSERT INTO _provision(script_name) VALUES(@v_script_name);
END
