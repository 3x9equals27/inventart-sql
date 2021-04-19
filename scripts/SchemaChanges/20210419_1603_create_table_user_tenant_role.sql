DO $$
DECLARE v_script_name VARCHAR := '20210419_1603_create_table_user_tenant_role.sql';
BEGIN
--
IF NOT EXISTS (SELECT FROM _provision WHERE script_name = v_script_name) THEN

	-- DROP TABLE user_tenant_role
	CREATE TABLE user_tenant_role(
	  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	, guid uuid DEFAULT uuid_generate_v4()
	, created TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, id_user INT NOT NULL
	, id_tenant INT NOT NULL
	, id_role INT NOT NULL
	, FOREIGN KEY(id_user) REFERENCES user_(id)
	, FOREIGN KEY(id_tenant) REFERENCES tenant(id)
	, FOREIGN KEY(id_role) REFERENCES role(id)
	, UNIQUE(id_user, id_tenant)
	);
    
    INSERT INTO _provision(script_name) VALUES(v_script_name);
END IF;
--    
END;
$$ LANGUAGE plpgsql;
