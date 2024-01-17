.\isql.exe -user sysdba -password masterkey
CONNECT "C:\Users\Vegova\Downloads\PRODAJAVOZIL.FDB";
/*a*/
SELECT model FROM VOZILO 
WHERE znamka='BMW' AND osnovnacena<50000;
/*b*/
SELECT Prodajalec.prodajalecID, ImeProdajalca AS Ime, PriimekProdajalca AS Priimek, COUNT(CASE WHEN EXTRACT(YEAR FROM DatumProdaje)=2010 THEN 1 END) AS Prodaja_leta_2010
FROM Prodajalec JOIN Prodaja ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
GROUP BY Prodajalec.ProdajalecID, ImeProdajalca,PriimekProdajalca;
/*c*/
SELECT ImeProdajalca AS Ime, PriimekProdajalca AS Priimek, Vozilo.VoziloID, znamka, CAST(osnovnaCena*(1-ProcPopusta)+ProdProvizija AS DECIMAL(9,2)) AS KoncnaCena
FROM Prodajalec LEFT JOIN 
    (Prodaja JOIN Vozilo ON (Vozilo.VoziloID=Prodaja.VoziloID))
ON  (Prodajalec.ProdajalecID=Prodaja.ProdajalecID);
/*d*/
SELECT DISTINCT ImeKupca, PriimekKupca FROM Kupec 
JOIN Prodaja ON Prodaja.DavST=Kupec.DavST
JOIN Vozilo ON Vozilo.VoziloID=Prodaja.VoziloID
WHERE UPPER(znamka)='FIAT';
/*e*/
SELECT DISTINCT ImeKupca, PriimekKupca FROM Kupec 
JOIN Prodaja ON Prodaja.DavST=Kupec.DavST
JOIN Vozilo ON Vozilo.VoziloID=Prodaja.VoziloID
JOIN Prodajalec ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
WHERE ImeProdajalca='Marjeta' AND PriimekProdajalca='Pretnar';
/*f*/
SELECT Vozilo.VoziloID, znamka, model, ImeKupca, PriimekKupca
FROM Vozilo 
JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID
JOIN Kupec ON Kupec.DavST=Prodaja.DavST
WHERE EXTRACT(YEAR FROM DatumProdaje) = 2010;
/*g*/
SELECT * FROM Vozilo
WHERE letnik IN(2012,2007) AND status='na zalogi';
/*h*/
SELECT KrajKupca, COUNT(*)
FROM Kupec 
JOIN Prodaja ON Prodaja.DavST=Kupec.DavST
GROUP BY KrajKupca;
/*i*/
SELECT Kupec.PriimekKupca, Kupec.ImeKupca
FROM Kupec
LEFT JOIN 
    (Prodaja JOIN Vozilo ON (Prodaja.VoziloID = Vozilo.VoziloID AND Vozilo.Znamka = 'Fiat'))
ON (Kupec.DavSt = Prodaja.DavST)
WHERE Vozilo.VoziloID IS NULL;
/*j*/
SELECT PriimekKupca,ImeKupca, osnovnaCena*(1-PROCPOPUSTA)+PRODPROVIZIJA as moja
FROM Prodaja JOIN Vozilo ON Vozilo.VoziloID=Prodaja.VoziloID
JOIN Kupec ON Kupec.DavSt=Prodaja.DavSt
WHERE osnovnaCena*(1-PROCPOPUSTA)+PRODPROVIZIJA=(
    SELECT MAX(osnovnaCena*(1-PROCPOPUSTA)+PRODPROVIZIJA)
    FROM Prodaja JOIN Vozilo ON Vozilo.VoziloID=Prodaja.VoziloID)
;
/*k*/
SELECT ImeProdajalca, znamka, SUM(osnovnaCena*(1-ProcPopusta)+ProdProvizija)
FROM Prodaja 
JOIN vozilo ON Vozilo.VoziloID=Prodaja.VoziloID
JOIN Prodajalec ON Prodajalec.prodajalecID=Prodaja.ProdajalecID
GROUP BY ImeProdajalca, Znamka;
/*l*/
SELECT znamka, prodaja.VoziloID, model, DatumProdaje, osnovnaCena*(1-ProcPopusta)+ProdProvizija AS koncnaCena
FROM vozilo 
LEFT JOIN Prodaja ON Prodaja.VoziloID=Vozilo.VoziloID;
/*predpostavil sem da hocem kronologijo za VSE znamke in modele avta
*/
/*m*/
SELECT DISTINCT ImeProdajalca, PriimekProdajalca 
FROM Prodaja 
JOIN Prodajalec ON Prodajalec.ProdajalecID=Prodaja.ProdajalecID
JOIN Vozilo ON Vozilo.VoziloID=Prodaja.VoziloID
WHERE osnovnaCena*(1-ProcPopusta)+ProdProvizija>50000;

