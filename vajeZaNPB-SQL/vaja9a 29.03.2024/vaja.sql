/*1.	naloga
napišite (prekopirajte) programsko kodo procedure, ki izpiše podatke o n-tem zapisu tabele Izdelek (n je vhodni parameter)*/
set term !! ;
create procedure izpis1 (n integer) returns (vrstica char(80)) as
declare variable L_ime_izdelka char(20);
declare variable stevec integer default 1;
begin
  vrstica = '-1';
  for select ime_izdelka from izdelek into :L_ime_izdelka
  do
  begin
    if (stevec = n) then
    begin
     vrstica = trim(cast(n as char(3))) || '. izdelek= ' || UPPER(L_ime_izdelka);
     suspend;
    end
    stevec = stevec + 1;
  end
  if (vrstica = '-1') then
    vrstica = 'Tega zapisa ni v tabeli';
end !!
set term ; !!
--a)	kodo prenesite v isql
CONNECT C:/Users/Vegova/Downloads/TRGOVINA.FDB
--b)	s stavkom show procedure preverite, ali je procedura izpis1 v PB.
show procedures;
--c)	pokličite izvajanje shranjene procedure (vhodni param. naj bo 2, 5, 10)
--d)	popravite proceduro tako, da med zaporedno številko in piko ne bo presledkov
--e)	iz baze izbrišite obstoječo proceduro izpis1 in prenesite popravljeno inačico
drop procedure izpis1;
--f)	pokličite izvajanje popravljene shranjene procedure (vhodni param. naj bo 2, 5, 10)
--g)	popravite proceduro tako, da se imena izdelkov izpisujejo z velikimi črkami
--h)	iz baze izbrišite obstoječo proceduro izpis1 in prenesite popravljeno inačico
drop procedure izpis1;
--i)	pokličite izvajanje popravljene shranjene procedure (vhodni param. naj bo 2, 5, 10)
execute procedure izpis1(2);
execute procedure izpis1(5);
execute procedure izpis1(10);
--j)	popravite proceduro tako da, če tabela nima n-tega zapisa, dobimo obvestilo 'Tega zapisa ni v tabeli'. Če zapis obstaja, naj bo izpis enak, kot v prejšnji nalogi.
--k)	iz baze izbrišite obstoječo proceduro izpis1 in prenesite popravljeno inačico
drop procedure izpis1;
--l)	pokličite izvajanje popravljene shranjene procedure (vhodni param. naj bo 2, 5, 10)
execute procedure izpis1(2);
execute procedure izpis1(5);
execute procedure izpis1(10);

/*2.	naloga
Napišite shranjeno proceduro ki bo izpisala podatke o izdelkih po padajoči vrednosti cene izdelka. Vrstice izpisa morajo biti oštevilčene! Primer izpisa:
PODATKI
==================================
1. Jajčni liker        7.00
2. Malinov sirup       4.10
3. Domači rezanci      3.20
4. Špageti             2.80
5. Jajčni rezanci      2.80
6. Union Grand         2.10
7. Uni                 1.80 
Napišite klic shranjene procedure.*/
SET TERM !! ;
CREATE PROCEDURE izpis2()
RETURNS (podatki varchar(100)) as
DECLARE VARIABLE stevec int DEFAULT 1;
DECLARE VARIABLE ime varchar(50);
DECLARE VARIABLE cena float;
BEGIN 
    FOR SELECT ime_izdelka, cena FROM Izdelek
    ORDER BY cena DESC
    INTO :ime, :cena DO
    BEGIN
        podatki = stevec || '. ' || :ime || ROUND(:cena,2);
        SUSPEND;
        stevec = stevec + 1;
    END
END !!
SET TERM ; !!
/*3.	naloga
Napišite shranjeno proceduro, ki izpiše ime_izdelka in za koliko bi se nominalno povečala cena izdelka, če se stopnja DDV spremeni za n%. N in ime izdelka sta vhodna parametra procedure. Primer:
Jajčni liker ima ceno 7.00 in trenutna stopnja DDV je 0.20 (20%). To pomeni, da je za jajčni liker cena z DDV 8.40. Če je vhodni parameter n 0.02, bi nova cena z DDV za jajčni liker bila 8.54. Nominalna sprememba cene je v tem primeru 0.14. Zahtevana oblika izpisa:
Ime			Sprememba
=========================
Jajčni liker	0.14

Napišite klic shranjene procedure.
Spremenite proceduro tako, da sprejme le spremembe DDV za največ ±10%. V primeru prevelike spremembe stopnje DDV, naj procedura v podatku Ime izpiše 'To bo revolucija', v podatku Sprememba pa NULL.
Z ustreznimi klici procedure testirajte preverjanje dovoljene meje za spremembo DDV.
*/
SET TERM !! ;
CREATE PROCEDURE DDV(n float, imeizdelka varchar(20))
RETURNS (ime varchar(20), sprememba varchar(5)) as
DECLARE VARIABLE cena float;
BEGIN 
    ime = imeizdelka;
    if(ABS(n)>10) THEN BEGIN
        ime = 'To bo revolucija';
        sprememba = NULL;
        SUSPEND;
    END ELSE BEGIN
        FOR SELECT cena FROM Izdelek
        WHERE ime_izdelka = :ime
        INTO :cena DO
        BEGIN
            sprememba = ROUND((:cena * (0.2+n)) - (:cena * 0.2),2);
            SUSPEND;
        END
    END 
END !!
SET TERM ; !!
/*
4.	naloga
Napišite shranjeno, ki izpiše razliko v ceni dveh izdelkov z upoštevanjem vrednosti DDV. Procedura vrne:
•	Prvi izdelek je drazji za nn.nn.
•	Drugi izdelek je drazji za nn.nn.
•	Ceni sta enaki.
Primer izvedbe shranjene procedure, če sta vhodna parametra 3 in 1.
PODATKI
==================================
Drugi izdelek je drazji za 0.43
Napišite klic shranjene procedure.
*/
SET TERM !! ;
CREATE PROCEDURE razlika(id1 int, id2 int)
RETURNS (podatki varchar(50)) as
DECLARE VARIABLE cena1 float;
DECLARE VARIABLE cena2 float DEFAULT -1;
BEGIN 
    FOR SELECT cena FROM Izdelek
    WHERE iid = :id1
    INTO :cena1 DO BEGIN END
    FOR SELECT cena FROM Izdelek
    WHERE iid = :id2
    INTO :cena2 DO BEGIN END

    cena1 = cena1 * 1.2;
    cena2 = cena2 * 1.2;
    if(cena1>cena2) THEN
        podatki = 'Prvi izdelek je drazji za ' || ROUND(cena1-cena2,2) || '.';
    else if(cena1<cena2) THEN
        podatki = 'Drugi izdelek je drazji za ' || ROUND(cena2-cena1,2) || '.';
    else if(cena1>cena2) THEN
        podatki = 'Ceni sta enaki.';
    SUSPEND; 
END !!
SET TERM ; !!