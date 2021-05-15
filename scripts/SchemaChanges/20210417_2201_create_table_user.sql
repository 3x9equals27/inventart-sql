DO $$
DECLARE v_script_name VARCHAR := '20210417_2201_create_table_user.sql';
BEGIN
--
IF NOT EXISTS (SELECT FROM _provision WHERE script_name = v_script_name) THEN

	-- DROP TABLE user
	CREATE TABLE user_(
	  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	, guid uuid DEFAULT uuid_generate_v4()
	, created TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
	, is_guest_user BOOLEAN NOT NULL DEFAULT false
	, email VARCHAR NOT NULL UNIQUE
	, first_name VARCHAR NOT NULL
	, last_name VARCHAR NOT NULL
	, default_tenant VARCHAR NULL
	, default_language VARCHAR NOT NULL DEFAULT 'en-GB'
	, password_hash VARCHAR NOT NULL
	, verified BOOLEAN NOT NULL DEFAULT false
	, verification_guid uuid DEFAULT uuid_generate_v4()
	, password_reset_guid uuid NULL
	, password_reset_guid_date TIMESTAMPTZ NULL
	);
    
    INSERT INTO _provision(script_name) VALUES(v_script_name);
END IF;
--    
END;
$$ LANGUAGE plpgsql;
