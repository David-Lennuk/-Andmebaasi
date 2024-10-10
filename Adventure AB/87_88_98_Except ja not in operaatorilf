--98 Where ja Having erinevused.rtf 

--Loome tabeli Sales ja sisestame andmed
CREATE TABLE Sales (
    Product NVARCHAR(50),
    SaleAmount INT
);
GO 

INSERT INTO Sales (Product, SaleAmount)
VALUES 
    ('iPhone', 500),
    ('Laptop', 800),
    ('iPhone', 1000),
    ('Speakers', 400),
    ('Laptop', 600);
GO

select * from Sales
--Selleks, et arvutada kogu müüki toote pealt, siis peame kirjutama GROUP BY päringu:
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product

--Kui soovime ainult neid tooteid, kus müük kokku on suurem kui 1000€, siis kasutame filtreerimaks tooteid HAVING tingimust.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product
HAVING SUM(SaleAmount) > 1000

--Kui kasutame WHERE klasulit HAVING-u asemel, siis saame süntaksivea. Põhjuseks on WHERE-i mitte töötamine kokku arvutava funktsiooniga, mis sisaldab SUM, MIN, MAX, AVG jne.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product
WHERE SUM(SaleAmount) > 1000

--Kalkuleeri iPhone-i ja Speakerite müüki ja kasuta selleks HAVING klauslit. See näide pärib kõik read Sales tabelis, mis näitavad summat ning eemaldavad kõik tooted peale iPhone-i ja Speakerite.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
WHERE Product in ('iPhone','Speakers')
GROUP BY Product

--Kalkuleeri iPhone-i ja Speakerite müüki ja kasutad selleks HAVING klauslit. See näide pärib kõik read Sales tabelis, mis näitavad summat ning eemaldavad kõik tooted peale iPhone-i ja Speakerite
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product
HAVING Product in ('iPhone','Speakers')


--87. Except operaator.rtf 
--Loome ja sisestame andmed
CREATE TABLE TableA (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10)
);
GO

INSERT INTO TableA (Id, Name, Gender)
VALUES
(1, 'Mark', 'Male'),
(2, 'Mary', 'Female'),
(3, 'Steve', 'Male'),
(4, 'John', 'Male'),
(5, 'Sara', 'Female');
GO

CREATE TABLE TableB (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10)
);
GO

INSERT INTO TableB (Id, Name, Gender)
VALUES
(4, 'John', 'Male'),
(5, 'Sara', 'Female'),
(6, 'Pam', 'Female'),
(7, 'Rebeka', 'Female'),
(8, 'Jordan', 'Male');
GO

SELECT * FROM TableA;
SELECT * FROM TableB;

--Pane tähele, et järgnev rida tagastab unikaalse ridade arvu vasakust tabelist, mida ei ole paremas tabelis.
Select Id,Name,Gender
From TableA
Except
Select Id,Name,Gender
From TableB


--Loome ja sisestame andmed
Create table tblEmployees(
Id int identity primary key,
Name nvarchar(100),
Gender nvarchar(10),
Salary int)
Go
Insert into tblEmployees values ('Mark', 'Male', 52000)
Insert into tblEmployees values ('Mary', 'Female', 55000)
Insert into tblEmployees values ('Steve', 'Male', 45000)
Insert into tblEmployees values ('John', 'Male', 40000)
Insert into tblEmployees values ('Sara', 'Female', 48000)
Insert into tblEmployees values ('Pam', 'Female', 60000)
Insert into tblEmployees values ('Tom', 'Male', 58000)
Insert into tblEmployees values ('Georg', 'Male', 65000)
Insert into tblEmployees values ('Tina', 'Female', 67000)
Insert into tblEmployees values ('Ben', 'Male', 80000)
Go

Select * from tblEmployees

--Order by nõuet võib kasutada ainult kord peale paremat päringut:
SELECT Id, Name, Gender, Salary
FROM tblEmployees 
WHERE Salary >= 50000
Except 
SELECT Id, Name, Gender, Salary
FROM tblEmployees
WHERE Salary >= 60000
order by Name

--88. Erinevus Except ja not in operaatoril
-- Järgnev päring tagastab read vasakust päringust, mis ei ole paremas tabelis 
Select Id, Name, Gender FROM TableA
Except 
Select Id, Name, Gender From TableB

-- Sama tulemuse võib saavutada NOT IN operaatoriga
SELECT Id, Name, Gender FROM TableA
WHERE Id NOT IN (Select Id From TableB)

-- Sisesta järgnev rida tabelisse TableA
Insert Into TableA values (1, 'Mark', 'Male')

-- Nüüd käivita järgnev EXCEPT päring

SELECT Id, Name, Gender FROM TableA
EXCEPT 
SELECT Id,Name,Gender From TableB

-- Nüüd käivita NOT IN operaatoriga kood
Select Id, Name, Gender From TableA
Where Id NOT IN (Select Id from TableB)

-- Järgnevas päringus on meelega veergude arv erinev
SELECT Id, Name, Gender From TableA
EXCEPT
Select Id, Name from TableB

-- Järgnevas päringus alampäring tagastab mitu veergu
Select Id, Name ,Gender From TableA
Where Id NOT IN (Select Id, Name from TableB)
