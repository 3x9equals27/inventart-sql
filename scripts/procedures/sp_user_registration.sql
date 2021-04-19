/*
do $$ DECLARE i_guid uuid := null; begin
CALL sp_user_registration('email@gmail.com', '123456', i_guid);
RAISE NOTICE '%', CAST(i_guid AS TEXT);
END; $$
*/
DROP PROCEDURE IF EXISTS sp_user_registration;
CREATE OR REPLACE PROCEDURE sp_user_registration(i_email varchar, i_password_hash varchar, inout o_verification_guid uuid)
LANGUAGE plpgsql
AS $$
-- DECLARE v_out_of_date_registration INT := null;
BEGIN
--
-- delete registrations unverified for more than 24 hours
DELETE FROM user_ 
 WHERE verified = false
   AND created < (NOW() - INTERVAL '24 hour')::timestamp
;   
-- insert new user registration
INSERT INTO user_(email, password_hash) VALUES(i_email, i_password_hash) RETURNING verification_guid into  o_verification_guid;

--
END;
$$;
