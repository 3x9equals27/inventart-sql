--
CREATE OR ALTER PROCEDURE sp_auth_password_reset_step1(@i_email NVARCHAR(200), @o_guid UNIQUEIDENTIFIER OUTPUT)
AS 
BEGIN
--
   UPDATE user_
	  SET password_reset_guid = NEWID()
	    , password_reset_guid_date = SYSUTCDATETIME()
	WHERE email = @i_email
	  and (password_reset_guid is null or (password_reset_guid_date < (DATEADD(minute,-5,SYSUTCDATETIME()))))
   ;

   SET @o_guid = (SELECT TOP 1 password_reset_guid FROM user_ WHERE email = @i_email);
--
END;
