DO $$
DECLARE v_id_tenant int;
BEGIN
--
SELECT id into v_id_tenant 
  from tenant
 WHERE code = 'FBAUL'
 ;

INSERT INTO diagnostico(id_tenant, description) values(v_id_tenant, 'ficha de diagnostico UM');
INSERT INTO diagnostico(id_tenant, description) values(v_id_tenant, 'ficha de diagnostico DOIS');
INSERT INTO diagnostico(id_tenant, description) values(v_id_tenant, 'ficha de diagnostico TRÊS');

--    
END;
$$ LANGUAGE plpgsql;


