DECLARE @v_script_name NVARCHAR(200) = '20210419_1603_create_table_user_tenant_role.sql';
--
IF (NOT EXISTS (SELECT 1 FROM _provision WHERE script_name = @v_script_name)) BEGIN
	-- DROP TABLE user_tenant_role
	CREATE TABLE user_tenant_role(
	  id INT NOT NULL IDENTITY PRIMARY KEY
	, guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, created DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, updated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, id_user INT NOT NULL FOREIGN KEY REFERENCES user_(id)
	, id_tenant INT NOT NULL FOREIGN KEY REFERENCES tenant(id)
	, id_role INT NOT NULL FOREIGN KEY REFERENCES role(id)
	, CONSTRAINT UC_user_tenant_role UNIQUE(id_user, id_tenant)
	);
--    
    INSERT INTO _provision(script_name) VALUES(@v_script_name);
END;
