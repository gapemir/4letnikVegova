--1.	naloga
--a)	Izpišite seznam obstiječih uporabnikov  (ime uporabnika, ime strežnika in geslo).
SELECT User, Host, Password  FROM mysql.user;
--b)	Kreirajte naslednje uporabnike:
/*ImeStrežnika	Ime Uporabnika	Geslo (besedilo)
localhost	Andreja	Geslo1
localhost	Matej	Geslo2
127.0.0.1	Luka	Lovec
Katerikoli strežnik, ki ima v imenu zaporedje črk abc (no ja, takega strežnika ni, vendar ...)	Tia	
localhost	Jani	*/
CREATE USER Andreja@localhost IDENTIFIED BY 'Geslo1';
CREATE USER Matej@localhost IDENTIFIED BY 'Geslo2';
CREATE USER Luka@127.0.0.1 IDENTIFIED BY 'Lovec'; 
CREATE USER Tia@abc;
CREATE USER Jani@localhost;
--c)	Izpišite seznam uporabnikov (ime uporabnika, ime strežnika in geslo)..
SELECT User, Host, Password  FROM mysql.user;
--d)	Ustvarite novega uporabnika tako, da je geslo podatek v enkriptirani obliki. Ime strežnika naj bo localhost, ime uporabnika naj bo Mojca, geslo naj bo enako, kot ga ima Andreja.
CREATE USER Mojca@localhost IDENTIFIED BY PASSWORD 'Geslo1';
/*noce vzeti tega kot geslo*/
--e)	Izpišite seznam uporabnikov (ime uporabnika, ime strežnika in geslo). Primerjajte gesli Andreje in Mojce.
SELECT User, Host, Password  FROM mysql.user;
--f)	Spremenite geslo uporabnika Matej. Novo geslo naj bo GesloX.*/
ALTER USER Matej@localhost IDENTIFIED BY 'GesloX';

--2.	naloga
--a)	Prenesite na računalnik shripto zbirkacd in jo uvezite v mysql. (pomoč:) Uporabite stavek:
--C:\...\mysql\bin>mysql –u root –p <zbirkacd.sql

/*b)	Povežite se s PB zbirkacd(kot administrator oz root).
Uporabnici Andreja dodelite pravico branja in dodajanja zapisov za vse tabele v PB zbirkacd.
Uporabniku Matej dodelite pravico branja tabele Avtor.
Uporabniku Luka dodelite pravico branja in brisanja zapisov tabele Posnetek.
Izpišite vse dodeljene pravice.
*/
GRANT SELECT, INSERT ON ZbirkaCD.* TO Andreja;
GRANT SELECT ON ZbirkaCD.Avtor TO Matej@localhost;
GRANT SELECT,DELETE ON ZbirkaCD.Posnetek TO Luka@127.0.0.1;
/*c)	Prijavite se kot uporabnica Andreja in izpišite vsebino dveh tabel (katerihkoli).
Poskusite dodati nov zapis v tabelo avtor (podatki so poljubni).
Poskusite izbrisati dodani zapis.*/
SELECT * FROM Avtor;
SELECT * FROM CD;
INSERT INTO Avtor(Ime,Priimek,drzava,rojen) VALUES('Gašper','Nemgar','SLO','2005-12-21');
DELETE FROM Avtor WHERE Ime='Gašper';
/*d)	Prijavite se kot uporabnik Matej in poskusite izpisati vsebino tabele avtor.
Poskusite izpisati vsebino tabele Posnetek.
Poskusite izbrisati vsebino tabele Posnetek.
Spremenite se geslo na 'niSnega2012'.*/
SELECT * FROM Avtor;
SELECT * FROM Posnetek;
DELETE FROM Posnetek; 
SET PASSWORD FOR 'Matej'@'localhost' = PASSWORD('niSnega2012'); 
/*e)	Prijavite se kot uporabnik Luka in poskusite izpisati vsebino tabele Posnetek.
Poskusite izbirsati en posnetek.
Poskusite izbrisati enega avtorja.*/
SELECT * FROM Posnetek;
DELETE FROM Posnetek WHERE PID = 12
DELETE FROM Avtor;
--f)	Prijavite se kot Tia in izpišite vsebino tabele Avtor.
./mysql.exe -u Tia -h abc -p
--g)	Prijavite se kot administrator (root) in odvzemite vse pravice uporabnikom Luka in Matej.
REVOKE ALL ON *.* FROM Luka@127.0.0.1;
REVOKE ALL ON *.* FROM Matej@localhost;

--3.	Naloga (arhviriranje+restavracija PB)
--a)	Prenesite skripto data.sql (skripta vsebuje arhivsko kopijo PB primer2sola) in jo importirajte v MySQL.
type 'C:\Users\Gasper Nemgar\Downloads\data.sql' | ./mysql.exe -u root -p
--b)	Tabeli izvaja dodajte podatek 'zacetek' tipa datum in število mest tipa integer.
alter table izvaja add column zacetek date;
alter table izvaja add column st_mest int; 
--c)	Vstavite podatke o šolah:
--d)	4,'Gim Poljane','Poljanska 2 Ljubljana','+386332312','uprava@poljane.si', in 
INSERT INTO sola VALUES(4,'Gim Poljane','Poljanska 2 Ljubljana','+386332312','uprava@poljane.si');
--e)	5,'Gim. Jesenice','Titova 44 Jesenice','+3864444242','gimanzija@jesenice.si'.
 INSERT INTO sola VALUES(5,'Gim. Jesenice','Titova 44 Jesenice','+3864444242','gimanzija@jesenice.si');
