--35. Ineksid serveris

--Indeks
Select * from DimEmployee where BaseRate > 50 and BaseRate < 70

--Loome indeksi Salary veerule.
create index IX_DimEmployee_BaseRate
on DimEmployee (BaseRate ASC)

--Kui soovid vaadata Indeksit:
Execute sp_helptext DimEmployee

--Kui soovid kustutada indeksit:
Drop index DimEmployee.IX_DimEmployee_BaseRate

--36. Klastreeritud ja mitte-klastreeritud indeksid

--mis näitab uniklaaset klastreeritud indeksi loomist Id veerus.
execute sp_helpindex DimEmployee

--Vaatame DimEmployee
Select * from DimEmployee

--Selle tulemusel SQL server ei luba luua rohkem, kui ühte klastreeritud indeksit tabeli kohta. Järgnev skript annab veateate
Create Clustered Index IX_DimEmpoyee_Name
on DimEmployee(FirstName)

--Nüüd loome klastreeritud indeksi kahe veeruga. Selleks peame enne kustutama praeguse klastreeritud indeksi Id veerus:
Drop index DimEmployee

--Nüüd käivita järgnev kood uue klastreeritud ühendindeksi loomiseks Gender ja Salary veeru põhjal
CREATE CLUSTERED INDEX IX_DimEmployee_Gender_Salary
ON DimEmployee(Gender DESC, BaseRate ASC);

--Järgnev kood loob SQL-s mitte-klastreeritud indeksi Name veeru järgi DimEmployee tabelis
Create NonClustered Index IX_DimEmployee_Name
On DimEmployee (FirstName)

--37.Unikaalne ja mitte-unikaalne Index

CREATE TABLE DimEmploye (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BaseRate DECIMAL(10, 2) NOT NULL,
    Gender CHAR(1) NOT NULL
);

-- Kuvame indeksite teavet DimEmployee tabeli kohta
EXEC sp_helpIndex DimEmploye

-- Lisame uusi töötajaid DimEmployee tabelisse
INSERT INTO DimEmploye (FirstName, LastName, BaseRate, Gender)
VALUES ('Mike', 'Sandoz', 4500, 'M')
INSERT INTO DimEmploye (FirstName, LastName, BaseRate, Gender)
VALUES ('John', 'Menco', 2500, 'M')

-- Kuvame kõik töötajad DimEmployee tabelist
SELECT * FROM DimEmploye

-- Loome ainulaadse mitteklasterdatud indeksi FirstName ja LastName jaoks
CREATE UNIQUE NONCLUSTERED INDEX UIX_DimEmployee_FirstName_LastName
ON DimEmploye (FirstName, LastName)

-- Lisame tabelisse ainulaadse piirangu EmployeeNationalIDAlternateKey jaoks
ALTER TABLE DimEmploye 
ADD CONSTRAINT UQ_DimEmploye_EmployeNationalID
UNIQUE NONCLUSTERED (EmployeeNationalIDAlternateKey);

-- Kuvame piirangute teabe DimEmployee tabeli kohta
EXECUTE SP_HELPCONSTRAINT DimEmploye

-- Kuvame kõik veerud DimEmployee tabelis
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimEmployee';

-- Loome ainulaadse indeksi EmployeeNationalIDAlternateKey jaoks
CREATE UNIQUE INDEX IX_DimEmployee_City
ON DimEmployee (EmployeeNationalIDAlternateKey)
WITH IGNORE_DUP_KEY

--38 Indeksi plussid ja miinused

-- Loome mitteklasterdatud indeksi BaseRate jaoks:
CREATE NONCLUSTERED INDEX IX_DimEmployee_BaseRate
ON DimEmployee (BaseRate ASC)

-- Kuvame töötajad, kelle BaseRate on vahemikus 4000 kuni 8000:
SELECT * FROM DimEmployee WHERE BaseRate > 4000 AND BaseRate < 8000

-- Kustutame töötaja, kelle BaseRate on 2500:
DELETE FROM DimEmployee WHERE BaseRate = 2500

-- Uuendame töötaja BaseRate väärtust 7500-lt 9000-le:
UPDATE DimEmployee SET BaseRate = 9000 WHERE BaseRate = 7500

-- Kuvame kõik töötajad, sorteerituna BaseRate järgi kasvavas järjekorras:
SELECT * FROM DimEmployee ORDER BY BaseRate

-- Kuvame kõik töötajad, sorteerituna BaseRate järgi kahanevas järjekorras:
SELECT * FROM DimEmployee ORDER BY BaseRate DESC

-- Kuvame BaseRate ja nende arvu DimEmployee tabelis:
SELECT BaseRate, COUNT(BaseRate) AS Total
FROM DimEmployee
GROUP BY BaseRate
