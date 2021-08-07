-- select * from fn_user_tenants(guid)
CREATE OR REPLACE FUNCTION fn_user_tenants(i_guid uuid) RETURNS TABLE(code VARCHAR, short_name VARCHAR, long_name VARCHAR, role VARCHAR)
language plpgsql
AS $$
begin
return query
--
select t.code, t.short_name, t.long_name
     , coalesce(r.name,case when u.is_guest_user then 'role:guest' else 'role:visitor' end) as role
  from tenant t
  left join user_tenant_role utr
  	inner join user_ u on u.id = utr.id_user and u.guid = i_guid
  	inner join role r on r.id = utr.id_role
  	on utr.id_tenant = t.id
 where (u.id is not null or t.public = true)
   and coalesce(r.name,'') != 'role:disabled'
 order by u.default_tenant = t.code
        , r.name is null
        , t.short_name
 ;
end;
$$;
