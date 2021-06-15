-- select * from fn_user_list_role_all(i_tenant_code)
-- select * from fn_user_list_role_all('FBAUL')
DROP FUNCTION IF EXISTS fn_user_list_role_all;
CREATE OR REPLACE FUNCTION fn_user_list_role_all(i_tenant_code VARCHAR) RETURNS TABLE(guid uuid, email VARCHAR, first_name VARCHAR, last_name VARCHAR, role VARCHAR, is_guest_user boolean)
LANGUAGE plpgsql
AS $$
DECLARE v_id_tenant INT := null;
DECLARE v_id_role_visitor INT := null;
begin
--
select id 
  into v_id_tenant 
  from tenant 
 where code = i_tenant_code;
--	
select id 
  into v_id_role_visitor 
  from role 
 where name = 'role:visitor';
--
return query
--
SELECT u.guid
     , u.email 
     , u.first_name 
     , u.last_name 
     , r.name as role
     , u.is_guest_user 
  FROM user_ u
  left join user_tenant_role utr on utr.id_user = u.id and utr.id_tenant = v_id_tenant
 inner join role r on r.id = coalesce(utr.id_role,v_id_role_visitor)
 WHERE u.verified = true
 ORDER BY u.is_guest_user = false asc
        , u.first_name
        , u.last_name 
 ;
end;
$$;
