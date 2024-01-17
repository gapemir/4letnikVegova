.\isql.exe -user sysdba -password masterkey
CONNECT "C:\Users\Vegova\Downloads\PRODAJAVOZIL.FDB";
SHOW TABLES;
SHOW TABLE KUPEC;
SHOW TABLE PRODAJALEC;
SHOW TABLE PRODAJA;
SHOW TABLE VOZILO;
CREATE TABLE Proizvajalec(
    Znamka varchar(25) not null,
    Poreklo varchar(15) not null,
    PRIMARY KEY(Znamka),
    FOREIGN KEY(Poreklo) CONSTRAINT Drzava(DrzavaID)
);
CREATE TABLE Proizvajalec(
    Znamka int not null auto_increment,
    Poreklo varchar(15) not null,
    PRIMARY KEY(Znamka),
    FOREIGN KEY(Poreklo) CONSTRAINT Drzava(DrzavaID)
)
auto_increment=1000
ENGINE=InnoDB;
/*firebird*/
CREATE DOMAIN domenaDrzava varchar(15)
CHECK(VALUE IN ('Nemcija','Italija','Anglija','Japonska'));
/*mysql*/
setDrzava CHECK(VALUE IN ('Nemcija','Italija','Anglija','Japonska'));
/*firebird*/
ALTER TABLE Vozilo ALTER COLUMN OsnovnaCena
TYPE double
POSITION 2;
/*mysql*/
ALTER TABLE Vozilo MODIFY COLUMN OsnovnaCena
double AFTER xxx;
/*firebird*/
UPDATE Vozilo 
SET OsnovnaCena=OsnovnaCena*0.65
WHERE letnik < (EXTRACT(YEAR FROM CURRENT_DATE)-10);
/*mysql*/
UPDATE Vozilo 
SET OsnovnaCena=OsnovnaCena*0.65
WHERE letnik < (EXTRACT(YEAR FROM CURRENT_DATE())-10);
/**/
DELETE FROM Prodajalec
WHERE UPPER(SUBSTRING(priimekprodajalca FROM 1 FOR 3))='LEN';
ALTER TABLE Prodajalec DROP ImeProdajalca;
/**/
INSERT INTO Vozilo
VALUES(10,'Mazda','3x186',28500,2020,'Ni na zalogi');
ni uspela, ker je status domena in nima presetanga 'Ni na zalogi'.
/*2*/
SELECT Znamka,COUNT(znamka)
FROM Vozilo JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID
GROUP BY Znamka
ORDER BY COUNT(znamka);
/**/
CREATE VIEW prodajaPoProdajalcu AS
SELECT SUBSTRING(PRIIMEKPRODAJALCA FROM 1 FOR 1) ||'.'||SUBSTRING(PRIIMEKPRODAJALCA FROM 1 FOR 1) ||
'. je Prodal ' || COUNT(prodaja.prodajalecID) ||'vozil.' AS prodaja
FROM Prodaja JOIN Prodajalec ON Prodajalec.prodajalecID=Prodaja.ProdajalecID
WHERE DatumProdaje BETWEEN '2012-03-01' AND '2012-06-30'
GROUP BY PRIIMEKPRODAJALCA
ORDER BY COUNT(prodaja.prodajalecID) ASC;
/**/
CREATE VIEW imePriStrank AS 
SELECT IMEKUPCA,PriimekKupca,SUM(osnovnaCena*(1-procPopusta)+ prodProvizija) AS ja
FROM Kupec JOIN prodaja ON prodaja.davst=Kupec.davst
JOIN vozilo ON vozilo.VoziloID=prodaja.VoziloID
JOIN prodajalec ON prodajalec.prodajalecID=prodaja.prodajalecID
WHERE UPPER(KrajKupca)='LJUBLJANA'
GROUP BY IMEKUPCA,PriimekKupca;

ALTER VIEW imePriStrank AS
SELECT IMEKUPCA,PriimekKupca,SUM(osnovnaCena*(1-procPopusta)+ prodProvizija)*0.9 AS ja
FROM Kupec JOIN prodaja ON prodaja.davst=Kupec.davst
JOIN vozilo ON vozilo.VoziloID=prodaja.VoziloID
JOIN prodajalec ON prodajalec.prodajalecID=prodaja.prodajalecID
WHERE UPPER(KrajKupca)='LJUBLJANA'
GROUP BY IMEKUPCA,PriimekKupca;
/**/
SELECT znamka, AVG(osnovnaCena*(1-procPopusta)+prodProvizija)
FROM Prodaja 
JOIN vozilo ON vozilo.VoziloID=prodaja.VoziloID
JOIN prodajalec ON prodajalec.prodajalecID=prodaja.prodajalecID
WHERE UPPER(znamka) LIKE '%B%'
GROUP BY znamka;
/**/
CREATE VIEW haha AS 
SELECT imeKupca
FROM Kupec LEFT JOIN prodaja ON prodaja.davst=Kupec.davst
LEFT JOIN vozilo ON vozilo.voziloID=prodaja.voziloID AND UPPER(znamka)='BENTLY'
GROUP BY imeKupca;
HAVING(COUNT(imeKupca)<1);