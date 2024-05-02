CREATE EXCEPTION praznasmer 'Vhodni podatek za smer je neveljaven'; 
SET TERM !! ;
CREATE PROCEDURE dodaj_polet(P_ID int, L_ID int, datum date, smer varchar(25)) 
RETURNS (Niz char(100)) AS
DECLARE VARIABLE x int DEFAULT -1;
begin
    Niz = 'vstavljanje uspelo';
    BEGIN
        IF(smer = '') THEN
            EXCEPTION praznasmer;
        SELECT P_ID FROM Pilot WHERE P_ID = :P_ID INTO :x;
        IF(:x !=-1 ) THEN
            INSERT INTO Polet VALUES(:P_ID, :L_ID, :datum, :smer, RAND()*380+120);
        ELSE 
        BEGIN 
            SELECT MAX(P_ID) FROM Pilot INTO :x;
            INSERT INTO Polet VALUES(:x, :L_ID, :datum, :smer, RAND()*380+120);
            Niz = 'Iščem ustrezen ID pilota...';
        END 
        WHEN EXCEPTION praznasmer DO
            Niz = 'Dodajanje NI USPELO - Vhodni podatek za smer je neveljaven';
    END
    WHEN ANY DO
        Niz = 'Dodajanje NI USPELO - drugi razlogi';
END !!
SET TERM ; !!





CREATE EXCEPTION prepovedan_dvig_place 'Plačilo se lahko le poveča največ za 3%'; 
SET TERM !! ;
CREATE TRIGGER poslovno_pravilo FOR Polet
BEFORE UPDATE AS
DECLARE VARIABLE x int;
BEGIN
    SELECT COUNT(P_ID) FROM Polet WHERE P_ID = :NEW.P_ID INTO :x;
    IF(OLD.Placa * 1.03 < NEW.Placa OR x < 10)THEN
        EXCEPTION prepovedan_dvig_place;
    INSERT INTO Log VALUES('Polet', CURRENT_USER, CURRENT_DATE, CURRENT_TIME, 'posodabljanje - place', OLD.placa, NEW.placa);
END!!
SET TERM ; !! 


/* naloga brez razširitve
SET TERM !! ;
CREATE PROCEDURE selectPil(letalo varchar(20))
RETURNS (vrstica varchar(100)) AS
DECLARE VARIABLE i int DEFAULT 1;
DECLARE VARIABLE smer varchar(20);
DECLARE VARIABLE pri varchar(20);
DECLARE VARIABLE mesec int;
DECLARE VARIABLE dan int;
BEGIN
    FOR SELECT Priimek, smer, EXTRACT(MONTH FROM Datum), EXTRACT(DAY FROM Datum) FROM pilot JOIN polet ON polet.P_id = pilot.p_id JOIN letalo ON letalo.L_ID=polet.l_id WHERE imeletala = :letalo INTO :pri, :smer, :mesec, :dan DO
    BEGIN
        vrstica = :i || '. ' || :pri || ': ' || :smer || ' - ' || :dan || '. ' ||:mesec || '., ' ||letalo;
        SUSPEND;
        :i = :i+1;
    END
END !!
SET TERM ; !!
*/


SET TERM !! ;
CREATE PROCEDURE selectPil(letalo varchar(20))
RETURNS (vrstica varchar(100)) AS
DECLARE VARIABLE i int DEFAULT 1;
DECLARE VARIABLE smer varchar(20);
DECLARE VARIABLE pri varchar(20);
DECLARE VARIABLE mesec int;
DECLARE VARIABLE dan int;
BEGIN
    FOR SELECT Priimek, smer, EXTRACT(MONTH FROM Datum), EXTRACT(DAY FROM Datum) FROM pilot JOIN polet ON polet.P_id = pilot.p_id JOIN letalo ON letalo.L_ID=polet.l_id
    WHERE pilot.P_ID IN (SELECT P_ID FROM polet JOIN letalo ON letalo.L_ID=polet.L_ID WHERE imeletala='pilatus') AND pilot.P_ID NOT IN(
        SELECT P_ID FROM polet JOIN letalo ON letalo.L_ID=polet.L_ID WHERE imeletala<>'pilatus'
    )
     INTO :pri, :smer, :mesec, :dan DO
    BEGIN
        vrstica = :i || '. ' || :pri || ': ' || :smer || ' - ' || :dan || '. ' ||:mesec || '., ' ||letalo;
        SUSPEND;
        :i = :i+1;
    END
END !!
SET TERM ; !!

