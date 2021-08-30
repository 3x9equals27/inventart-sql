CREATE OR ALTER PROCEDURE sp_user_tenant(@i_guid UNIQUEIDENTIFIER, @i_code NVARCHAR(10))
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
 where t.code = @i_code
 ;
--
end
