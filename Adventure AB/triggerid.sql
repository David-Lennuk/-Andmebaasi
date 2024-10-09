--92 DDL trigger SQL
-- Loome esimesena triggere, mis käivitub, kui uus tabel luuakse
CREATE TRIGGER trMyFirstTrigger
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'New table created'
END

-- Loome testi tabeli
CREATE TABLE Test(Id int);

-- Muudame triggere, et see käivituks ka tabeli muutmisel ja kustutamisel
ALTER TRIGGER trMyFirstTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    PRINT 'A table has just been created, modified or deleted'
END

-- Kustutame testi tabeli
DROP TABLE Test;

-- Proovime muuta tabelit, mis on juba kustutatud
ALTER TABLE Test ADD Makaka int; -- See põhjustab vea, kuna tabelit ei eksisteeri

-- Muudame triggere, et see tagastaks teate ja tühistaks muudatused
ALTER TRIGGER trMyFirstTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    ROLLBACK -- Tühistame muudatused
    PRINT 'You cannot create, alter or drop a table'
END

-- Proovime jälle tabelit kustutada
DROP TABLE Test;

-- Loome uue tabeli Test2
CREATE TABLE Test2(Id int);

-- Proovime taas tabelit muuta
ALTER TABLE Test ADD Makaka2 int;

-- Deaktiveerime triggere
DISABLE TRIGGER trMyFirstTrigger ON DATABASE;

-- Kustutame triggere
DROP TRIGGER trMyFirstTrigger ON DATABASE;

-- Loome triggere, mis käivitub, kui tabelit nimetatakse ümber
CREATE TRIGGER trRenameTable
ON DATABASE
FOR RENAME
AS
BEGIN
    PRINT 'You just renamed something'
END

-- Muudame tabeli nime
sp_rename 'Test', 'NewTestTable';

--93 Server Scoped DDL triggerid
-- Loome andmebaasi ulatuses triggereid
CREATE TRIGGER tr_DatabaseScopeTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, alter or drop a table in the current database'
END

-- Keelame andmebaasi ulatuses trigger
DISABLE TRIGGER tr_DatabaseScopeTrigger ON DATABASE

-- Lubame andmebaasi ulatuses trigger
ENABLE TRIGGER tr_DatabaseScopeTrigger ON DATABASE

-- Proovime luua tabelit "test"
CREATE TABLE test(id int);

-- Loome serveri ulatuses triggereid
CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, alter or drop a table in any database on the server'
END

-- Keelame serveri ulatuses trigger
DISABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

-- Lubame serveri ulatuses trigger
ENABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

-- Kustutame serveri ulatuses trigger
DROP TRIGGER tr_ServerScopeTrigger ON ALL SERVER;
