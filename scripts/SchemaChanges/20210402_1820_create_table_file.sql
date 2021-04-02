DO $$
DECLARE v_script_name VARCHAR := '20210402_1820_create_table_file.sql';
BEGIN
--
IF NOT EXISTS (SELECT FROM _provision WHERE script_name = v_script_name) THEN

	-- DROP TABLE file
	CREATE TABLE file(
	  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	, guid uuid DEFAULT uuid_generate_v4()
	, created TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, name VARCHAR
	, bytes BYTEA
	);
    
    INSERT INTO _provision(script_name) VALUES(v_script_name);
END IF;
--
END;
$$ LANGUAGE plpgsql;
