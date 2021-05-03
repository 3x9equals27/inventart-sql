-- select * from fn_user_info(guid)
CREATE OR REPLACE FUNCTION fn_user_info(i_guid uuid) RETURNS TABLE(email VARCHAR, first_name VARCHAR, last_name VARCHAR, default_tenant VARCHAR, default_tenant_role VARCHAR)
language plpgsql
AS $$
begin
return query
SELECT u.email
     , u.first_name
     , u.last_name
     , u.default_tenant
     , coalesce(r.name,case when u.is_guest_user then 'role:guest' else 'role:visitor' end) as default_tenant_role
  FROM user_ as u
  left join tenant t on t.code = u.default_tenant
  left join user_tenant_role utr on utr.id_user = u.id and utr.id_tenant = t.id
  left join role r on r.id = utr.id_role 
 WHERE u.guid = i_guid;
end;
$$;