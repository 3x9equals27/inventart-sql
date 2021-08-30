CREATE OR ALTER PROCEDURE sp_user_for_login(@i_email NVARCHAR(200))
AS
BEGIN
--
SELECT u.guid, u.password_hash, u.verified 
  FROM user_ as u
 WHERE u.email = @i_email;
--
END
