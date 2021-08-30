CREATE OR ALTER PROCEDURE sp_user_tenants(@i_guid UNIQUEIDENTIFIER)
AS
begin
--
select t.code, t.short_name, t.long_name
     , coalesce(r.name,case when u.is_guest_user = 1 then 'role:guest' else 'role:visitor' end) as role
  from tenant t
  left join user_tenant_role utr
  	inner join user_ u on u.id = utr.id_user and u.guid = @i_guid
  	inner join role r on r.id = utr.id_role
  	on utr.id_tenant = t.id
 where (u.id is not null or t.[public] = 1)
   and coalesce(r.name,'') != 'role:disabled'
 order by CASE WHEN u.default_tenant = t.code THEN 1 ELSE 0 END
        , CASE WHEN r.name is null THEN 1 ELSE 0 END
        , t.short_name
 ;
--
end
