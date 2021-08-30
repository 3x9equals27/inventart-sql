CREATE OR ALTER PROCEDURE sp_user_verification(@i_verification_guid UNIQUEIDENTIFIER, @o_success BIT OUTPUT)
AS
  DECLARE @v_user_to_verify INT = null;
BEGIN
--
-- unverified user with provided verification_guid
-- Your email address could not be verified.
	SELECT TOP 1 @v_user_to_verify = id
	  FROM user_
	 WHERE verification_guid = @i_verification_guid
	   AND verified = 0
	;
	--
	IF (@v_user_to_verify IS NOT NULL) BEGIN
	   UPDATE user_
	      SET verified = 1
		    , verification_guid = null
		WHERE id = @v_user_to_verify
	   ;
		SET @o_success = 1;
	END;
	--
	IF (@v_user_to_verify IS NULL) BEGIN
		SET @o_success = 0;
	END;
--
END;
