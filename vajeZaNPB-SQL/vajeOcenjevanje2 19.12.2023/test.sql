/*firebird*/
.\isql.exe -u sysdba -p masterkey
CONNECT "C:\Users\Vegova\Downloads\PRODAJAVOZIL2.FDB";

/*1*/
CREATE DOMAIN domenastarost int
CHECK (VALUE BETWEEN 2010 AND 2023);

ALTER TABLE vozilo
ALTER COLUMN letnik
TYPE domenastarost;

/*2*/
ALTER TABLE vozilo
ALTER COLUMN OsnovnaCena TYPE double precision,
ALTER COLUMN OsnovnaCena POSITION 6,
ALTER COLUMN OsnovnaCena TO cena;

/*3*/
UPDATE vozilo 
SET Cena=(Cena*1.22), znamka=UPPER(znamka)
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - 5 < letnik;

/*4*/
CREATE VIEW najboljsiKupec AS
SELECT FIRST 1 (SUBSTRING(imeKupca FROM 1 FOR 1)||'. ' || priimekKupca || ' je najboljsi kupec!') AS izpis 
FROM Kupec
JOIN Prodaja ON Prodaja.DavSt=Kupec.DavSt
GROUP BY ImeKupca, PriimekKupca
ORDER BY COUNT(voziloID) DESC;


/*mysql*/
.\mysql.exe -u root
CTRL^C/*prilepimo mysql_dump file*/

/*5*/
CREATE TABLE LogPosnetki(
    LogID int not null auto_increment,
    PID int not null,
    Uporabnik varchar(30) not null,
    VrstaAkcije varchar(20) not null,
    DatumAkcije timestamp not null,
    OpisTransakcije varchar(256),
    FOREIGN KEY(PID) REFERENCES posnetek(PID),
    PRIMARY KEY(LogID, PID)
)
ENGINE=MyISAM
auto_increment = 10
character set utf8;

/*6*/
ALTER TABLE CD
MODIFY COLUMN Opombe ENUM('resna glasba','zabavna glasba','klasična glasba');
/*operacija je uspela*/
/*mogl bi updatat vse zapise na te 3 moznosti, to bi storili z SQL DML stavkom UPDATE*/ 
/*primer:*/
UPDATE CD 
SET opombe='resna glasba'
WHERE lower(opombe)='resna glasba';
UPDATE CD 
SET opombe='zabavna glasba'
WHERE lower(opombe)='zabavna glasba';
UPDATE CD 
SET opombe='klasična glasba'
WHERE lower(opombe)='klasična glasba';

/*7*/
SELECT CONCAT('Avtor ', Ime, ' ', Priimek, 'je izdal ', COUNT(PID), ' posnetkov.') AS steviloAvtorjevihPosnetkov
FROM Avtor
LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
GROUP BY Ime, Priimek;

/*8*/
CREATE VIEW povpCenaZgoscenk AS
SELECT AVG(cena) AS povpCena FROM CD
JOIN Vsebina ON Vsebina.CDID=CD.CDID
JOIN Posnetek ON Posnetek.PID=Vsebina.PID
JOIN Avtor ON Avtor.AvtorID=Posnetek.AvtorID
WHERE EXTRACT(YEAR FROM rojen) BETWEEN 1901 AND 2000;
/*ne, ker uporabljamo agregatno funkcijo in je algoritem merge ne zna uporabljati,
tudi če zahtevamo algorithem merge, ga ne bo uporabil*/
DELETE FROM povpCenaZgoscenk
WHERE CDID=5;
/*ne moremo izbrisati zgoščenke, saj kej v pogledu joinamo tabele se tega ne da izvesti*/
/*ce pa naredimo nov pogled v katerem so samo zgoščenke, je to možno*/
CREATE VIEW testtest AS
SELECT * FROM CD;

DELETE FROM testtest
WHERE CDID=5;
/*tako se to izvede*/
