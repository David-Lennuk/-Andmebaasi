--32. Mitme avaldisega tabeliväärtusega funktsioonid

--Tabelisiseväärtusega funktsioon e Inline Table Valued function (ILTVF) koodinäide:
Create Function fn_ILTVF_GetEmloyees()
Returns Table 
as
Return (Select EmployeeKey, FirstName, Cast(BirthDate as Date) as DOB
	From DimEmployee)

	--Mitme avaldisega tabeliväärtusega funktsioonid e multi-statement table valued function (MSTVF):
	Create Function fn_MSTVF_GetEmployees()
Returns @Table Table (EmpLoyeeKey int, FirstNmae nvarchar(20), DOB Date)
as
Begin
insert into @Table
Select EmployeeKey, FirstName, Cast(BirthDate as Date)
From DimEmployee

Return
End

--Kui nüüd soovid mõlemat funktsiooni esile kutsuda, siis kasutad koodi:
Select * from fn_ILTVF_GetEmloyees()
Select * from fn_MSTVF_GetEmployees()

--Uuendame allasuvat tabelit ja kasutame selleks ILTVF funktsiooni.
update fn_ILTVF_GetEmloyees()set FirstName='Sam1' Where EmployeeKey=1
select * from fn_ILTVF_GetEmloyees()

--ILTVF parema jõudluse põhjus on see, et SQL Server käsitleb seda, kui view-d ja MSTVF stored procedureina.

--33. Funktsiooniga seotud tähtsad kontseptsioonid

--Skaleeritav funktsioon ilma krüpteerimata:
Create Function fn_GetEmpoyeeNameById(@Id int)

Returns nvarchar(20)
as
Begin
return (Select FirstName From DimEmployee Where EmployeeKey =@Id)
END

--Nüüd muudame funktsiooni ja krüpteerime selle ära:
Alter Function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
With Encryption
as
Begin
return (Select FirstName from DimEmployee where EmployeeKey = @Id)
END

--Loome funktsiooni WITH SCHEMABINDING valikuga:
Alter function fn_GetEmpoyeeNameById(@Id int)
Returns nvarchar(20)
With SchemaBinding
as
begin
Return (Select FirstName from DimEmployee where EmployeeKey = @Id)
END


--34. Ajutised tabelid

--Kuidas luua Local Temporary tabelit:
Create Table #PersonDetails(Id int, Name nvarchar(20))
Sisesta andmed ajutisse tabelisse:

Create Table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails Values(1, 'Mike')
insert into #PersonDetails Values(2, 'John')
insert into #PersonDetails Values(3, 'Tood')

select * from #PersonDetails

--Vaata tabeli sisu ajutise tabeli abil:
Select * from #PersonDetails

Select name from tempdb..sysobjects
where name like '#PersonDetails%'

--ooooooooooooooooooooooo
Create Procedure spCreateLocalTempTable
as
Begin
Create Table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails Values(1, 'Mike')
insert into #PersonDetails Values(2, 'John')
insert into #PersonDetails Values(3, 'Tood')

Select * from #PersonDetails
End

--Kuidas luua globaalset ajutist tabelit:
Create Table ##EmployeeDetails(Id int, Nmae nvarchar(20))

insert into ##EmployeeDetails Values(1, 'Den')
insert into ##EmployeeDetails Values(2, 'Anton')
insert into ##EmployeeDetails Values(3, 'Kiril')

select * from ##EmployeeDetails

Select name from tempdb..sysobjects
where name like '##EmployeeDetails%'
