.\isql.exe -user sysdba -password masterkey
CONNECT "C:\Users\Vegova\Downloads\PRODAJAVOZIL.FDB";
/*a*/
SELECT ImeProdajalca, PriimekProdajalca 
FROM Prodajalec JOIN Prodaja ON Prodaja.ProdajalecID=Prodajalec.ProdajalecID 
GROUP BY ImeProdajalca, PriimekProdajalca 
HAVING AVG(ProcPopusta)>0.07 
ORDER BY AVG(ProcPopusta) DESC;
/*b*/
SELECT ('Prodajalec ' || SUBSTRING(PriimekProdajalca FROM 1 FOR 1) || '. ' || ImeProdajalca || ' se ni prodal nobenega vozila!') AS Sporocilo
FROM Prodajalec FULL JOIN Prodaja ON Prodaja.ProdajalecID=Prodajalec.ProdajalecID 
GROUP BY ImeProdajalca, PriimekProdajalca
HAVING AVG(ProcPopusta) IS NULL;
/*c*/
SELECT FIRST 1 
EXTRACT(MONTH FROM DatumProdaje) FROM Prodaja
GROUP BY EXTRACT(MONTH FROM DatumProdaje)
ORDER BY EXTRACT(MONTH FROM DatumProdaje) DESC;
/*d*/
SELECT DISTINCT znamka FROM Vozilo 
JOIN Prodaja ON Vozilo.VoziloID=Prodaja.VoziloID JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
WHERE UPPER(KrajKupca) IN ('LJUBLJANA','MARIBOR');
/*e*/
select SUM(OsnovnaCena*(1-ProcPopusta)) FROM Vozilo 
JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
where UPPER(KrajKupca) = 'LJUBLJANA';
/*f*/
UPDATE Prodajalec
SET PriimekProdajalca = (UPPER(SUBSTRING(PriimekProdajalca FROM 1 FOR 3))||SUBSTRING(PriimekProdajalca FROM 4)) 
WHERE UPPER(PriimekProdajalca) LIKE '%LEN%';
/*g*/
UPDATE Vozilo
SET OsnovnaCena = OsnovnaCena * 0.75
WHERE letnik = 2010;
/*h*/
SELECT COUNT(*) FROM Vozilo 
WHERE Status = 'na zalogi';
/*i*/
DELETE FROM Prodajalec 
WHERE UPPER(PriimekProdajalca) Like('P%');
/*ni uspelo, ker je pordajalec uporabljen kot foreign key*/
/*j*/
UPDATE Vozilo
SET OsnovnaCena = OsnovnaCena - 350
WHERE Status = 'dobava 1 mesec';
/*k*/
INSERT INTO Kupec
VALUES (123456789,'Gašper','Nemgar','Unec 161','Rakek');
/*l*/
INSERT INTO Prodaja 
VALUES(5,123456789,'2023-11-07',4,0.4,0);
/*nakup ni uspel, ker check ne pusti*/
/*m*/
SELECT ImeKupca, PriimekKupca
FROM Prodaja JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
GROUP BY ImeKupca, PriimekKupca
HAVING COUNT(*) = (
    SELECT MAX(SteviloVozil)
    FROM (
        SELECT COUNT(*) AS SteviloVozil
        FROM Prodaja
        GROUP BY DavST
    )
);
/*n*/
SELECT znamka, model, PriimekKupca, ImeKupca, DatumProdaje, (OsnovnaCena*(1-ProcPopusta)*1+prodProvizija)
FROM prodaja JOIN vozilo ON vozilo.voziloID=prodaja.voziloID JOIN kupec ON kupec.DavSt=prodaja.DavSt
WHERE DatumProdaje >= DATEADD(month,-24,CURRENT_DATE);
/*o*/
SELECT znamka, model, PriimekKupca, ImeKupca, DatumProdaje, (OsnovnaCena*(1-ProcPopusta)*1+prodProvizija)
FROM prodaja JOIN vozilo ON vozilo.voziloID=prodaja.voziloID JOIN kupec ON kupec.DavSt=prodaja.DavSt
WHERE DatumProdaje >= DATEADD(day,-60,CURRENT_DATE);




