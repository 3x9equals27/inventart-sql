DROP PROCEDURE IF EXISTS sp_upload_file_diagnostico;
CREATE OR REPLACE PROCEDURE sp_upload_file_diagnostico(p_guid uuid, p_name varchar, p_bytes BYTEA, INOUT o_file_guid uuid)
LANGUAGE plpgsql
AS $$
DECLARE v_id_diagnostico INT := null;
DECLARE v_id_file INT := null;
BEGIN
--
    SELECT d.id, d.id_file INTO v_id_diagnostico, v_id_file FROM diagnostico d WHERE d.guid = p_guid;
    --
    IF (v_id_diagnostico IS NULL) THEN
        RETURN; -- Diagnostico not found, WIP: throw Exception
    END IF;
    --
    IF (v_id_file IS NOT NULL) THEN
        UPDATE file
           SET bytes = p_bytes
		     , name = p_name
             , updated = NOW()
			 , guid = uuid_generate_v4()
         WHERE id = v_id_file
         RETURNING guid INTO o_file_guid
        ;
    END IF;
    --
    IF (v_id_file IS NULL) THEN
        INSERT INTO file(name,bytes) VALUES(p_name,p_bytes) RETURNING id, guid INTO v_id_file, o_file_guid;
        UPDATE diagnostico
           SET id_file = v_id_file
         WHERE id = v_id_diagnostico
        ;
    END IF;
--
END;
$$;
