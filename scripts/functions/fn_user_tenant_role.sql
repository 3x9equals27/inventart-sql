-- select * from fn_user_tenant_role(i_user_guid, i_tenant_code);
CREATE OR REPLACE FUNCTION fn_user_tenant_role(i_user_guid uuid, i_tenant_code VARCHAR) 
RETURNS VARCHAR
language plpgsql
AS $$
DECLARE v_id_user INT := null;
DECLARE v_id_tenant INT := null;
DECLARE v_role VARCHAR := null;
DECLARE v_is_guest_user boolean := false;
begin
--
select id, is_guest_user
  into v_id_user, v_is_guest_user
  from user_ 
 where guid = i_user_guid
 ;
select id 
  into v_id_tenant 
  from tenant 
 where code = i_tenant_code;
--
select r.name into v_role
  from user_tenant_role as utr
 inner join role as r on r.id = utr.id_role
 where utr.id_user = v_id_user
   and utr.id_tenant = v_id_tenant
 ;
--
return coalesce(v_role, case when v_is_guest_user then 'role:guest' else 'role:visitor' end);
--
end;
$$;
