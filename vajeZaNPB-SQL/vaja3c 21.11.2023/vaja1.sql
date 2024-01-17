/*.\mysql.exe -u root*/
/*a*/
SELECT Ime, Priimek, Naslov
FROM Avtor JOIN Posnetek ON Posnetek.AvtorID = Avtor.AvtorID
WHERE EXTRACT(Minute FROM Trajanje) < 4;
/*b*/
SELECT Drzava, COUNT(*) FROM Avtor
GROUP BY Drzava
ORDER BY Drzava;
/*c*/
SELECT SEC_TO_TIME(CAST(AVG(TIME_TO_SEC(Trajanje)) AS INT)) FROM Posnetek;
/*d*/
SELECT Genre, SEC_TO_TIME(CAST(AVG(TIME_TO_SEC(Trajanje)) AS INT)) FROM Posnetek
GROUP BY Genre;
/*e*/
SELECT NaslovCD, CD.CDID FROM CD
LEFT JOIN Vsebina ON Vsebina.CDID=CD.CDID
GROUP BY CD.CDID, NaslovCD, Cena, Opombe, Leto
HAVING COUNT(*) < 6;
/*f*/
SELECT Ime, priimek,CD.CDID, NaslovCD, Cena, Opombe, Leto FROM Avtor 
LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
LEFT JOIN Vsebina ON Vsebina.PID=Posnetek.PID
LEFT JOIN CD ON CD.CDID=Vsebina.CDID
WHERE EXTRACT(YEAR FROM rojen) BETWEEN 1801 AND 1900 
GROUP BY Ime, priimek, CD.CDID, NaslovCD, Cena, Opombe, Leto;
/*g*/
SELECT Ime, priimek,CD.CDID, NaslovCD, Cena, Opombe, Leto FROM Avtor 
LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
LEFT JOIN Vsebina ON Vsebina.PID=Posnetek.PID
LEFT JOIN CD ON CD.CDID=Vsebina.CDID
WHERE EXTRACT(YEAR FROM rojen) BETWEEN 1801 AND 1900 
GROUP BY Ime, priimek, CD.CDID, NaslovCD, Cena, Opombe, Leto
ORDER BY rojen DESC
LIMIT 5;
/*h*/
SELECT Ime, Priimek, COUNT(PID) AS NapisaniPosnetki FROM Avtor
LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
GROUP BY Ime, Priimek;
/*i*/
SELECT Ime, Priimek, Drzava, Rojen FROM Avtor 
JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
GROUP BY Ime, Priimek, Drzava, Rojen
ORDER BY COUNT(ime) DESC 
LIMIT 1;
/*j*/
SELECT SUM(t.Cena) FROM (
    SELECT CD.CDID, AVG(Cena) as Cena FROM CD 
    JOIN Vsebina ON Vsebina.CDID=CD.CDID
    JOIN Posnetek ON Posnetek.PID=Vsebina.PID
    WHERE LOWER(Genre) = 'pop'
    GROUP BY CD.CDID, Cena
) as t;
/*k*/
SELECT AVG(Cena) FROM CD
WHERE NaslovCD LIKE'%a%' AND NOT Opombe IS NULL
/*l*/
SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(Trajanje))) FROM Posnetek 
JOIN Avtor ON Avtor.AvtorID=Posnetek.AvtorID
WHERE UPPER(Drzava) IN ('SLO','ITA','NEM')
GROUP BY Avtor.AvtorID
HAVING SUM(TIME_TO_SEC(Trajanje))>3599;
