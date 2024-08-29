create database autorentDavidLennuk;
use autorentDavidLennuk;
------------------------------------------------------------------------------------
--tabelite loomine
CREATE TABLE auto(
autoID int not null Primary key IDENTITY(1,1),
regNumber char(6) UNIQUE,
markID int,
varv varchar(20),
v_aasta int,
kaigukastID int,
km decimal(6,2)
);
SELECT * FROM auto

CREATE TABLE mark(
markID int not null Primary key IDENTITY(1,1),
autoMark varchar(30) UNIQUE
);

INSERT INTO mark(autoMark)
VALUES ('Ziguli');
INSERT INTO mark(autoMark)
VALUES ('Lambordzini');
INSERT INTO mark(autoMark)
VALUES ('BMW');
SELECT * FROM mark;

CREATE TABLE kaigukast(
kaigukastID int not null Primary key IDENTITY(1,1),
kaigukast varchar(30) UNIQUE
);
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat');
INSERT INTO kaigukast(kaigukast)
VALUES ('Manual');
SELECT * FROM kaigukast;

ALTER TABLE auto
ADD FOREIGN KEY (markID) REFERENCES mark(markID);
ALTER TABLE auto
ADD FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID);

CREATE TABLE klient(
klientiID int not null Primary key IDENTITY(1,1),
kliendiNimi varchar(50),
telefon varchar(20),
aadress varchar(50),
soiduKogemus varchar(30)
);

CREATE TABLE amet(
ametiID int not null Primary key IDENTITY(1,1),
markID int,
ametiNimi varchar(50),
FOREIGN KEY (markID) REFERENCES mark(markID));

CREATE TABLE tootaja(
tootajaID int not null Primary key IDENTITY(1,1),
tootajanimi varchar(50),
ametiID int,
FOREIGN KEY (ametiID) REFERENCES amet(ametiID)
);

CREATE TABLE rendiLeping(
lepingID int not null Primary key IDENTITY(1,1),
rendiAlgus date,
rendiLopp date,
klientiID int,
regNumber char(6),
rendiKestvus int,
hindKokku decimal(5,2),
tootajaID int,
FOREIGN KEY (klientiID) REFERENCES klient(klientiID),
FOREIGN KEY (regNumber) REFERENCES auto(regNumber),
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID)
);

----------------------------------------------------------------------------------------------
--Ülesanne:
SELECT * 
FROM auto, mark, kaigukast 
WHERE mark.markID = auto.markID 
AND kaigukast.kaigukastID = auto.kaigukastID;

SELECT * FROM auto 
INNER JOIN mark ON mark.markID = auto.markID 
INNER JOIN kaigukast ON kaigukast.kaigukastID = auto.kaigukastID;

SELECT auto.regNumber, auto.varv, auto.v_aasta, kaigukast.kaigukast 
FROM auto 
INNER JOIN kaigukast ON auto.kaigukastID = kaigukast.kaigukastID;

SELECT auto.regNumber, auto.varv, auto.v_aasta, mark.autoMark 
FROM auto 
INNER JOIN mark ON auto.markID = mark.markID;

SELECT auto.regNumber, auto.varv, auto.v_aasta, tootaja.tootajanimi 
FROM rendiLeping 
INNER JOIN auto ON rendiLeping.regNumber = auto.regNumber 
INNER JOIN tootaja ON rendiLeping.tootajaID = tootaja.tootajaID;

SELECT COUNT(*) AS total_cars, SUM(hindKokku) AS total_sum 
FROM rendiLeping;

SELECT klient.kliendiNimi, auto.regNumber, auto.varv, auto.v_aasta 
FROM rendiLeping 
INNER JOIN klient ON rendiLeping.klientiID = klient.klientiID 
INNER JOIN auto ON rendiLeping.regNumber = auto.regNumber;
----------------------------------------------------------------------------------------------------
--Kasutajate loomine:
--Kontrollimise ajal ei saanud töötaja tabelit täita
CREATE TABLE test(
number int);

DROP TABLE test; 

