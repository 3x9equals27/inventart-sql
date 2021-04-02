DO $$
DECLARE v_script_name VARCHAR := '20210328_2220_create_table_diagnostico.sql';
BEGIN
--
IF NOT EXISTS (SELECT FROM _provision WHERE script_name = v_script_name) THEN

	-- DROP TABLE diagnostico
	CREATE TABLE diagnostico(
	  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	, guid uuid DEFAULT uuid_generate_v4()
	, created TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, description VARCHAR
	, id_file INT
	, FOREIGN KEY(id_file) REFERENCES file(id)
	);
    
    INSERT INTO _provision(script_name) VALUES(v_script_name);
END IF;
--    
END;
$$ LANGUAGE plpgsql;
