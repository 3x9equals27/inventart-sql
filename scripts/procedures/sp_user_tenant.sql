-- select * from fn_user_tenant(guid)
CREATE OR REPLACE FUNCTION fn_user_tenant(i_guid uuid, i_code VARCHAR) RETURNS TABLE(code VARCHAR, short_name VARCHAR, long_name VARCHAR, role VARCHAR)
language plpgsql
AS $$
begin
return query
select t.code, t.short_name, t.long_name
     , coalesce(r.name,case when u.is_guest_user then 'role:guest' else 'role:visitor' end) as role
  from tenant t
  left join user_tenant_role utr
  	inner join user_ u on u.id = utr.id_user and u.guid = i_guid
  	inner join role r on r.id = utr.id_role
  	on utr.id_tenant = t.id
 where t.code = i_code
 ;
end;
$$;
