/*1. Ustvarite PB TestnaBaza.fdb.*/
CREATE DATABASE "C:/temp/TestnaBaza.fdb";
/*2. Ustvarite tabelo Tab1(Tab1ID:N, dataA:N, dataB:N, dataC:N). Vsi atributi so[1-9] numeričnega tipa int.*/
CREATE TABLE Tab1(
    Tab1ID int primary key, 
    dataA int not null, 
    dataB int not null, 
    dataC int not null
);
/*3. Nato ustvarite še tabelo Tab2(Tab2ID:N, dataA:N, dataB:N, dataC:N). Vsi
atributi so ravno tako tipa int.*/
CREATE TABLE Tab2(
    Tab2ID int primary key, 
    dataA int not null, 
    dataB int not null, 
    dataC int not null
);
/*4. Poiščite pot do knjižnice ib_udf2.sql ter jo vključite v sejo.*/
IN "C:\Program Files\Firebird\Firebird_3_0\UDF/ib_udf2.sql";
/*5. Kopirajte kodo za kreiranje generatorja prvi, ki jo najdete na 3. strani teh navodil. Slednjo
potrebujete za implementacijo »auto incrementa« nad primarnim ključem Tab1ID.*/
CREATE GENERATOR prvi;
SET GENERATOR prvi to 1;
/*6. Kopirajte kodo shranjene izvršne procedure random_data1, ki jo najdete na 3. strani teh navodil.
Slednjo potrebujete zato, da boste lahko napolnili tabelo Tab1 z naključnimi števili. Pri tem
parameter randRange predstavlja zgornjo mejo naključnih števil (za vse tri atribute A, B in C),
parameter numOfRecords pa število zapisov, ki jih procedura doda v tabelo Tab1.*/
set term !!;
create procedure random_data1 (randRange int, numOfRecords int)
returns(line varchar(60)) as
declare variable i int;
declare variable a int;
declare variable b int;
declare variable c int;
begin
i=0;
while (i < numOfRecords) do
begin
a=cast ((rand()*(randRange-1)+1) as integer);
b=cast ((rand()*(randRange-1)+1) as integer);
c=cast ((rand()*(randRange-1)+1) as integer);
insert into Tab1 values (GEN_ID(prvi,1),:a, :b, :c);
i=i+1;
end
line=:numOfrecords || ' records were added to table Tab1';
end!!
set term ;!!
/*7. Vključite meritve in performančno statistiko s pomočjo stavkov (glejte drsnice 98_Indeksiranje, v
mapi teorija): set stat on; set plan on;*/
SET stat ON;
SET plan ON;
/*8. Vpišite 100.000 zapisov v tabelo Tab1, s pomočjo procedure random_data1, naključne vrednosti
atributov naj bodo iz intervala [1..2.000.000]. Sintaksa klica izvršne procedure pri tem je:
execute procedure ime_procedure (argument1, argument2, …
argumentN);*/
execute procedure random_data1(2000000,100000);
/*9. Ustvarite sekundarni indeks po atributu dataA, ter kopirajte kodo za kreiranje generatorja drugi,
ki jo najdete na 4. strani teh navodil. S pomočjo procedure random_data2 (ta je tudi na 4.strani),
napolnite še Tabelo Tab2, s 100.000 zapisi, z istim intervalom naključnih vrednost kot pod točko
8. Kakšna je razlika v porabi pomnilnika in kakšna je razlika v času izvrševanja obeh klicev
procedur in zakaj? V poročilo vaje zapišite klice obeh procedur ter statistiko meritev.*/
COMMIT;
CREATE INDEX IndexPoDataA ON Tab1(dataA);
CREATE GENERATOR drugi;
SET GENERATOR drugi to 1;
set term !!;
create procedure random_data2 (randRange int, numOfRecords int)
returns(line varchar(60)) as
declare variable i int;
declare variable a int;
declare variable b int;
declare variable c int;
begin
i=0;
while (i < numOfRecords) do
begin
a=cast ((rand()*(randRange-1)+1) as integer);
b=cast ((rand()*(randRange-1)+1) as integer);
c=cast ((rand()*(randRange-1)+1) as integer);
insert into Tab2 values (GEN_ID(drugi,1),:a, :b, :c);
i=i+1;
end
line=:numOfrecords || ' records were added to table Tab2';
end!!
set term ;!!
execute procedure random_data2(2000000,100000);
/*10. Dodajte sekundarni po atributu dataB, tabele Tab2 ter ponovno izvršite klica obeh procedur.
Tudi tokrat naj se oba klica izvršita za 100000 zapisov, interval naključnih števil naj bo enak
[1..2.000.000]. Kakšna je tokrat razlika v porabi pomnilnika in kakšna je razlika v času obeh klicev
procedur in zakaj? V poročilo vaje zapišite statistiko meritev.*/
COMMIT;
CREATE INDEX IndexPoDataB ON Tab2(dataB);
execute procedure random_data1(2000000,100000);
execute procedure random_data2(2000000,100000);
/*11. Dodajte še sekundarni po atributu dataC, tabele Tab2 ter ponovite postopek, opisan pod točko
10., tokrat za 200.000 zapisov. Kakšna je razlika v porabi pomnilnika in kakšna je razlika v času
obeh klicev procedur in zakaj? V poročilo vaje zapišite statistiko meritev.*/
CREATE INDEX IndexPoDataC ON Tab2(dataC);
execute procedure random_data1(2000000,200000);
execute procedure random_data2(2000000,200000);
/*12. Napišite SQL stavek, ki posodobi atributa dataB in dataC tako, da jima prišteje vrednost 5, v
kolikor so vrednosti atributa dataA manjše od 750.000. Stavek napišite za obe tabeli ter v
poročilo zapišite statistiko obeh meritev.*/
UPDATE Tab1 SET dataB = dataB + 5,
                dataC = dataC + 5
