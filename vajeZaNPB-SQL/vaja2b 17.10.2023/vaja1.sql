/*1*/
 CREATE DATABASE DemoPB CHARACTER SET utf8;
 USE DemoPB;
/*2*/
CREATE TABLE Predmet(
    PID int not null AUTO_INCREMENT,
    Kratica varchar(3) not null,
    ImePredmeta varchar(20) not null,
    kreditneTocke int,
    Opis varchar(200),
    PRIMARY KEY(PID)
)
AUTO_INCREMENT=100;
/*3*/
/*-||-*/
/*4*/
/*InnoDB*/
/*5*/
INSERT INTO Predmet(Kratica,ImePredmeta,kreditneTocke,Opis) VALUES("MAT","Matematika",5,"Matematika za strokovne šole");
INSERT INTO Predmet(Kratica,ImePredmeta,kreditneTocke,Opis) VALUES("NPB","Podatkovne baze",5,"napredne podatkovne baze");
INSERT INTO Predmet(Kratica,ImePredmeta,kreditneTocke,Opis) VALUES("FTE","Fizika za tehnike",5,"fizika za tehnike");
INSERT INTO Predmet(Kratica,ImePredmeta,kreditneTocke,Opis) VALUES("NSA","Spletne aplikacije",5,"spletne aplikacije");
INSERT INTO Predmet(Kratica,ImePredmeta,kreditneTocke,Opis) VALUES("RAO","rac oblikovanje",5,"racunalnisko oblikovanje");
/*6*/
ALTER TABLE Predmet add stUrNaTeden SET("2","3","4","5","6");
/*7*/
describe predmet;
/*8*/
UPDATE Predmet 
SET stUrNaTeden="4"
WHERE Kratica = "MAT";
UPDATE Predmet 
SET stUrNaTeden="4"
WHERE Kratica = "NPB";
UPDATE Predmet 
SET stUrNaTeden="3"
WHERE Kratica = "FTE";
UPDATE Predmet 
SET stUrNaTeden="5"
WHERE Kratica = "NSA";
UPDATE Predmet 
SET stUrNaTeden="4"
WHERE Kratica = "RAO";
/*9*/
ALTER TABLE Predmet ADD opomba varchar(100);
/*10*/
SELECT * FROM Predmet;
/*11*/
UPDATE Predmet
SET opomba="zahtevna, uporabna"
WHERE Kratica="MAT";
UPDATE Predmet
SET opomba="zanimiva, uporabna"
WHERE Kratica="NPB";
UPDATE Predmet
SET opomba="zanimiva"
WHERE Kratica="FTE";
/*12*/
SELECT ImePredmeta FROM Predmet WHERE LOCATE(",",opomba);
/*13*/
SELECT ImePredmeta FROM Predmet WHERE !LOCATE("uporabna",opomba) OR opomba IS NULL;
/*14*/
SELECT ImePredmeta FROM Predmet WHERE stUrNaTeden="4";
/*15*/
ctrl^C
.\mysqldump.exe DemoPB > hahah.sql --user=root
