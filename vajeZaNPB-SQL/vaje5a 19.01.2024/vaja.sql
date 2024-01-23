.\isql.exe -u sysadmin -p masterkey
CONNECT "C:\Users\Gasper Nemgar\Downloads\PRODAJAVOZIL2 (1).FDB";
/*a*/
INSERT INTO Prodaja2012 
SELECT znamka, model, ImeKupca, PriimekKupca, ImeProdajalca, PriimekProdajalca, DatumProdaje FROM Vozilo
JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID
JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
JOIN Prodajalec ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
WHERE EXTRACT(YEAR FROM DatumProdaje)=2012;


/*b*/
DELETE FROM Vozilo
WHERE VoziloID = (
    SELECT Vozilo.VoziloID FROM Vozilo
    JOIN Prodaja ON Vozilo.VoziloID=Prodaja.VoziloID
    JOIN Prodajalec ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
    WHERE znamka IN('Ford','Fiat') AND UPPER(PriimekProdajalca) LIKE 'LEN%'
    );
/*c*/
UPDATE Vozilo
SET OsnovnaCena = OsnovnaCena - 5 * (EXTRACT(YEAR FROM CURRENT_DATE) - Letnik);
/*d*/
UPDATE Vozilo
SET status = NULL
WHERE VoziloID IN (
    SELECT Vozilo.VoziloID FROM Vozilo 
    JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID
    );
ne, ne dela, error je "Operation violates CHECK constraint STATUS_NN on view or table VOZILO -At trigger 'CHECK_2'"
/*e*/
UPDATE Prodaja
SET ProcPopusta = ProcPopusta - 0.01
WHERE VoziloID = (
    SELECT Vozilo.VoziloID FROM Vozilo
    JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID
    JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
    WHERE znamka = 'Fiat' AND ImeKupca = 'Jure' AND PriimekKupca = 'Kos'
    );
/*f*/
INSERT INTO Porocilo2010
SELECT SUBSTRING(ImeProdajalca FROM 1 FOR 1) || SUBSTRING(PriimekProdajalca FROM 1 FOR 1) as inicialki, SUM(OsnovnaCena) AS Skupna_Vrednost, SUM(OsnovnaCena * 100 - ProcPopusta + ProdProvizija) AS Skupen_Izkupicek FROM Prodaja
JOIN Prodajalec ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
JOIN Vozilo ON Vozilo.VoziloID=Prodaja.VoziloID
GROUP BY ImeProdajalca, PriimekProdajalca;

/*g*/
DELETE FROM Prodaja
WHERE VoziloID IN (
    SELECT VoziloID FROM Vozilo 
    WHERE znamka='Fiat' AND Letnik=2010
    );
/*h*/
UPDATE Prodaja
SET ProcPopusta = ProcPopusta - 0.02
WHERE VoziloID IN (
    SELECT Vozilo.VoziloID FROM Vozilo 
    JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID
    JOIN Prodajalec ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
    WHERE znamka = 'Fiat' AND ImeProdajalca = 'Marjeta' AND PriimekProdajalca = 'Pretnar'
);
/*i*/
SELECT PriimekProdajalca, ImeProdajalca FROM Prodajalec
WHERE ProdajalecID IN (
    SELECT ProdajalecID FROM Prodaja
    JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
    WHERE KrajKupca = 'Ljubljana'
) AND ProdajalecID IN (
    SELECT ProdajalecID FROM Prodaja
    JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
    WHERE KrajKupca = 'Maribor'
);
/*j*/
DELETE FROM PRODAJALEC
WHERE ProdajalecID NOT IN(
    SELECT Prodaja.ProdajalecID FROM Prodajalec
    JOIN Prodaja ON  Prodaja.ProdajalecID=Prodajalec.ProdajalecID
);

