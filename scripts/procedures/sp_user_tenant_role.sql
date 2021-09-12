CREATE OR ALTER PROCEDURE sp_user_tenant_role(@i_user_guid UNIQUEIDENTIFIER, @i_tenant_code NVARCHAR(10))
AS
DECLARE @v_id_user INT = null;
DECLARE @v_id_tenant INT = null;
DECLARE @v_role NVARCHAR(50) = null;
DECLARE @v_is_guest_user BIT = 0;
begin
--
select TOP 1 @v_id_user = id
     , @v_is_guest_user = is_guest_user
  from user_ 
 where guid = @i_user_guid
 ;
select TOP 1 @v_id_tenant = id  
  from tenant 
 where code = @i_tenant_code;
--
select TOP 1 @v_role = r.name
  from user_tenant_role as utr
 inner join role as r on r.id = utr.id_role
 where utr.id_user = @v_id_user
   and utr.id_tenant = @v_id_tenant
 ;
--
SELECT coalesce(@v_role, case when @v_is_guest_user = 1 then 'role:guest' else 'role:visitor' end) AS [role];
--
end
