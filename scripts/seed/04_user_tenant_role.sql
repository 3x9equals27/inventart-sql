insert into user_tenant_role(id_user, id_tenant, id_role)
select u.id as id_user
     , t.id as id_tenant
	 , r.id as id_role
  from role as r
 inner join user_ as u on u.email = 'guest@inventart'
 inner join tenant as t on t.[public] = 1
  left join user_tenant_role utr on utr.id_user = u.id and utr.id_tenant = t.id and utr.id_role = r.id
 where r.name = 'role:guest'
   and utr.id is null
;

insert into user_tenant_role(id_user, id_tenant, id_role)
select u.id as id_user
     , t.id as id_tenant
	 , r.id as id_role
  from role as r
 inner join user_ as u on u.email = 'guest@inventart'
 inner join tenant as t on t.[public] = 0
  left join user_tenant_role utr on utr.id_user = u.id and utr.id_tenant = t.id and utr.id_role = r.id
 where r.name = 'role:disabled'
   and utr.id is null
;