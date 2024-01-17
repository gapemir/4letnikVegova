-- ZACETEK:
FB:
isql.exe -user sysdba -password masterkey

MySQL:
mysql.exe --user=root




-- SQL POSEBNOSTI
FB:
CREATE DOMAIN ime_domene tip_domene [DEFAULT ___] [NOT NULL] [CHECK ___];

-- obstaja:
CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP

-- UDF:
IN 'C:\...\firebird_mapca\...udf\ib_udf2.sql';

STRLEN(___);
TRIM(___); -- v obeh supb-jih
ROUND(n[, m]); -- zaokrozi n [na m dec. mest], also OBA


MySQL:
CREATE DATABASE DemoPB CHARACTER SET utf8;
CREATE TABLE Drzava (
    DID INT auto_increment,
    ImeDrzave VARCHAR(20),
    PRIMARY KEY (DID)
)
engine=[InnoDB,MyISAM,MEMORY]
auto_increment=100 -- MORA BITI PK!!!
character set _____; --(recimo utf8mb4)

DESCRIBE Drzava;
SHOW CREATE TABLE Drzava;


CONNECT ZbirkaCD;

ALTER TABLE Obcan ADD CONSTRAINT Obcan_KrajID_FK FOREIGN KEY (KrajID) REFERENCES Kraj(KrajID) ON UPDATE cascade ON DELETE SET NULL;
ALTER TABLE Obcan MODIFY Priimek VARCHAR(20) AFTER EMSO;
ALTER TABLE Obcan ADD Splon ENUM('M', 'Z') NOT NULL;

ALTER TABLE avtor
ADD opus SET('opera','kantata','simfonija','koncert','balada','drugo')
NOT NULL DEFAULT 'drugo';

CREATE VIEW fra AS
SELECT *
FROM avtor
WHERE drzava = 'FRA';
SHOW CREATE VIEW fra;

CREATE VIEW slo_fra AS
SELECT * FROM slo
UNION
SELECT * FROM fra;

LENGTH();


EXTRACT(YEAR/... FROM datum);
SUBSTRING(str FROM poz FOR st); -- poz se zacne z 1
CAST(spr AS tip); -- v nizje gre vedno, obratno pa odvisno