CREATE DATABASE lokal;
USE lokal;
CREATE TABLE si(
    geslo varchar(50) PRIMARY KEY,
    vrednost varchar(50)
);
CREATE TABLE it(
    geslo varchar(50) PRIMARY KEY,
    vrednost varchar(50)
);
CREATE TABLE hu(
    geslo varchar(50) PRIMARY KEY,
    vrednost varchar(50)
);

INSERT INTO si VALUES('jezik','slovenščina');
INSERT INTO si VALUES('jezikKoda','sl_si');
INSERT INTO it VALUES('jezik','italijanščina');
INSERT INTO it VALUES('jezikKoda','it_it');
INSERT INTO hu VALUES('jezik','madžarščina');
INSERT INTO hu VALUES('jezikKoda','hu_hu');

INSERT INTO si VALUES('ime','ime');
INSERT INTO si VALUES('priimek','priimek');
INSERT INTO si VALUES('spol','spol');
INSERT INTO si VALUES('tel','telefon');
INSERT INTO si VALUES('email','email');
INSERT INTO si VALUES('kraj','kraj');
INSERT INTO si VALUES('submit','potrdi');
INSERT INTO it VALUES('ime','nome');
INSERT INTO it VALUES('priimek','cognome');
INSERT INTO it VALUES('spol','genere');
INSERT INTO it VALUES('tel','telefono');
INSERT INTO it VALUES('email','e-mail');
INSERT INTO it VALUES('kraj','posto');
INSERT INTO it VALUES('submit','invia');
INSERT INTO hu VALUES('ime','név');
INSERT INTO hu VALUES('priimek','vezetéknév');
INSERT INTO hu VALUES('spol','neme');
INSERT INTO hu VALUES('tel','telefon');
INSERT INTO hu VALUES('email','email');
INSERT INTO hu VALUES('kraj','hely');
INSERT INTO hu VALUES('submit','Beküldés');


