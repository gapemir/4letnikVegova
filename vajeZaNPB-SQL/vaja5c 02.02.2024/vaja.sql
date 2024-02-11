/*a) Poizvedbo, ki vrne naslove in cene zgoščenk, ki ne vsebujejo posnetkov zvrsti klasika.*/
SELECT NaslovCD, Cena FROM CD 
JOIN vsebina ON vsebina.CDID=CD.CDID
JOIN Posnetek ON Posnetek.PID=Vsebina.PID
WHERE Genre != 'klasika'
GROUP BY NaslovCD, Cena;
/*b) Poizvedbo, ki izpiše število avtorjev po posameznih državah, za vse tiste avtorje, ki pišejo posnetke*/
/*iste zvrsti kot avtor s priimkom »ORFF«. Poizvedba naj bo abecedno urejena po imenih držav.*/
SELECT COUNT(*) AS steviloAvtorjev, drzava FROM Avtor 
JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
WHERE genre IN(
    SELECT genre FROM Avtor 
    JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
    WHERE Priimek ="ORFF"
)
GROUP BY drzava;
/*c) Poizvedbo, ki Izpiše vse podatke tistih zgoščenk, ki imajo vsebujejo manj posnetkov kot zgoščenka, ki v naslovu vsebuje niz »Izbor«.*/
SELECT CD.CDID, NaslovCD, Cena, Opombe, Leto FROM CD
LEFT JOIN Vsebina ON Vsebina.CDID=CD.CDID
GROUP BY CD.CDID, NaslovCD, Cena, Opombe, Leto
HAVING(COUNT(NaslovCD)) < (
    SELECT COUNT(CD.CDID) AS steviloPosnetkov FROM CD
    JOIN Vsebina ON Vsebina.CDID=CD.CDID
    WHERE NaslovCD LIKE "%Izbor%"
)
/*d) Poizvedbo, ki vrne imena in priimke avtorjev, ki še niso napisali nobenega posnetka.*/
SELECT Ime, Priimek FROM Avtor
WHERE AvtorID NOT IN (
    SELECT AvtorID FROM Posnetek
);
/*e) Poizvedbo, ki vrne vse podatke tiste zgoščenke, ki vsebuje najmanj posnetkov. V kolikor je takih zgoščenk več, poizvedba izpiše vse.*/
SELECT CD.CDID, NaslovCD, Cena, Opombe, Leto FROM CD
JOIN Vsebina ON Vsebina.CDID=CD.CDID
GROUP BY CD.CDID, NaslovCD, Cena, Opombe, Leto
HAVING COUNT(CD.CDID) = (
    SELECT COUNT(CDID) FROM Vsebina
    GROUP BY CDID
    ORDER BY COUNT(CDID)
    LIMIT 1
);
/*f) Poizvedbo, ki vrne najnižjo ceno zgoščenke, ki vsebuje vsaj posnetek klasične zvrsti.*/
SELECT MIN(Cena) FROM CD
WHERE CDID IN (
    SELECT CDID FROM Vsebina 
    JOIN Posnetek ON Posnetek.PID=Vsebina.PID
    WHERE Genre="klasika"
    GROUP BY CDID
);
/*g) Poizvedbo, ki vrne skupno (vsota) ceno vseh zgoščenk, ki vsebujejo vsaj dva posnetka zvrsti rock ter vsaj dva posnetka zvrsti pop.*/
SELECT SUM Cena FROM CD 
WHERE CDID IN (
    SELECT CDID FROM Vsebina
    JOIN Posnetek ON Posnetek.PID=Vsebina.PID
    WHERE Genre="pop"
    GROUP BY CDID
    HAVING COUNT(CDID) > 1
) AND CDID IN (
    SELECT CDID FROM Vsebina
    JOIN Posnetek ON Posnetek.PID=Vsebina.PID
    WHERE Genre="klasika"
    GROUP BY CDID
    HAVING COUNT(CDID) > 1
)
/*h) SQL stavek, ki poveča ceno zgoščenk za 15%, za tiste zgoščenke, katerih naslov presega 10 znakov, v ter imajo vnesen podatek v atributu Opombe.*/
UPDATE CD 
SET Cena = Cena*1.15
WHERE CDID IN (
    SELECT CDID FROM CD 
    WHERE LENGTH(NaslovCD) > 10
    AND Opombe IS NOT NULL
);
/*i) Poizvedbo, ki vrne povprečno število posnetkov, ki so jih izdali slovenski, hrvaški ali italijanski avtorji. V poizvedbi uporabite operator IN.*/
SELECT AVG(steviloPosnetkov) FROM (
    SELECT COUNT(Naslov) as steviloPosnetkov FROM Avtor
    LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
    WHERE drzava IN ('SLO','ITA','HRV')
    GROUP BY Avtor.AvtorID
) AS a
/*j) SQL stavek, ki spremeni na naslove zgoščenk v velike črke, za tiste zgoščenke, ki so bile izdane več kot 13 let nazaj (glede na današnji datum), izdali pa so jih avtorji iz ZDA.*/
UPDATE CD 
SET NaslovCD = UPPER(NaslovCD)
WHERE CDID IN (
    SELECT CDID FROM CD
    WHERE EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - leto > 13
);
/*k) Poizvedbo, ki vrne vse podatke zgoščenk, ki vsebujejo posnetkov izključno zvrsti klasika ter vse vse podatke zgoščenk, ki vsebujejo vsaj en posnetek zvrsti rock.*/
SELECT * FROM CD 
WHERE CDID NOT IN (
    SELECT CDID FROM Vsebina
    RIGHT JOIN Posnetek ON Posnetek.PID=Vsebina.PID
    WHERE Genre != "klasika"
);
/*l) SQL stavek, ki briše tiste zgoščenke, katerih povprečno trajanje posnetka presega 6 minute.*/
DELETE FROM CD
WHERE CDID IN (
    SELECT CDID FROM Posnetek
    JOIN Vsebina ON Vsebina.PID = Posnetek.PID
    GROUP BY CDID
    HAVING AVG(Trajanje) > 600
)
/*m) Poizvedbo, ki izpiše naslove vseh posnetkov, poleg pa še imena in priimke vseh avtorjev, ki so*/
/*zgoščenke izdali ali pa jih še bodo izdali.*/
SELECT p.Naslov AS Naslov_Posnetka, a.Ime AS Ime_Avtorja, a.Priimek AS Priimek_Avtorja FROM posnetek p
JOIN vsebina v ON p.PID = v.PID
JOIN cd c ON v.CDID = c.CDID
JOIN avtor a ON p.AvtorID = a.AvtorID
WHERE c.leto <= YEAR(CURDATE());