---------------------------------------------------------------------------------------
--tabelite täitmine
INSERT INTO auto (regNumber, markID, varv, v_aasta, kaigukastID, km)
VALUES 
('ABC123', 1, 'Red', 2015, 1, 5000.00),
('DEF456', 2, 'Blue', 2018, 2, 3000.50),
('GHI789', 3, 'Black', 2020, 1, 1500.75), 
('JKL012', 1, 'White', 2019, 2, 2500.20), 
('MNO345', 2, 'Grey', 2017, 1, 6000.10); 

INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus)
VALUES 
('Juhan Juurikas', '555-1234', 'Tartu mnt 1', '5 aastat'),
('Mari Maasikas', '555-5678', 'Narva mnt 5', '3 aastat'),
('Peeter Pirn', '555-8765', 'Viru tn 10', '7 aastat');

INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus)
VALUES 
('Juhan Juurikas', '555-1234', 'Tartu mnt 1', '5 aastat'),
('Mari Maasikas', '555-5678', 'Narva mnt 5', '3 aastat'),
('Peeter Pirn', '555-8765', 'Viru tn 10', '7 aastat');

INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus)
VALUES 
('Juhan Juurikas', '555-1234', 'Tartu mnt 1', '5 aastat'),
('Mari Maasikas', '555-5678', 'Narva mnt 5', '3 aastat'),
('Peeter Pirn', '555-8765', 'Viru tn 10', '7 aastat');

INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus)
VALUES 
('Juhan Juurikas', '555-1234', 'Tartu mnt 1', '5 aastat'),
('Mari Maasikas', '555-5678', 'Narva mnt 5', '3 aastat'),
('Peeter Pirn', '555-8765', 'Viru tn 10', '7 aastat');

INSERT INTO amet (markID, ametiNimi)
VALUES 
(1, 'Müügijuht'),
(2, 'Teenindusjuht'),
(3, 'Tehniline juht');

INSERT INTO tootaja (tootajanimi, ametiID)
VALUES 
('Kalev Kask', 1),
('Linda Lepik', 2),
('Siim Saag', 3);

INSERT INTO rendiLeping (rendiAlgus, rendiLopp, klientiID, regNumber, rendiKestvus, hindKokku, tootajaID)
VALUES 
('2024-01-01', '2024-01-10', 1, 'ABC123', 10, 500.00, 1),
('2024-02-15', '2024-02-20', 2, 'DEF456', 5, 1000.00, 2),
('2024-03-05', '2024-03-15', 3, 'GHI789', 10, 1500.00, 3);

SELECT * 
FROM auto 
INNER JOIN mark ON mark.markID = auto.markID 
INNER JOIN kaigukast ON kaigukast.kaigukastID = auto.kaigukastID;
----------------------------------------------------------------------------------------------------------
--1. Kirje tabelisse lisamise protseduur
CREATE PROCEDURE LisaRendiLeping
    @p_rendiAlgus DATE,
    @p_rendiLopp DATE,
    @p_klientiID INT,
    @p_regNumber CHAR(6),
    @p_rendiKestvus INT,
    @p_hindKokku DECIMAL(5, 2),
    @p_tootajaID INT
AS
BEGIN
    INSERT INTO rendiLeping (rendiAlgus, rendiLopp, klientiID, regNumber, rendiKestvus, hindKokku, tootajaID)
    VALUES (@p_rendiAlgus, @p_rendiLopp, @p_klientiID, @p_regNumber, @p_rendiKestvus, @p_hindKokku, @p_tootajaID);
END;
--2. Kirje tabelist kustutamise protseduur
CREATE PROCEDURE KustutaRendiLeping
    @p_lepingID INT
AS
BEGIN
    DELETE FROM rendiLeping 
    WHERE lepingID = @p_lepingID;
END;
--3. Täiendav kord rendi lõppkuupäeva uuendamiseks
CREATE PROCEDURE UuendaRendiLopp
    @p_lepingID INT,
    @p_newRendiLopp DATE
AS
BEGIN
    UPDATE rendiLeping
    SET rendiLopp = @p_newRendiLopp
    WHERE lepingID = @p_lepingID;
END;
