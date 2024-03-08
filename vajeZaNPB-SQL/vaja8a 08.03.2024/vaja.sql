/*1.	Naloga

a)	Kreirajte naslednje uporabnike (uporabljajte sintakso od FB 3.0 dalje):
Uporabniško ime	Ime	    Priimek	    Geslo
Jurcek	        Jure	Nekdo	    jurcek
Tincek	        Tine	Lupus	    tinko
Luka	        Luka	Lovec	    lukec
Tia	            Tia		            t777
Lenci	        Lenka	Novak	    Nole123
*/
CREATE USER Jurcek FIRSTNAME 'Jure' LASTNAME 'Nekdo' PASSWORD 'jurcek';
CREATE USER Tincek FIRSTNAME 'Tine' LASTNAME 'Lupus' PASSWORD 'tinko';
CREATE USER Luka FIRSTNAME 'Luka' LASTNAME 'Lovec' PASSWORD 'lukec';
CREATE USER Tia FIRSTNAME 'Tia' PASSWORD 't777';
CREATE USER Lenci FIRSTNAME 'Lenka' LASTNAME 'Novak' PASSWORD 'Nole123';
--b)	Izpišite seznam uporabnikov.
SHOW USERS;
--c)	Spremenite priimek uporabnice Lenci v Kralj.
ALTER USER Lenci LASTNAME 'Kralj';
--d)	Spremenite geslo uporabnika Jurcek v jur331.
ALTER USER Jurcek PASSWORD 'jur331';
--e)	Prikažite podatke o uporabniku Tincku.
SELECT * FROM SEC$USERS WHERE SEC$USER_NAME = 'TINCEK';
/* 2.	naloga
a)	Kreirajte podatkovno bazo hoteli.fdb. PB naj bo v mapi FB_vaja2.*/
--b)	Napišite stavek, s katerim naredite tabelo Hotel(HotelID:N, ImeHotela:A20, Kraj:A20, Opiso:A200, Emailo:A30)
CREATE TABLE Hotel(
    HotelID int PRIMARY KEY,
    ImeHotela varchar(20) NOT NULL,
    Kraj varchar(20) NOT NULL,
    Opis varchar(200),
    Email varchar(30)
);
--c)	Napišite stavek, s katerim naredite tabelo Storitev(StoritevID:N,ImeStoritve:A20)
CREATE TABLE Storitev(
    StoritevID int PRIMARY KEY,
    ImeStoritve varchar(20) NOT NULL
);
--d)	Napišite stavek, s katerim naredite tabelo Ponudba(HotelID->Hotel:N,StoritevID->Storitev:N, Cena:N,Popusto:N). Pazite tabela ima 2 tuja ključa, primarni ključ tabele je sestavljen iz dveh atributov. Pri tujih ključih na bo za oba dogodka ('on delete' in 'on update') akcija=cascade. Dodajte še integritetno omejitev, da je cena obvezno >=0, popust pa je lahko le iz intervala [0..1] ali je prazen (NULL).
CREATE TABLE Ponudba(
    HotelID int,
    StoritevID int,
    Cena int NOT NULL CHECK(Cena >= 0),
    Popust float CHECK((Popust >= 0 AND Popust <=1) OR Popust IS NULL),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY (StoritevID) REFERENCES Storitev(StoritevID) ON UPDATE cascade ON DELETE cascade,
    PRIMARY KEY (HotelID, StoritevID)
);
/*e)	Vpišite (prepišite) naslednje stavke:
INSERT INTO Hotel VALUES (1,'Slon','Ljubljana','dober hotel','slon@email.si');
INSERT INTO Hotel (HotelID,ImeHotela,Kraj) VALUES (2,'Union','Ljubljana');
INSERT INTO Hotel (HotelID,ImeHotela,Kraj) VALUES (3,'Orel','Maribor');*/
--d) Uporabniku Jurcku dodelite pravico branja tabele Hotel.
GRANT SELECT ON Hotel TO Jurcek;
--e) Uporabniku Luki dodelite pravico branja in dodajanja novih zapisov v tabelo Hotel.
GRANT SELECT, INSERT ON Hotel TO Luka;
--f) Uporabnici Lenci dodelite vse pravice za delo s tabelo Storitev in Ponudba.
GRANT ALL ON Storitev TO Lenci;
GRANT ALL ON Ponudba TO Lenci;
--g) Prikažite vse dodeljene uporabniške pravice.
SHOW GRANTS;
--h) Prijavite se kot uporabnik Jurcek.
.\isql.exe -u Jurcek -p jurcek
CONNECT 'C:\Users\Vegova\Desktop\hoteli.fdb';
--i) Izvedite stavek Select * from Hotel;
--j) Izvedite stavek INSERT INTO Hotel VALUES (4,'Sheraton','Zagreb','dober hotel','info@sheraton.hr'); // Ali je izvedba stavka uspela? Zakaj?
ni uspela, ker Jurcek nima pravic za vstavljanje novih zapisov v tabelo Hoteli
--k) Prijavite se kot uporabnik Luka.
.\isql.exe -u Luka -p lukec
CONNECT 'C:\Users\Vegova\Desktop\hoteli.fdb';
--l) Izvedite stavek INSERT INTO Hotel VALUES (4,'Sheraton','Zagreb','dober hotel','infor@sheraton.hr'); // Ali je izvedba stavka uspela? Zakaj?
ker Luka ima pravice vstavljati zapise v tableo Hoteli
--m) Prijavite se kot uporabnica Lenci.
.\isql.exe -u Lenci -p Nole123
CONNECT 'C:\Users\Vegova\Desktop\hoteli.fdb';
/*n) Vpišite (prepišite) naslednje stavke
INSERT INTO Storitev VALUES (1,'pizza klasika');
INSERT INTO Storitev VALUES (2,'pizza kraška');
INSERT INTO Storitev VALUES (3,'pizza morska');
INSERT INTO Storitev VALUES (4,'martini dry');
SELECT * FROM Storitev;
*//*
o) Vpišite (prepišite) naslednje stavke 
INSERT INTO Ponudba VALUES (1,1,8,0);
INSERT INTO Ponudba VALUES (1,2,12,0.05);
INSERT INTO Ponudba VALUES (1,4,5,0);
INSERT INTO Ponudba VALUES (4,1,10,0);
SELECT * FROM Storitev;
*/
--n) Odgovorite na vprašanja:
--•	Kateri uporabniki lahko berejo tabelo Hotel?
Jurcek, Luka
--•	Kateri uporabniki lahko berejo tabelo Storitev?
Lenci
--•	Kateri uporabniki lahko berejo tabelo Ponudba?
Lenci
--•	Ali lahko uporabnica Lenci dodeli pravico branja tabele Storitev uporabniku Jurcek? Zakaj?
ne, ker nisem dal WITH GRANT OPTION
--•	Kdo lahko odstrani uporabniške pravice?
sysdba
--o) Prijavite se kot administrator in uporabnici Tii dodelite pravico branja in dodajanja novih zapisov v tabelo Ponudba.
GRANT SELECT, INSERT ON Ponudba TO Tia;
--p) Prijavite se kot Tia in vpišite naslednji stavek:
--INSERT INTO Ponudba VALUES (4,2,18,0); 
--r) Če izvedba prejšnjega stavka ni uspela, ugotovite zakaj, prijavite se kot administrator, ustrezno popravite dostopne pravice uporabnice Tie in (kot Tia) še enkrat izvedite zgornji stavek insert. (pod 'popravite dostopne pravice' ne mislim, da jih preprosto nastavite na ALL, temveč da Tii dodelite le nujno potrebne pravice za izvedbo stavka insert).
izvedba stavka je uspela
--s) Prijavite se kot administrator in vsem uporabnikom odstranite vse dostopne pravice.
REVOKE SELECT ON HOTEL FROM USER JURCEK;
REVOKE INSERT, SELECT ON HOTEL FROM USER LUKA;
REVOKE DELETE, INSERT, SELECT, UPDATE, REFERENCES ON PONUDBA FROM USER LENCI;
REVOKE INSERT, SELECT ON PONUDBA FROM USER TIA;
REVOKE DELETE, INSERT, SELECT, UPDATE, REFERENCES ON STORITEV FROM USER LENCI;

