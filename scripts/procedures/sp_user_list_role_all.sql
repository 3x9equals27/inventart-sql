CREATE OR ALTER PROCEDURE sp_user_list_role_all(@i_tenant_code NVARCHAR(10))
AS
DECLARE @v_id_tenant INT = null;
DECLARE @v_id_role_visitor INT = null;
begin
--
select @v_id_tenant = id 
  from tenant 
 where code = @i_tenant_code;
--	
select @v_id_role_visitor = id 
  from role 
 where name = 'role:visitor';
--
SELECT u.guid
     , u.email 
     , u.first_name 
     , u.last_name 
     , r.name as role
     , u.is_guest_user 
  FROM user_ u
  left join user_tenant_role utr on utr.id_user = u.id and utr.id_tenant = @v_id_tenant
 inner join role r on r.id = coalesce(utr.id_role,@v_id_role_visitor)
 WHERE u.verified = 1
 ORDER BY CASE WHEN u.is_guest_user = 0 THEN 1 ELSE 0 END asc
        , u.first_name
        , u.last_name 
 ;
--
end
