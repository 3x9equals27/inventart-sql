DO $$
DECLARE v_script_name VARCHAR := '20210402_1000_create_table_tenant.sql';
BEGIN
--
IF NOT EXISTS (SELECT FROM _provision WHERE script_name = v_script_name) THEN

	-- DROP TABLE tenant
	CREATE TABLE tenant(
	  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	, guid uuid DEFAULT uuid_generate_v4()
	, created TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, code VARCHAR NOT NULL UNIQUE
	, short_name VARCHAR NOT NULL
	, long_name VARCHAR NOT NULL
	, public BOOLEAN NOT NULL
	);
    
    INSERT INTO _provision(script_name) VALUES(v_script_name);
END IF;
--    
END;
$$ LANGUAGE plpgsql;