-- 3.	naloga
--a)	Odprite PB Hoteli in se prijavite kot administrator.
isql.exe -u sysdba -p masterkey
CONNECT 'C:\Users\Vegova\Desktop\hoteli.fdb';
--b)	Kreirajte dve uporabniški skupini: gostje in delavec.
CREATE ROLE gostje;
CREATE ROLE delavec;
--c)	Uporabniški skupini gostje dodelite pravico branja vseh treh tabel (Hotel, Storitev in Ponudba).
GRANT SELECT ON Hotel TO ROLE gostje;
GRANT SELECT ON Storitev TO ROLE gostje;
GRANT SELECT ON Ponudba TO ROLE gostje;
--d)	Uporabniški skupini delavec dodelite pravico branja tabele Hotel in vse pravice nad tabelami Ponudba in Storitev.
GRANT SELECT ON Hotel TO ROLE delavec;
GRANT ALL ON Storitev TO ROLE delavec;
GRANT ALL ON Ponudba TO ROLE delavec;
--e)	V uporabniško skupino Gostje dodajte Tio, Jurcka in Tincka, v uporabniško skupino Delavec pa preostala dva uporabnika (Luka, Lenci).
GRANT gostje TO USER Tia;
GRANT gostje TO USER Jurcek;
GRANT gostje TO USER Tincek;
GRANT delavec TO USER Lenci;
GRANT delavec TO USER Luka;
--f)	Prikažite vse dodeljene pravice.
--g)	Prijavite se kot 'samostojni' Jurcek (ne kot član skupine Gostje) in izvedite naslednji stavek: SELECT * FROM Hotel WHERE Kraj='Ljubljana'; // Ali je izvedba uspela, zakaj?
ker nimamo pravic, ker jih nismo zahtevali ob prijavi
--h)	Prijavite se kot Jurcek, ki je član skupine Gostje in izvedite naslednji stavek: SELECT * FROM Hotel WHERE Kraj='Ljubljana'; // Ali je izvedba uspela, zakaj?
izvedba je uspela, ker smo sedaj dobili pravice članov gostje
--i)	Prijavite se kot Luka, ki je član skupine Delavec in izvedite naslednji stavek: INSERT INTO Storitev VALUES (5,'Cocta'); // Ali je izvedba uspela, zakaj?
izvedba je uspela, ker je luka član delvacev in delavci imajo pravico vstavljati podatke v tablelo Storitev
--j)	Izvedite stavek: INSERT INTO Ponudba VALUES (2,5,2,0); // Ali je izvedba uspela, zakaj?
-||-
--k)	Prijavite se kot administrator in uporabniški skupini Delavec odstranite vse pravice, razen pravice branja.
REVOKE INSERT, DELETE, UPDATE, REFERENCES ON PONUDBA FROM ROLE delavec;
REVOKE INSERT, DELETE, UPDATE, REFERENCES ON STORITEV FROM ROLE delavec;
--l)	Prijavite se kot Lenci, ki je član skupine Delavec.
.\isql.exe -u Lenci -p Nole123 -role delavec
CONNECT 'C:\Users\Vegova\Desktop\hoteli.fdb'
--m)	Izvedite stavek SELECT * FROM Storitev; // Ali je izvedba uspela, zakaj?
ker imajo delavci se vedno select dostop do table storitev
--n)	Prijavite se kot administrator in izbrišite vse uporabniške skupine. Ali so izbrisani tudi uporabniki, zakaj? Ali uporabniki še naprej imajo pravico branja tabel Hotel, Storitev in Ponudba, zakaj?
DROP ROLE delavec;
DROP ROLE gostje;
uporabniki niso izbrisani, vendar nimajo nobenih skupin torej nimajo pravic
--4.	naloga
--a)	Odprite program gsec (prijavite se kot administrator).
gsec.exe -user sysdba -password masterkey
--b)	Izbrišite uporabnike: Jurcek, Tincek, Luka, Tina (Lenci naj ostane).
DELETE TINCEK
DELETE TIA
DELETE JURCEK
DELETE LUKA
--c)	Prikažite seznam vseh uporabnikov.
DISPLAY
--d)	Povežite se s PB Hoteli kot administrator.
isql.exe -u sysdba -p masterkey
CONNECT 'C:\Users\Vegova\Desktop\hoteli.fdb';
--e)	Prikažite vse dostopne pravice.
SHOW GRANTS
vrne mi tolele
There is no privilege granted in this database