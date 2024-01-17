/*1*/
.\isql.exe -user sysdba -password masterkey
/*2*/
CONNECT "C:\Users\Vegova\Downloads\GLASBENAZBIRKA.FDB";
/*3*/
SHOW TABLES;
SHOW TABLE Avtor;
SHOW TABLE CD;
SHOW TABLE Posnetek;
SHOW TABLE Vsebina;
/*4*/
ALTER TABLE CD ADD Leto int;
/*5*/
SHOW TABLE CD;
/*6*/
ALTER TABLE Avtor ALTER ime POSITION 3; 
/*tabela lastnik ne obstaja hahahahahah*/
/*7*/
ALTER TABLE Avtor ADD Opus varchar(100);
/*je uspelo*/
/*8*/
DELETE FROM Avtor;
INSERT INTO Avtor VALUES(10, 'Orff', 'Carl', 'opera,kantata,drugo');
INSERT INTO Avtor VALUES(20, 'Gounod', 'Charles', 'opera,simfonija,drugo');
INSERT INTO Avtor VALUES(30, 'Adams', 'Brian', 'balada,drugo');
INSERT INTO Avtor VALUES(40, 'Cohen', 'Leonard', 'balada,drugo');
INSERT INTO Avtor VALUES(50, 'Donizetti', 'Gaetano', 'opera');
/*9*/
ALTER TABLE Avtor ADD DatumRojstva date;
/*10*/
UPDATE Avtor SET DatumRojstva=1895 WHERE priimek = 'Orff';
UPDATE Avtor SET DatumRojstva=1818 WHERE priimek = 'Gounod';
UPDATE Avtor SET DatumRojstva=1959 WHERE priimek = 'Adams';
UPDATE Avtor SET DatumRojstva=1934 WHERE priimek = 'Cohen';
UPDATE Avtor SET DatumRojstva=1797 WHERE priimek = 'Donizetti';
ALTER TABLE Avtor ALTER COLUMN DatumRojstva TYPE int;
/*pise da je convertion iz date v int unsuported*/
/*11*/
SELECT * FROM Avtor;
/*12*/
ctrl^C
/*13*/
.\isql.exe -user sysdba -password masterkey
CONNECT "C:\Users\Vegova\Downloads\GLASBENAZBIRKA.FDB";
/*14*/
CREATE TABLE Drzava(
    DID int, 
    ImeDrzave varchar(20) default 100
);
/*je uspelo*/
/*15*/
CREATE TABLE Drzava(
    DID int, 
    ImeDrzave varchar(20) default 100,
    PRIMARY KEY (DID)
);
/*16*/
INSERT INTO Drzava VALUES(100,'Canada');
INSERT INTO Drzava VALUES(200,'Italia');
INSERT INTO Drzava VALUES(300,'Deutschland');
INSERT INTO Drzava VALUES(400,'France');
INSERT INTO Drzava VALUES(500,'Slovenija');
/*17*/
ALTER TABLE Avtor ADD DID int default 500;
commit;
ALTER TABLE Avtor ADD CONSTRAINT FK_Avtor_Drzava FOREIGN KEY(DID) REFERENCES Drzava(DID);
/*18*/
UPDATE Avtor SET DID=300 WHERE priimek='Orff';
UPDATE Avtor SET DID=400 WHERE priimek='Gounod';
UPDATE Avtor SET DID=100 WHERE priimek='Adams';
UPDATE Avtor SET DID=100 WHERE priimek='Cohen';
UPDATE Avtor SET DID=200 WHERE priimek='Donizetti';
/*19*/
UPDATE Avtor SET ime=null, priimek=null WHERE Opus='opera,kantata';
/*ni uspelo*/
/*20*/
DELETE FROM Drzava WHERE DID = 300;
/*ni uspelo, ker je kot foreign key v drugi tabeli*/