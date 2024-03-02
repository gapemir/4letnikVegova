--1.	Naredite arhivsko kopijo PB. Arhiv naj se nahaja na disku D (ali E) v mapi Arhiv. 
--Ime naj bo arhivDemoPB. Poročilo o izdelavi arhiva naj se izpiše na zaslon. 
--// ukaz in del poročila, ki govori o kopiranju zapisov tabel prekopirajte v poročilo vaje
.\gbak.exe -user sysdba -password masterkey -v -b "C:\Users\Vegova\Downloads\URNIK.FDB" "E:\Arhiv\arhivDempPB.fdb";
/*
gbak:writing tables
gbak:    writing table PROFESOR
gbak:         writing column PRIIMEKPROFESORJA
gbak:         writing column ROJEN
gbak:         writing column IMEPROF
gbak:         writing column PROFESORID
gbak:    writing table PREDMET
gbak:         writing column PREDMETID
gbak:         writing column KT
gbak:         writing column IMEPRED
gbak:         writing column DODATNI_OPIS
gbak:         writing column PROFESORID
gbak:    writing table UCILNICA
gbak:         writing column ST_STUDENTOV
gbak:         writing column OPREMA_UCILNICE
gbak:         writing column UCILNICAID
gbak:    writing table URNIK
gbak:         writing column PREDMETID
gbak:         writing column DAN
gbak:         writing column URA
gbak:         writing column UCILNICAID
*/
--2.	Poskusite s pomočjo isql-a povezati z arhivsko kopijo arhivDemoPB. – Ali je odpiranje uspešno, zakaj?
.\isql.exe -u sysdba -p masterkey C:\Users\Vegova\Downloads\URNIK.FDB
--odpiranje ni uspelo, ker je to arhiv in ne podatkovna baza
--3.	Dopolni stavek: velikost baze Urnik = _____1.1MB_____________, velikost arhiva arhivDemoPB=____9KB_____________. Ali sta enako veliki? Zakaj?
--4.	Izbrišite PB Urnik.fdb.
del C:\Users\Vegova\Downloads\URNIK.FDB
--5.	Iz arhivske kopije arhivDemoPB restavrirajte PB. Ime estavrirane baze naj bo demoPB. Restavrirana PB naj bo le za branje.
.\gbak.exe -user sysdba -password masterkey -c -mode read_only "E:\Arhiv\arhivDempPB.fdb" "C:\Users\Vegova\Downloads\demoPB.fdb" 
PS C:\Program Files\Firebird\Firebird_3_0>
--6.	Povežite se s PB demoPB kot sysdba in izpišite vsebino ene od tabel (denimo tabele Predmet).
select * from Predmet; 
--7.	V tabelo Predmet poskusite dodati en zapis (podatki so poljubni). Ali je zapisovanje uspelo, zakaj?
Statement failed, SQLSTATE = 42000
attempted update on read-only database
ker je db read only
--8.	Iz arhivske kopije arhivDemoPB naredite še eno restavriranje PB. Ime restavriranje PB naj bo demoPBRW.fdb. Restavrirana PB naj bo za branje in zapisovanje.
.\gbak.exe -user sysdba -password masterkey -c "E:\Arhiv\arhivDempPB.fdb" "C:\Users\Vegova\Downloads\demoPBW.fdb"
--9.	Povežite se z bazo demoPBRW kot sysdba in poskusite v tabelo Predmet dodati en zapis. Ali je zapisovanje uspešno? Zakaj?
insert into predmet values(7,'Psihologija',6,1,'psiha, what can i say');
zapisovanje je uspelo
--10.	Naredite arhivsko kopijo baze demoPB. Arhiv naj bo deljen na 2 datoteki: demoPBa1 in demoPBa2. 
--Predvidena velikost prve datoteke naj bo 2K, ostalo naj bo v drugi. 
--// sintakso delitve arhiva na več datotek si oglejte v povezavi, dani v opombi
.\gbak.exe -user sysdba -password masterkey -v -b "C:\Users\Vegova\Downloads\demoPB.FDB" "E:\Arhiv\arhivDempPBa1.fdb" 2k "E:\Arhiv\arhivDempPBa2.fdb";
--11.	Primerjate velikost arhivske datoteke arhivDemoPB in seštevek velikosti datotek demoPBa1 in demoPBa2. Ali obstaja razlika?
razlika je 0.19K verjetno zaradi novega zapisa v tabeli Predmet
--12.	Izbrišite PB DemoPBRW.fdb.
--13.	Iz arhivskih kopij demoPBa1 in demoPBa2 restavrirajte PB. Ime restavrirane PB naj bo A1A2_urnik.fdb. V kakšnem načinu se nahaja restavrirana PB A1A2_urnik.fdb. Zakaj?
C:\Program Files\Firebird\Firebird_3_0> .\gbak.exe -user sysdba -password masterkey -c "E:\Arhiv\arhivDempPBa1.fdb" "E:\Arhiv\arhivDempPBa2.fdb" "C:\Users\Vegova\Downloads\A1A2_urnik.fdb"
--14.	Povežite se s PB A1A2_urnik.fdb in izpišite vsebino tabel Predmet in Ocene.
   PREDMETID IMEPRED                                  KT PROFESORID DODATNI_OPIS
