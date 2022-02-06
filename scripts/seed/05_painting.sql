DECLARE @v_id_tenant INT = NULL;
BEGIN
--
SELECT @v_id_tenant = id 
  from tenant
 WHERE code = 'FBAUL'
 ;

INSERT INTO painting(id_tenant, description) values(@v_id_tenant, 'ficha de painting UM');
INSERT INTO painting(id_tenant, description) values(@v_id_tenant, 'ficha de painting DOIS');
INSERT INTO painting(id_tenant, description) values(@v_id_tenant, 'ficha de painting TRÊS');

--    
END;
