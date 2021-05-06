-- Create guest login user with password guest
INSERT INTO user_(email, password_hash, first_name, last_name, default_tenant, verified, verification_guid, is_guest_user) VALUES('guest@inventart', '$2a$11$Zm2y6Ew2zWp9TmjsSZI10.u5Kf7nVEKnFyuSALUOGf/AMiJtnPWGS', 'guestFN', 'guestLN', null, true, null, true);
