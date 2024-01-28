/*1*/
SELECT ime, priimek FROM Stranka
WHERE EMSO IN (
    SELECT EMSO FROM Najem N
    JOIN Vozilo V ON V.SerStev = N.SerStev
    JOIN Proizvajalec P ON P.ProizvajalecID = V.ProizvajalecID
    WHERE EXTRACT(YEAR FROM Datum_najema) = 2012 AND Poreklo IN('Nemcija', 'Italija')
);
/*2*/
SELECT ime, priimek FROM Stranka
WHERE EMSO IN (
    SELECT EMSO FROM Najem N
    JOIN Vozilo V ON V.SerStev = N.SerStev
    JOIN Proizvajalec P ON P.ProizvajalecID = V.ProizvajalecID
    WHERE EXTRACT(YEAR FROM Datum_najema) = 2012 AND Poreklo = 'Italija'
) AND EMSO IN (
    SELECT EMSO FROM Najem N
    JOIN Vozilo V ON V.SerStev = N.SerStev
    JOIN Proizvajalec P ON P.ProizvajalecID = V.ProizvajalecID
    WHERE EXTRACT(YEAR FROM Datum_najema) = 2012 AND Poreklo = 'Nemčija'
);
/*3*/
SELECT * FROM Vozilo V
JOIN Proizvajalec I ON I.ProizvajalecID=V.ProizvajalecID
WHERE Prostornina = (SELECT MAX(Prostornina) FROM Vozilo);
/*4*/
SELECT COUNT(SerStev) FROM Vozilo V
JOIN Proizvajalec P ON P.ProizvajalecID=V.ProizvajalecID
WHERE Znamka = 'Ferrari';
/*5*/
DELETE FROM Najem 
WHERE EMSO IN (
    SELECT V.EMSO FROM Stranka S
    JOIN Voznisko_dovoljenje V ON V.EMSO = S.EMSO
    WHERE Kazenske_tocke>18
);
/*6*/
SELECT * FROM Stranka 
WHERE EMSO IN (
    SELECT EMSO FROM Vozilo V
    JOIN Najem N ON N.SerStev=V.SerStev
    WHERE Pogon='Vsa kolesa'
    GROUP BY EMSO 
    HAVING COUNT(EMSO)>1
);
/*7*/
SELECT Znamka, Poreklo FROM Proizvajalec 
WHERE ProizvajalecID IN (
    SELECT N.ProizvajalecID FROM Vozilo V
    JOIN Najem N ON N.SerStev=V.SerStev
    GROUP BY ProizvajalecID
    HAVING(COUNT(DISTINCT EMSO)) = (SELECT COUNT(DISTINCT EMSO) FROM Stranka)
)
/*8*/
SELECT * FROM Voznisko_dovoljenje 
WHERE Stev_vozniske IN (
    SELECT Stev_vozniske FROM Stranka S
    JOIN Najem N ON N.EMSO=S.EMSO
    JOIN Vozilo V ON V.SerStev=N.SerStev
    WHERE model = '911 Carrera S'
) AND Stev_vozniske IN (
    SELECT Stev_vozniske FROM Stranka S
    JOIN Najem N ON N.EMSO=S.EMSO
    JOIN Vozilo V ON V.SerStev=N.SerStev
    WHERE model = '911 Turbo S'
);
/*9*/
SELECT Ime, Priimek FROM Stranka
WHERE EMSO = (
    SELECT FIRST 1 EMSO FROM Najem
    GROUP BY EMSO
    ORDER BY COUNT(EMSO) DESC
);
/*10*/
/*isto kot 6*/
/*11*/
SELECT Znamka, COUNT(EMSO) FROM Proizvajalec P
JOIN Vozilo V ON V.ProizvajalecID=P.ProizvajalecID
JOIN Najem N ON N.SerStev=V.SerStev
GROUP BY Znamka;
/*12*/
SELECT Poreklo, Znamka FROM Proizvajalec P
WHERE ProizvajalecID NOT IN(
    SELECT V.ProizvajalecID FROM Vozilo V
    JOIN Najem N ON N.SerStev=V.SerStev
);
/*13*/
SELECT Ime, Priimek, Stev_vozniske, S.EMSO, Datum_izdaje, Datum_veljavnosti, Kazenske_tocke 
FROM Stranka S JOIN Voznisko_dovoljenje V ON S.EMSO=V.EMSO 
WHERE S.EMSO NOT IN(
    SELECT EMSO FROM Najem N
    JOIN Vozilo V ON V.SerStev=N.SerStev
    JOIN Proizvajalec P ON P.ProizvajalecID=V.ProizvajalecID
    WHERE Znamka != 'Aston Martin'
) AND S.EMSO IN(
    SELECT EMSO FROM Najem N
    JOIN Vozilo V ON V.SerStev=N.SerStev
    JOIN Proizvajalec P ON P.ProizvajalecID=V.ProizvajalecID
    WHERE Znamka = 'Aston Martin'
)