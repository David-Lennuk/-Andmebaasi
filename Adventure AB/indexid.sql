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
