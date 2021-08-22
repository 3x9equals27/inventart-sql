DECLARE @v_script_name NVARCHAR(200) = '20210402_1000_create_table_tenant.sql';
--
IF (NOT EXISTS (SELECT 1 FROM _provision WHERE script_name = @v_script_name)) BEGIN
	-- DROP TABLE tenant
	CREATE TABLE tenant(
	  id INT NOT NULL IDENTITY PRIMARY KEY
	, guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, created DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, updated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, code NVARCHAR(10) NOT NULL UNIQUE
	, short_name NVARCHAR(20) NOT NULL
	, long_name NVARCHAR(200) NOT NULL
	, [public] BIT NOT NULL
	);
--    
    INSERT INTO _provision(script_name) VALUES(@v_script_name);
END;
