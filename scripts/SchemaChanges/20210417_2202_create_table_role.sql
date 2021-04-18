DO $$
DECLARE v_script_name VARCHAR := '20210417_2202_create_table_role.sql';
BEGIN
--
IF NOT EXISTS (SELECT FROM _provision WHERE script_name = v_script_name) THEN

	-- DROP TABLE role
	CREATE TABLE role(
	  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	, guid uuid DEFAULT uuid_generate_v4()
	, created TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, name VARCHAR NOT NULL
	);
    
    INSERT INTO _provision(script_name) VALUES(v_script_name);
END IF;
--    
END;
$$ LANGUAGE plpgsql;
