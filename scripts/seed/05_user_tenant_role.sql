insert into user_tenant_role(id_user, id_tenant, id_role)
select u.id as id_user
     , t.id as id_tenant
	 , r.id as id_role
  from role as r
 inner join user_ as u on u.email = 'guest@inventart.com'
 inner join tenant as t on t.id > 0
 where r.name = 'role:guest'
;