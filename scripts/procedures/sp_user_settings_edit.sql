CREATE OR ALTER PROCEDURE sp_user_settings_edit(@i_user_guid UNIQUEIDENTIFIER, @i_first_name NVARCHAR(200), @i_last_name NVARCHAR(200), @i_default_tenant NVARCHAR(200), @i_default_language NVARCHAR(10))
AS
BEGIN
--
   UPDATE user_
	  SET first_name = @i_first_name
	    , last_name = @i_last_name
		, default_tenant = @i_default_tenant
		, default_language = @i_default_language
	WHERE guid = @i_user_guid
   ;
--
END