WHERE dataA<750000;
UPDATE Tab2 SET dataB = dataB + 5,
                dataC = dataC + 5
WHERE dataA<750000;
/*13. Napišite poizvedbo, ki bo vrnila vse podatke tistih zapisov, za katere velja, da sta atributa dataA
in dataB med 50.000 in 80.000. Poizvedbo izvršite nad obema tabelama. Kakšna je razlika v
porabi pomnilnika in kakšna je razlika v času izvedbe obe poizvedb? Zakaj? V poročilo vaje
zapišite statistiko meritev.*/
SELECT * FROM Tab1 
WHERE dataA BETWEEN 50000 AND 80000
    AND dataB BETWEEN 50000 AND 80000;
SELECT * FROM Tab2 
WHERE dataA BETWEEN 50000 AND 80000
    AND dataB BETWEEN 50000 AND 80000;
/*14. Napišite poizvedbo, ki bo vrnila vse podatke tistih zapisov, za katere velja, da vsi trije atributi (
dataA, dataB in dataC) večji od 50.000. pri čemer naj bo poizvedba urejena (naračajoče) najprej
po atributu dataA, nato po dataB in nato še po dataC. Poizvedbo izvršite nad obema tabelama.
Kakšna je razlika v porabi pomnilnika in kakšna je razlika v času izvedbe obe poizvedb in zakaj? V
poročilo vaje zapišite statistiko meritev.*/
SELECT * FROM Tab1
WHERE dataA > 50000
    AND dataB > 50000
    AND dataC > 50000
ORDER BY dataA,dataB,dataC; 
SELECT * FROM Tab2
WHERE dataA > 50000
    AND dataB > 50000
    AND dataC > 50000
ORDER BY dataA,dataB,dataC; 
/*15. Deaktivirajte indeks nad atributom dataA in ponovno pokličite poizvedbi pod točko 14. Kakšna je
sedaj razlika v času izvedbe? V poročilo vaje zapišite statistiko meritev.*/
ALTER INDEX IndexPoDataA INACTIVE;
SELECT * FROM Tab1
WHERE dataA > 50000
    AND dataB > 50000
    AND dataC > 50000
ORDER BY dataA,dataB,dataC; 
SELECT * FROM Tab2
WHERE dataA > 50000
    AND dataB > 50000
    AND dataC > 50000
ORDER BY dataA,dataB,dataC; 
/*16. Kakšna pa je razlika v hitrosti izvrševanja agregiranih funkcij? Napišite poizvedbo, ki bo vrnila
povprečno vrednost atributa dataB, za obe tabeli. Kakšna je razlika in zakaj? V poročilo vaje
zapišite statistiko meritev.*/
SELECT AVG(dataB) FROM Tab1;
SELECT AVG(dataB) FROM Tab2;
/*17. Podobno kot točka 16., le da rezultate funkcije AVG združite po lihih in sodih vrednostih atributa
Tab1ID in Tab2ID. Kakšna je sedaj razlika v času izvedbe? V poročilo vaje zapišite statistiko
meritev.*/
/*????*/
/*18. Napišite poizvedbo, ki izpiše vse podatke zapisov tabele Tab1, za katere velja, da je vrednost
atributa dataA med 9990 in 9999 (zaprti interval [9990..9999]). Poizvedbo implementirajte
najprej s pomočjo operatorja between in nato še z operatorjem IN. Kakšna je sedaj razlika v času
izvajanja? Od kje sedaj razlika, če tabela Tab1 sploh ni indeksirana? */
SELECT * FROM Tab1
WHERE dataA BETWEEN 9990 AND 9999;
SELECT * FROM Tab2
WHERE dataA BETWEEN 9990 AND 9999;
SELECT * FROM Tab1
WHERE dataA IN (9990, 9991, 9992, 9993, 9994, 9995, 9996, 9997, 9998, 9999);
SELECT * FROM Tab2
WHERE dataA IN (9990, 9991, 9992, 9993, 9994, 9995, 9996, 9997, 9998, 9999);

