--
CREATE OR ALTER PROCEDURE sp_auth_password_reset_step2b(@i_password_reset_guid UNIQUEIDENTIFIER, @i_password_hash NVARCHAR(MAX), @o_success BIT OUTPUT)
AS
BEGIN
--
	SET @o_success = 0;
	--
   UPDATE user_
	  SET password_reset_guid = null
	    , password_hash = @i_password_hash
    WHERE password_reset_guid = @i_password_reset_guid
	;
	--
	IF @@ROWCOUNT > 0
	SET @o_success = 1;
--
END;
