-- CALL sp_user_registration('3x9equals27@gmail.com', '123456');
DROP PROCEDURE IF EXISTS sp_user_registration;
CREATE OR REPLACE PROCEDURE sp_user_registration(p_email varchar, p_password varchar)
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
INSERT INTO user_(email, password) VALUES(p_email, p_password);

--
END;
$$;
