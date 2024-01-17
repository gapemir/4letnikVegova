/*2*/
ALTER TABLE Avtor ADD COLUMN opus SET( 'opera', 'kantata', 'simfonija', 'koncert', 'balada', 'drugo' ) DEFAULT 'drugo'; 
/*3*/
ALTER TABLE avtor CONVERT TO CHARACTERSET utf8;
ALTER TABLE cd CONVERT TO CHARACTERSET utf8;
ALTER TABLE posnetek CONVERT TO CHARACTERSET utf8; 
/*4*/
CREATE VIEW Italija AS
SELECT  Ime,Priimek,Naslov,trajanje
FROM avtor
JOIN posnetek
ON avtor.AvtorID = posnetek.AvtorID
WHERE drzava = 'ITA'; 
/*5*/
CREATE VIEW TrajanjePoAvtorjih AS
SELECT avtor.AvtorID, Ime, Priimek, SEC_TO_TIME(SUM(TIME_TO_SEC(trajanje)))
FROM avtor
JOIN posnetek
ON avtor.AvtorID = posnetek.AvtorID
GROUP BY Avtor.AvtorID, Ime, Priimek;
/*6*/ 
CREATE VIEW slo AS 
SELECT * FROM avtor
WHERE drzava='SLO';
SHOW CREATE VIEW slo;
/*7*/ 
CREATE VIEW fra AS 
SELECT * FROM avtor
WHERE drzava='fra';
SHOW CREATE VIEW fra;
/*8*/ 
CREATE VIEW slo_fra AS
SELECT * FROM slo 
UNION ALL 
SELECT * FROM fra;
/*9*/ 
INSERT INTO slo_fra
VALUES (888,'Miki','miska','USA','1990-1-1','balada,drugo');
/*ni uspelo, ker ni insertable into
ERROR 1471 (HY000): The target table slo_fra of the INSERT is not insertable-into
*/
/*10*/ 
INSERT INTO slo
VALUES (888,'Miki','miska','USA','1990-1-1','balada,drugo');
/*je uspelo*/
/*11*/ 
SELECT * FROM AVTOR;
/*v tabeli je zapis 888*/
/*12*/ 
CREATE VIEW ita AS 
SELECT * FROM avtor
WHERE drzava='ita';
/*13*/ 
CREATE TABLE itaMemory (AvtorID int(11), Ime char(10), Priimek char(20), drzava char(3), rojen date, opus SET('opera','kantata','simfonija','koncert','balada','drugo'))
ENGINE=MEMORY
AS
SELECT * FROM ita;
/*razlika je da tabela avtor uporablja Inno_DB
itaMemory pa uporablja engine MEMORY*/
/*14*/ 
INSERT INTO ita VALUES(160,'Giacomo','Puccini','ITA','1858-12-22','opera,drugo');
/*dodajanje je uspelo*/
/*15*/ 
INSERT INTO ita VALUES(170,'Amadeus','Mozart','AVS','1756-1-27','opera,drugo');
/*dodajanje je uspelo*/
/*16*/ 
CREATE VIEW DolzinaCD AS 
SELECT naslovCD, SEC_TO_TIME(SUM(TIME_TO_SEC(trajanje))) FROM CD 
JOIN vsebina ON vsebina.CDID=CD.CDID
JOIN posnetek ON posnetek.PID=vsebina.PID
GROUP BY naslovCD;
SHOW CREATE TABLE DolzinaCD;
/*17*/ 
SHOW TABLES;
/*18*/ 
CREATE TABLE demo AS
SELECT * FROM slo_fra;
desc demo;
desc slo_fra;
desc slo;
desc fra;
desc avtor;
/*ugotovitve:
view-i nimajo primarnega ključa, zato ga tudi tabela demo nima, izgubijo se nekateri podatki 
o default vrednostih pri spajanju 2 view-ov in izgubi se tudi podatek o tipu atributa opus
pri spajanju 2 view-ov 
*/
/*19*/ 
CREATE VIEW devetnajstoStoletje AS
SELECT PID, Naslov, Genre, Trajanje, posnetek.AvtorID FROM posnetek 
JOIN avtor ON avtor.AvtorID=posnetek.AvtorID
WHERE rojen BETWEEN '1801-1-1' AND '1900-12-31';
/*20*/
CREATE VIEW CDSteviloPosnetkov AS
SELECT NaslovCD, COUNT(PID) AS stevilo FROM CD 
JOIN vsebina ON vsebina.CDID=CD.CDID
GROUP BY naslovCD;
/*21*/
SELECT naslovCD FROM CDSteviloPosnetkov
WHERE stevilo!=(SELECT MIN(stevilo) FROM CDSteviloPosnetkov);
