DECLARE @v_id_tenant INT = NULL;
BEGIN
--
SELECT @v_id_tenant = id 
  from tenant
 WHERE code = 'FBAUL'
 ;

INSERT INTO painting(id_tenant, name, author, description) values(@v_id_tenant, 'name 01','author 01', 'ficha de painting UM');
INSERT INTO painting(id_tenant, name, author, description) values(@v_id_tenant, 'name 02','author 02', 'ficha de painting DOIS');
INSERT INTO painting(id_tenant, name, author, description) values(@v_id_tenant, 'name 03','author 03', 'ficha de painting TRÊS');

--    
END;
