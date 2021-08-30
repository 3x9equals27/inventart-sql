CREATE OR ALTER PROCEDURE sp_user_registration(@i_email NVARCHAR(200), @i_password_hash NVARCHAR(MAX), @i_first_name NVARCHAR(200), @i_last_name NVARCHAR(200), @i_default_tenant NVARCHAR(200), @o_verification_guid UNIQUEIDENTIFIER OUTPUT)
AS
BEGIN
--
-- delete registrations unverified for more than 24 hours
DELETE FROM user_ 
 WHERE verified = 0
   AND created < (DATEADD(HOUR,-24,SYSUTCDATETIME()))
;   
-- insert new user registration
INSERT INTO user_(email, password_hash, first_name, last_name, default_tenant) VALUES(@i_email, @i_password_hash, @i_first_name, @i_last_name, @i_default_tenant);
SELECT @o_verification_guid = verification_guid FROM user_ WHERE id = scope_identity();
--
END

