.\mysql.exe -u root
CREATE DATABASE CD;
USE CD;
CTRL^C
/**/
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
/**/
ALTER TABLE CD
MODIFY COLUMN Opombe SET('nova izdaja','zabavna izdaja','klasična izdaja');
/*mogl bi updatat vse zapise*/
/**/
SELECT CONCAT('Avtor ', Ime, ' ', Priimek, 'je izdal ', COUNT(PID), ' posnetkov.') AS haha
FROM Avtor
LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
GROUP BY Ime, Priimek;
/**/
SELECT Ime, AVG(Cena) FROM Avtor
LEFT JOIN Posnetek ON Posnetek.AvtorID=Avtor.AvtorID
LEFT JOIN Vsebina ON Vsebina.PID=Posnetek.PID
LEFT JOIN CD ON CD.CDID=Vsebina.CDID
GROUP BY Ime
ORDER BY AVG(Cena) DESC;