/*STATISTIKA*/
/*9*/
/*ni razlike*/
/*LINE
============================================================
100000 records were added to table Tab1

Current memory = 20749280
Delta memory = 103184
Max memory = 20839680
Elapsed time= 0.850 sec
Buffers = 2048
Reads = 0
Writes = 183
Fetches = 604997*/
/*LINE
============================================================
100000 records were added to table Tab2

Current memory = 20963776
Delta memory = -960
Max memory = 25829856
Elapsed time= 0.775 sec
Buffers = 2048
Reads = 0
Writes = 183
Fetches = 604984*/

/*10*/
/*
LINE
============================================================
100000 records were added to table Tab1

Current memory = 20962256
Delta memory = 7136
Max memory = 25861520
Elapsed time= 1.424 sec
Buffers = 2048
Reads = 0
Writes = 610
Fetches = 905484
LINE
============================================================
100000 records were added to table Tab2

Current memory = 21023200
Delta memory = 60944
Max memory = 25861520
Elapsed time= 1.576 sec
Buffers = 2048
Reads = 72
Writes = 725
Fetches = 905483*/

/*11*/
/*
LINE
============================================================
200000 records were added to table Tab1

Current memory = 21083824
Delta memory = 7424
Max memory = 35710608
Elapsed time= 2.939 sec
Buffers = 2048
Reads = 213
Writes = 1280
Fetches = 1810817
LINE
============================================================
200000 records were added to table Tab2

Current memory = 21085792
Delta memory = 1968
Max memory = 35710608
Elapsed time= 5.018 sec
Buffers = 2048
Reads = 349
Writes = 4272
Fetches = 2411965*/

/*12*/
/*
PLAN (TAB1 INDEX (INDEXPODATAA))
Current memory = 19632304
Delta memory = 500512
Max memory = 19800352
Elapsed time= 0.893 sec
Buffers = 2048
Reads = 3218
Writes = 1107
Fetches = 1054753
PLAN (TAB2 NATURAL)
Current memory = 19473872
Delta memory = -158432
Max memory = 19800352
Elapsed time= 3.470 sec
Buffers = 2048
Reads = 3913
Writes = 4784
Fetches = 2219856
*/

/*13*/
/*
Current memory = 19580480
Delta memory = 120800
Max memory = 19800352
Elapsed time= 0.843 sec
Buffers = 2048
Reads = 2584
Writes = 1915
Fetches = 8476

Current memory = 19583952
Delta memory = 124240
Max memory = 19800352
Elapsed time= 0.041 sec
Buffers = 2048
Reads = 2658
Writes = 0
Fetches = 8601
*/

/*14*/
/*
Current memory = 19709856
Delta memory = 125904
Max memory = 48025488
Elapsed time= 57.464 sec
Buffers = 2048
Reads = 3453
Writes = 0
Fetches = 393446


Current memory = 19937456
Delta memory = 227600
Max memory = 48253088
Elapsed time= 57.265 sec
Buffers = 2048
Reads = 4113
Writes = 0
Fetches = 384553
*/

/*15*/
/*
Current memory = 19547424
Delta memory = 15600
Max memory = 48253088
Elapsed time= 56.761 sec
Buffers = 2048
Reads = 3033
Writes = 0

Current memory = 20004432
Delta memory = 457008
Max memory = 48320064
Elapsed time= 57.347 sec
Buffers = 2048
Reads = 4113
Writes = 0
Fetches = 384553
*/

/*16*/
/*
Current memory = 19541312
Delta memory = -463120
Max memory = 48320064
Elapsed time= 0.182 sec
Buffers = 2048
Reads = 3033
Writes = 0
Fetches = 412128

Current memory = 19541312
Delta memory = 14176
Max memory = 48320064
Elapsed time= 0.174 sec
Buffers = 2048
Reads = 3031
Writes = 0
Fetches = 412128

/*18*/
/*
Current memory = 19545120
Delta memory = 3808
Max memory = 48320064
Elapsed time= 0.196 sec
Buffers = 2048
Reads = 3034
Writes = 0
Fetches = 412129

Current memory = 19545120
Delta memory = 17984
Max memory = 48320064
Elapsed time= 0.200 sec
Buffers = 2048
Reads = 3034
Writes = 0
Fetches = 412129


Current memory = 19549968
Delta memory = 4848
Max memory = 48320064
Elapsed time= 0.326 sec
Buffers = 2048
Reads = 3034
Writes = 0
Fetches = 412129

Current memory = 19549968
Delta memory = 0
Max memory = 48320064
Elapsed time= 0.324 sec
Buffers = 2048
Reads = 3034
Writes = 0
Fetches = 412129
*/