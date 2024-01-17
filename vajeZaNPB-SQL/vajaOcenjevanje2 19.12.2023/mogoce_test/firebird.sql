.\isql.exe -user sysdba -password masterkey
CONNECT "C:\Users\Vegova\Downloads\PRODAJAVOZIL.FDB";
/**/
CREATE DOMAIN domenaDrzava varchar(15)
CHECK (VALUE IN ('Nemcija','Italija','Anglija','Japonska'));
/**/
ALTER TABLE KUPEC
ALTER COLUMN poreklo 
TYPE domenaDrzava not null;
/**/
ALTER TABLE vozilo
ALTER COLUMN OsnovnaCena TYPE double precision,
ALTER COLUMN OsnovnaCena POSITION 6,
ALTER COLUMN OsnovnaCena TO cena;
/**/
UPDATE vozilo 
SET Cena=(Cena*1.22), znamka=UPPER(znamka)
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - 5 < letnik;
/**/
SELECT FIRST 1 (SUBSTRING(imeKupca FROM 1 FOR 1)||'. ' || priimekKupca || ' je najboljsi kupec!') AS izpis FROM kupec
JOIN prodaja ON prodaja.davst=kupec.davst
GROUP BY imeKupca, priimekKupca
ORDER BY COUNT(imeKupca) DESC;
