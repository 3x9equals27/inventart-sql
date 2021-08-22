DECLARE @v_script_name NVARCHAR(200) = '20210417_2201_create_table_user.sql';
--
IF (NOT EXISTS (SELECT 1 FROM _provision WHERE script_name = @v_script_name)) BEGIN
	-- DROP TABLE user
	CREATE TABLE user_(
	  id INT NOT NULL IDENTITY PRIMARY KEY
	, guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, created DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, updated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	, is_guest_user BIT NOT NULL DEFAULT 0
	, email NVARCHAR(200) NOT NULL UNIQUE
	, first_name NVARCHAR(200) NOT NULL
	, last_name NVARCHAR(200) NOT NULL
	, default_tenant NVARCHAR(200) NULL
	, default_language NVARCHAR(10) NOT NULL DEFAULT 'en-GB'
	, password_hash NVARCHAR(MAX) NOT NULL
	, verified BIT NOT NULL DEFAULT 0
	, verification_guid UNIQUEIDENTIFIER DEFAULT NEWID()
	, password_reset_guid UNIQUEIDENTIFIER NULL
	, password_reset_guid_date DATETIME2 NULL
	);
--    
    INSERT INTO _provision(script_name) VALUES(@v_script_name);
END;