--f)	Napišite stavek SQL, ki izpiše:
--a.	imena šol ki izvajajo katerikoli tehnični program;
SELECT ImeSole FROM Sola 
JOIN Izvaja ON Izvaja.SolaID=Sola.SolaID 
JOIN program ON program.ProgramID=izvaja.ProgramID 
WHERE ImePrograma LIKE '%tehnik%';
--b.	imena šol, ki izvajajo več kot 1 program.
SELECT ImeSole FROM Sola 
JOIN Izvaja ON Izvaja.SolaID=Sola.SolaID 
JOIN program ON program.ProgramID=izvaja.ProgramID 
GROUP BY ImeSole 
HAVING COUNT(program.ProgramID) > 1;
--g)	Posodobite tabelo izvaja s podatki: 
--h)	TSC ima za rac. Tehnika 70 mest in program izvaja od 1.9.1995, 
UPDATE Izvaja SET zacetek = '1995-09-01', st_mest = 70
WHERE SolaID IN (
    SELECT SolaID FROM sola
    WHERE ImeSole='TSC'
) AND ProgramID IN (
    SELECT ProgramID FROM Program
    WHERE ImePrograma='racunalniski tehnik'
);
--i)	Vegova ima za rac. Tehnika 120 mest in izvaja program od 1.9.1993.
UPDATE Izvaja SET zacetek = '1993-09-01', st_mest = 120
WHERE SolaID IN (
    SELECT SolaID FROM sola
    WHERE ImeSole='Vegova'
) AND ProgramID IN (
    SELECT ProgramID FROM Program
    WHERE ImePrograma='racunalniski tehnik'
);
--j)	Pri vseh gimnazijah vpišite, da je število mest 100 in izvajajo program od '1.9.1998'.
UPDATE Izvaja SET zacetek = '1998-09-01', st_mest = 100
WHERE ProgramID IN (
    SELECT ProgramID FROM Program
    WHERE ImePrograma LIKE '%gimnazija%'
);
--k)	Za vsako šolo izpišite ime in število mest.
SELECT ImeSole, SUM(st_mest) AS stevilo_mest FROM Sola 
JOIN Izvaja ON Izvaja.SolaID=Sola.SolaID 
JOIN program ON program.ProgramID=izvaja.ProgramID
GROUP BY ImeSole;
--l)	Šoli TSC pri vseh programih povečajte število mest za 20.
UPDATE Izvaja SET st_mest = st_mest + 20
WHERE SolaID IN (
    SELECT SolaID FROM sola
    WHERE ImeSole='TSC'
);
--m)	Šolam iz Ljubljane, ki izvajajo gimazijski program, zmanjšajte število mest za 5. 
UPDATE Izvaja SET st_mest = st_mest - 5
WHERE SolaID IN (
    SELECT SolaID FROM sola
    WHERE Naslov LIKE '%Ljubljana%'
) AND ProgramID IN (
    SELECT ProgramID FROM Program 
    WHERE ImePrograma LIKE '%gimnazija%'
);
--n)	V stolpcu podatki izpišite ime šole in naslov tako, da je med podatkoma presledek.
SELECT CONCAT(ImeSole, ' ', Naslov) FROM Sola;
--o)	V stolpcu izpis izpišite ime šole in zadnjih 6 znakov telefonske številke šole. Med podatkoma naj bo besedilo ' tel: '.
SELECT CONCAT(ImeSole, ' ', SUBSTRING(Telefon FROM -6 FOR 6)) FROM Sola;
--p)	V tabelo 'Tehnicne' prepišite podatke o šolah, ki izvajajo katerikolik tehnični program.
CREATE TABLE Tehnicne AS 
SELECT * FROM Sola 
WHERE SolaID IN (
    SELECT SolaID FROM Izvaja
    JOIN Program ON Program.ProgramID=Izvaja.ProgramID
    WHERE ImePrograma LIKE '%tehnik%'
);
--q)	PB primer2sola izvozite v skripto primer2sola.sql. 
.\mysqldump.exe -u root -p '' primer2sola Sola > primer2sola.sql
--r)	Tabelo Sola arhivirajte v datoteko solaizvoz.sql. 
.\mysqldump.exe -u root -p '' primer2sola Sola > solaizvoz.sql
--s)	Podatke tabele Program izvozite v datoteko Program.xml.
.\mysqldump.exe -u root -p '' --xml primer2sola Program > Program.xml
--t)	Podatke tabele Sola izvozite v datoteko Sola.csv in jo importirajte v Excel.
.\mysqldump.exe -u root -p -t -T/xampp primer2sola Sola --fields-terminated-by=','
--u)	Ustvarite novo PB SrednjeSole in uvozite skripto solaizvoz.sql.
./mysql.exe -u root -p SrednjeSole < solaizvoz.sql
--v)	Naredite popolno kopijo PB primer2sola: Ime kopije naj bo SolskiProgrami.
./mysql.exe -u root -p SolskiProgrami < solaizvoz.sql