 /*1*/
 CREATE DATABASE 'C:\tempp\GlasbenaZbirka.fdb' user 'sysdba' password 'masterkey' default character set ISO8859_2;
 CONNECT 'C:\tempp\GlasbenaZbirka.fdb';
 /*2*/
 CREATE DOMAIN Zvrst varchar(10) CHECK(VALUE IN('pop','rok','klasika','jazz'));
 /*3*/
CREATE TABLE Avtor(
AvtorID INT,
Ime varchar(20) not null,
Priimek varchar(20) not null,
primary key(AvtorID));
CREATE TABLE Posnetek(
PID INT,
Naslov varchar(30) not null,
Genre Zvrst not null,
Trajanje TIME not null,
AvtorID INT not null,
PRIMARY KEY(PID),
FOREIGN KEY(AvtorID) REFERENCES Avtor(AvtorID)
);
CREATE TABLE Lastnik(
LID int,
Ime varchar(20) not null,
priimek varchar(20) not null,
Tel varchar(20) not null,
eMail varchar(30) not null CHECK(eMail LIKE '%@%'),
PRIMARY KEY(LID)
);
CREATE TABLE CD(
CDID int,
Naslov varchar(30) not null,
Cena numeric(10,2) not null,
Opombe varchar(150),
lastnik int not null,
PRIMARY KEY(CDID),
FOREIGN KEY(lastnik) REFERENCES Lastnik(LID)
);
CREATE TABLE Vsebina(
CDID INT,
PID int,
PRIMARY KEY(CDID,PID),
FOREIGN KEY(CDID) REFERENCES CD(CDID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(PID) REFERENCES Posnetek(PID) ON DELETE CASCADE ON UPDATE CASCADE
);
/*4*/
SHOW TABLES;
/*5*/
SHOW DOMAINS;
/*6*/
SHOW DOMAIN Zvrst;
/*7*/
SHOW TABLE Avtor;
SHOW TABLE Posnetek;
SHOW TABLE CD;
SHOW TABLE Vsebina;
SHOW TABLE Lastnik;
/*8*/
ALTER TABLE CD ADD leto INT CHECK(leto >1981);
/*9/*/
ALTER TABLE CD DROP CONSTRAINT INTEG_42;
ALTER TABLE CD ADD CONSTRAINT omej1 FOREIGN KEY(lastnik) REFERENCES Lastnik(LID) ON DELETE CASCADE ON UPDATE CASCADE;
/*10*/
SHOW TABLE CD;
/*11*/
SELECT * FROM Avtor;
/*12*/
ALTER TABLE Avtor ALTER COLUMN ime POSITION 3;
ALTER TABLE Avtor ALTER COLUMN priimek POSITION 2;
ALTER TABLE Lastnik ALTER COLUMN ime POSITION 3;
ALTER TABLE Lastnik ALTER COLUMN priimek POSITION 2;
/*13*/
INSERT INTO Avtor
VALUES(10,'Orff','Carl');
INSERT INTO Avtor
VALUES(20,'Gounod','Charles');
INSERT INTO Avtor
VALUES(30,'Adams','Brian');
INSERT INTO Avtor
VALUES(40,'Leonard','Cohen');
INSERT INTO Avtor
VALUES(50,'Gaetano','Donizetti');
/*14*/
ALTER TABLE Avtor ADD letoRojstva int CHECK(letoRojstva < EXTRACT(YEAR FROM CURRENT_DATE));
/*15*/
UPDATE Avtor SET letoRojstva=1895 WHERE priimek='Orff';
UPDATE Avtor SET letoRojstva=1818 WHERE priimek='Gounod';
UPDATE Avtor SET letoRojstva=1959 WHERE priimek='Adams';
UPDATE Avtor SET letoRojstva=1934 WHERE ime='Cohen';
UPDATE Avtor SET letoRojstva=1797 WHERE ime='Donizetti';
/*16*/
SELECT * FROM Avtor;
/*17*/
exit;
/*18*/
.\isql.exe -user sysdba -password masterkey
CONNECT 'C:\tempp\GlasbenaZbirka.fdb';
/*19*/
CREATE TABLE Drzava(
DID int not null,
ImeDrzave varchar(20)not null
);
/*20*/
ALTER TABLE Drzava ADD CONSTRAINT PK_drzava PRIMARY KEY(DID);
/*21*/
ALTER TABLE Drzava ADD CONSTRAINT ime_drzava UNIQUE(ImeDrzave);
/*22*/
INSERT INTO Drzava
VALUES(1,'Canada');
INSERT INTO Drzava
VALUES(2,'Italia');
INSERT INTO Drzava
VALUES(3,'Deutschland');
INSERT INTO Drzava
VALUES(4,'France');
INSERT INTO Drzava
VALUES(5,'Slovenija');
/*23*/
ALTER TABLE Avtor ADD DID int default 5 not null;
exit;
.\isql.exe -user sysdba -password masterkey
CONNECT 'C:\tempp\GlasbenaZbirka.fdb';
ALTER TABLE Avtor ADD CONSTRAINT FK_Avt1 FOREIGN KEY(DID) REFERENCES Drzava(DID) ON DELETE SET default ON UPDATE SET DEFAULT;



