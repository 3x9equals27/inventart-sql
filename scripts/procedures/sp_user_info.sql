CREATE OR ALTER PROCEDURE sp_user_info(@i_guid UNIQUEIDENTIFIER)
AS
begin
--
SELECT u.email
     , u.first_name
     , u.last_name
     , u.default_tenant
	 , u.default_language
  FROM user_ as u
 WHERE u.guid = @i_guid;
--
end