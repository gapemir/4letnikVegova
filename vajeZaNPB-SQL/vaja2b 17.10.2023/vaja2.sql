/*1*/
CREATE DATABASE GlasbenaZbirka_innoDB CHARACTER SET utf8;
USE GlasbenaZbirka_innoDB;
/*2*/
CREATE TABLE Avtor(
    AvtorID int not null,
    Ime varchar(20) not null,
    Priimek varchar(20) not null,
    opus SET("opera","kantata","simfonija","koncert","balada","drugo"),
    PRIMARY KEY(AvtorId)
);
CREATE TABLE Posnetek(
    PID int not null,
    Naslov varchar(30) not null,
    Genre ENUM("klasika","pop","jazz") not null,
    trajanje TIME,
    AvtorID int not null,
    PRIMARY KEY(PID),
    FOREIGN KEY(AvtorID) REFERENCES Avtor(AvtorID)
);
CREATE TABLE CD(
    CDID int not null,
    Naslov varchar(30) not null,
    Cena decimal(5,2) not null,
    opomba varchar(150),
    lastnik int not null,
    PRIMARY KEY(CDID)
);
CREATE TABLE Vsebina(
    CDID int not null,
    PID int not null,
    PRIMARY KEY(CDID,PID),
    FOREIGN KEY(CDID) REFERENCES CD(CDID),
    FOREIGN KEY(PID) REFERENCES Posnetek(PID)
);
CREATE TABLE lastnik(
    LID int not null,
    Ime varchar(20) not null,
    Priimek varchar(20) not null,
    tel varchar(20) not null,
    eMail varchar(30) not null,
    PRIMARY KEY(LID)
);
/*je uspelo*/
/*3*/
show create table Avtor;
show create table Posnetek;
show create table CD;
show create table Vsebina;
show create table lastnik;
/*4*/
alter table CD add constraint fk_lastnik FOREIGN KEY(lastnik) REFERENCES lastnik(LID);
/*5*/
alter table CD add COLUMN Leto year;
/*6*/
show create table CD;
/*7*/
CREATE TABLE Owner(
    LID int not null,
    Ime varchar(20) not null,
    Priimek varchar(20) not null,
    tel varchar(20) not null,
    eMail varchar(30) not null,
    PRIMARY KEY(LID)
);
/*8*/
ALTER TABLE Avtor MODIFY ime varchar(20) AFTER priimek;
ALTER TABLE Lastnik MODIFY ime varchar(20) AFTER priimek;
/*9*/
INSERT INTO Avtor 
VALUES (10, "Orff", "Carl", "opera,kantata,drugo");
INSERT INTO Avtor 
VALUES (20, "Gounod", "Charles", "opera,simfonija,drugo");
INSERT INTO Avtor 
VALUES (30, "Adams", "Brian", "balada,drugo");
INSERT INTO Avtor 
VALUES (40, "Cohen","Leonard", "balada,drugo");
INSERT INTO Avtor 
VALUES (50, "Donizetti", "Gaetano", "opera");
/*10*/
ALTER TABLE Avtor ADD COLUMN letoRojstva year;
/*11*/
UPDATE Avtor SET letoRojstva =1895 WHERE priimek="Orff";
UPDATE Avtor SET letoRojstva =1919 WHERE priimek="Gounod";
UPDATE Avtor SET letoRojstva =1959 WHERE priimek="Adams";
UPDATE Avtor SET letoRojstva =1934 WHERE priimek="Cohen";
UPDATE Avtor SET letoRojstva =1797 WHERE priimek="Donizetti";
Alter TABLE Avtor MODIFY COLUMN letoRojstva int;
UPDATE Avtor SET letoRojstva =1895 WHERE priimek="Orff";
UPDATE Avtor SET letoRojstva =1919 WHERE priimek="Gounod";
UPDATE Avtor SET letoRojstva =1959 WHERE priimek="Adams";
UPDATE Avtor SET letoRojstva =1934 WHERE priimek="Cohen";
UPDATE Avtor SET letoRojstva =1797 WHERE priimek="Donizetti";
/*12*/
SELECT * FROM Avtor;
/*13*/
ctrl^C
/*14*/
/*15*/
CREATE TABLE Drzava(
    DID int AUTO_INCREMENT,
    ImeDrzave varchar(20)
)
AUTO_INCREMENT = 100;
/*ni uspelo, ker nima primarnega kljuca*/
/*16*/
CREATE TABLE Drzava(
    DID int AUTO_INCREMENT,
    ImeDrzave varchar(20),
    PRIMARY KEY(DID)
)
AUTO_INCREMENT = 100;
/*17*/
INSERT INTO Drzava VALUES(100,"Canada");
INSERT INTO Drzava VALUES(200,"Italia");
INSERT INTO Drzava VALUES(300,"Deutschland");
INSERT INTO Drzava VALUES(400,"France");
INSERT INTO Drzava VALUES(500,"Slovenija");
/*18*/
insert into drzava (imeDrzave) values ('Austria');
/*501*/
/*19*/
ALTER TABLE Avtor ADD COLUMN DID int default 500;
ALTER TABLE Avtor ADD constraint fk_avtor_drzava FOREIGN KEY(DID) REFERENCES Drzava(DID);
/*20*/
UPDATE Avtor SET DID = 300 WHERE priimek="Orff";
UPDATE Avtor SET DID = 400 WHERE priimek="Gounod ";
UPDATE Avtor SET DID = 100 WHERE priimek="Adams ";
UPDATE Avtor SET DID = 100 WHERE priimek="Cohen ";
UPDATE Avtor SET DID = 200 WHERE priimek="Donizetti ";
/*21*/
SELECT priimek, ime FROM Avtor WHERE opus = "opera,kantata";
/*22*/
DELETE FROM Drzava WHERE DID = 300;
/*ni uspelo, ker je to foreign key v drugi tabeli*/
/*23*/
SELECT ime, priimek, imeDrzave FROM Avtor JOIN Drzava ON Avtor.DID = Drzava.DID;
/*24*/
/*ctrl^C
.\mysqldump.exe DemoPB > GlasbenaZbirka_innoDB.sql --user=root*/






