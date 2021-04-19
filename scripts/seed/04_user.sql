-- Create guest login user with password guest
INSERT INTO user_(email, password_hash, verified, verification_guid) VALUES('guest@inventart.com', '$2a$11$Zm2y6Ew2zWp9TmjsSZI10.u5Kf7nVEKnFyuSALUOGf/AMiJtnPWGS', true, null);
