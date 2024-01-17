/*1*/
CREATE DATABASE PB_JavnaUprava CHARACTER SET utf8;
USE PB_JavnaUprava;
/*2*/
CREATE TABLE Pokrajina(
    PokrajinaID int not null,
    ImePokrajine varchar(20) not null,
    PRIMARY KEY(PokrajinaID)
);
CREATE TABLE Kraj(
    KrajID int not null,
    PokrajinaID int not null,
    imeKraja varchar(30) not null,
    PRIMARY KEY(KrajID),
    FOREIGN KEY (PokrajinaID) REFERENCES Pokrajina(PokrajinaID)
);
/*3*/
ALTER TABLE Pokrajina ADD COLUMN Opis varchar(50);
/*4*/
ALTER TABLE Kraj ADD COLUMN SteviloPrebivalcev int CHECK(SteviloPrebivalcev>=0);
/*5*/
CREATE TABLE Obcan(
    EMSO varchar(13) not null,
    Ime varchar(20) not null,
    Priimek varchar(20) not null,
    DatumRojstva DATE not null,
    KrajID int not null,
    PRIMARY KEY(EMSO)
);
/*6*/
ALTER TABLE Obcan MODIFY COLUMN KrajID int;
ALTER TABLE Obcan ADD CONSTRAINT FK_Obcan_Kraj FOREIGN KEY(KrajID) REFERENCES Kraj(KrajID) ON DELETE SET NULL ON UPDATE CASCADE;
/*7*/
ALTER TABLE Obcan MODIFY COLUMN Ime varchar(20) AFTER Priimek;
/*8*/
ALTER TABLE Obcan ADD COLUMN Spol SET("M","Ž");
/*9*/
SHOW TABLES;
/*10*/
SHOW CREATE TABLE Pokrajina;
SHOW CREATE TABLE Kraj;
SHOW CREATE TABLE Obcan;
/*11*/
CREATE TABLE Obisk(
    EMSO varchar(13) not null,
    KrajID int not null,
    DatumObiska DATE not null CHECK(DatumObiska <= '2023-10-24'),
    Vtisi varchar(200) not null default 'vse naj',
    PRIMARY KEY(EMSO,KrajID,DatumObiska),
    FOREIGN KEY(EMSO) REFERENCES Obcan(EMSO),
    FOREIGN KEY(KrajID) REFERENCES Kraj(KrajID)
);
