/*
do $$ DECLARE p_success BOOLEAN := false; begin
CALL sp_user_verification(p_verification_guid, p_success);
RAISE NOTICE '%', CAST(p_success AS TEXT);
END; $$
*/
DROP PROCEDURE IF EXISTS sp_user_verification;
CREATE OR REPLACE PROCEDURE sp_user_verification(p_verification_guid uuid, INOUT p_success BOOLEAN)
LANGUAGE plpgsql
AS $$
  DECLARE v_user_to_verify INT := null;
BEGIN
--
-- unverified user with provided verification_guid
-- Your email address could not be verified.
	SELECT id INTO v_user_to_verify
	  FROM user_
	 WHERE verification_guid = p_verification_guid
	   AND verified = false
	;
	--
	IF (v_user_to_verify IS NOT NULL) THEN
	   UPDATE user_
	      SET verified = true
		WHERE id = v_user_to_verify
	   ;
		p_success := true;
	END IF;
	--
	IF (v_user_to_verify IS NULL) THEN
		p_success := false;
	END IF;
--
END;
$$;
