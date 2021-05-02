/*
do $$ DECLARE i_guid uuid := null; begin
CALL sp_user_registration('email@gmail.com', '123456', i_guid);
RAISE NOTICE '%', CAST(i_guid AS TEXT);
END; $$
*/
DROP PROCEDURE IF EXISTS sp_user_registration;
CREATE OR REPLACE PROCEDURE sp_user_registration(i_email varchar, i_password_hash varchar, i_first_name varchar, i_last_name varchar, i_default_tenant varchar, inout o_verification_guid uuid)
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
INSERT INTO user_(email, password_hash, first_name, last_name, default_tenant) VALUES(i_email, i_password_hash, i_first_name, i_last_name, i_default_tenant) RETURNING verification_guid into  o_verification_guid;

--
END;
$$;
