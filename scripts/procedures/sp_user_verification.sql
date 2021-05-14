/*
do $$ DECLARE o_success BOOLEAN := false; begin
CALL sp_user_verification(i_verification_guid, o_success);
RAISE NOTICE '%', CAST(o_success AS TEXT);
END; $$
*/
DROP PROCEDURE IF EXISTS sp_user_verification;
CREATE OR REPLACE PROCEDURE sp_user_verification(i_verification_guid uuid, INOUT o_success BOOLEAN)
LANGUAGE plpgsql
AS $$
  DECLARE v_user_to_verify INT := null;
BEGIN
--
-- unverified user with provided verification_guid
-- Your email address could not be verified.
	SELECT id INTO v_user_to_verify
	  FROM user_
	 WHERE verification_guid = i_verification_guid
	   AND verified = false
	;
	--
	IF (v_user_to_verify IS NOT NULL) THEN
	   UPDATE user_
	      SET verified = true
		    , verification_guid = null
		WHERE id = v_user_to_verify
	   ;
		o_success := true;
	END IF;
	--
	IF (v_user_to_verify IS NULL) THEN
		o_success := false;
	END IF;
--
END;
$$;