============ ============================== ============ ========== ==============================
           1 Analiza 1                                10 1          zahtevno
           2 Analiza 2                                12 1          zelo zahtevno
           3 Diskretne strukture 1                     8 1          osnovni nivo
           4 Diskretne strukture 2                    12 1          dokaj abstraktno
           5 Filozofija                               10 1          veliko podatkov
           6 Sociologija                               5 1          enostavno
tabela ocene ne obstaja
--15.	V tabelo Predmet dodajte en predmet. Ali je dodajanje uspešno?
ni uspelo ker je read_only
--16.	Poskusite restavrirati PB le iz arhivske kopije demoPBa1. Ime restavrirane baze naj bo N_urnik.fdb. Ali je restavriranje uspešno? Zakaj?
ne morem, predvidevam, ker ni cele pb 
--17.	Povežite se s  PB DemoPB. Spremenite tabelo Predmet tako, da dodate atribut Vtis (tip char 30, not null). Ali je sprememba strukture tabele uspešna? Zakaj?
ni uspela, ker pise, da je read only
--18.	Iz arhivskih kopij demoPBa1 in demoBa2 restavrirajte PB. Ime restavrirane PB naj bo Novi_urnik.fdb. Restavrirana PB naj se nahaja v načinu za branje in zapisovanje (RW).
.\gbak.exe -user sysdba -password masterkey -c -mode read_write "E:\Arhiv\arhivDempPBa1.fdb" "E:\Arhiv\arhivDempPBa2.fdb" "C:\Users\Vegova\Downloads\Novi_urnik.fdb"
--19.	Povežite se s  PB Novi_urnik.fdb. Spremenite tabelo Predmet tako, da dodate atribut Vtis (tip char 30, not null).
ALTER TABLE PREDMET ADD Vtis char(30) not null;
--20.	Arhivirajte PB A1A2_urnik.fbd. Ime arhiva naj bo Urnik_arhiv3. Potek arhiviranja naj se zapiše v datoteko porocilo3.log. Datoteka naj bo v isti mapi kot arhivska datoteka.
.\gbak.exe -user sysdba -password masterkey -b "C:\Users\Vegova\Downloads\A1A2_urnik.fdb" "E:\Arhiv\Urnik_arhiv3.fdb" > "E:\Arhiv\Urnik_arhiv3.fdb"
--21.	Izbrišite PB A1A2_urnik.fdb.
--22.	Iz arhiva Urnik_arhiv3 restavrirajte PB. Ime restavrirane PB naj bo krneki.fdb. Poročilo o restavriranju zapišite v datoteko porocilo4.log. Ali je restavriranje uspelo? Zakaj?
.\gbak.exe -user sysdba -password masterkey -c "E:\Arhiv\Urnik_arhiv3.fdb" "C:\Users\Vegova\Downloads\krneki.fdb" > "C:\Users\Vegova\Downloads\krneki.fdb"
--23.	Dopolnite prejšnji ukaz za restavriranje tako, da restavriranje PB uspelo.
no clue
