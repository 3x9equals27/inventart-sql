--
CREATE OR ALTER PROCEDURE sp_auth_password_reset_step2a(@i_password_reset_guid UNIQUEIDENTIFIER, @o_exists BIT OUTPUT)
AS
BEGIN
--
IF EXISTS(SELECT * FROM user_ WHERE password_reset_guid = @i_password_reset_guid)
	SET @o_exists = 1;
ELSE
	SET @o_exists = 0;
--
END;
