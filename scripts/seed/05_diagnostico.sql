DECLARE @v_id_tenant INT = NULL;
BEGIN
--
SELECT @v_id_tenant = id 
  from tenant
 WHERE code = 'FBAUL'
 ;

INSERT INTO diagnostico(id_tenant, description) values(@v_id_tenant, 'ficha de diagnostico UM');
INSERT INTO diagnostico(id_tenant, description) values(@v_id_tenant, 'ficha de diagnostico DOIS');
INSERT INTO diagnostico(id_tenant, description) values(@v_id_tenant, 'ficha de diagnostico TRÊS');

--    
END;
