DECLARE @v_script_name NVARCHAR(200) = '20210417_2202_create_table_role.sql';
--
IF (NOT EXISTS (SELECT 1 FROM _provision WHERE script_name = @v_script_name)) BEGIN
	-- DROP TABLE role
	CREATE TABLE role(
	  id INT NOT NULL IDENTITY PRIMARY KEY
	, guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, created DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, updated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, name NVARCHAR(50) NOT NULL UNIQUE
	);
--    
    INSERT INTO _provision(script_name) VALUES(@v_script_name);
END;
