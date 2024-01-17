/*a*/
CREATE VIEW PovprecjePopustaProdajalcev AS
SELECT  ImeProdajalca, PriimekProdajalca, AVG(p.ProcPopusta) AS PovprecjePopusta
FROM Prodaja p
JOIN Prodajalec pr ON p.ProdajalecID = pr.ProdajalecID
GROUP BY  pr.ImeProdajalca, pr.PriimekProdajalca;
/*b*/
DELETE FROM PovprecjePopustaProdajalcev
WHERE PriimekProdajalca LIKE 'P%';
/*ni uspelo*/
/*c*/
SELECT FIRST 1 PriimekProdajalca, ImeProdajalca
FROM PovprecjePopustaProdajalcev
ORDER BY PovprecjePopusta DESC;
/*d*/
CREATE VIEW stProdajPoMesecih AS
SELECT EXTRACT(MONTH FROM datumProdaje) AS MESEC, COUNT(voziloID) AS STEVILO
FROM Prodaja
GROUP BY EXTRACT(MONTH FROM datumProdaje);
/*e*/
SELECT * FROM stProdajPoMesecih
WHERE STEVILO = (SELECT MAX(STEVILO) FROM stProdajPoMesecih);
/*f*/
CREATE VIEW znamkeVozilPoKraju AS
SELECT znamka, UPPER(krajKupca) AS KrajKupca
FROM vozilo
JOIN prodaja ON prodaja.voziloID=vozilo.voziloID
JOIN kupec ON kupec.davst=prodaja.davst
GROUP BY znamka, UPPER(krajKupca)
ORDER BY UPPER(KrajKupca);
/*g*/
CREATE VIEW kupciVozila AS
SELECT kupec.davst, imekupca, Priimekkupca,naslovkupca,krajkupca,voziloID,datumProdaje,ProdajalecID,ProcPopusta,prodprovizija
FROM kupec
LEFT JOIN prodaja ON kupec.davst=prodaja.davst;
/*h*/
INSERT INTO kupciVozila
VALUES('13561245','Ana','Kralj','Ljubljanska 23','Maribor','1','2023-12-05','1',0.050000001,2315.0000);
/*i*/
CREATE VIEW znamkaManjKot5 AS
SELECT * FROM vozilo
WHERE strlen(trim(znamka))<6;
/*j*/
UPDATE znamkaManjKot5 SET letnik=letnik+3;
/*k*/
CREATE VIEW imePriimekProdajalcevVozila AS
SELECT ImeProdajalca,PriimekProdajalca,znamka,model
FROM prodaja 
RIGHT JOIN Prodajalec ON Prodajalec.ProdajalecID=prodaja.ProdajalecID
RIGHT JOIN vozilo ON vozilo.voziloID=prodaja.voziloID;
/*l*/
CREATE VIEW prodajaZadnjih10Mesecev AS
SELECT znamka,model,Priimekkupca,imekupca,datumProdaje,(osnovnacena*(100-ProcPopusta)+prodprovizija) AS koncnaCena
FROM prodaja
JOIN vozilo ON vozilo.voziloID=prodaja.voziloID
JOIN kupec ON kupec.davst=prodaja.davst
WHERE DatumProdaje >= DATEADD(MONTH, -10, CURRENT_DATE);
/*m*/
SELECT znamka,model,Priimekkupca,imekupca,datumProdaje,koncnaCena
FROM prodajaZadnjih10Mesecev
WHERE DatumProdaje >= DATEADD(DAY, -50, CURRENT_DATE);