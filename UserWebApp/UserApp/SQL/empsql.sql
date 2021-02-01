CREATE TABLE employee(
empid INT IDENTITY(1,1) PRIMARY KEY,
empname varchar(255),
empage int,
empsex varchar(20)
);

IF OBJECT_ID('emp_Insert') IS NOT NULL
BEGIN 
DROP PROC emp_Insert 
END
GO
CREATE PROCEDURE emp_Insert
@empname VARCHAR(25),
@empage INT,
@empsex VARCHAR(25),
@empid int OUTPUT
	 
AS
BEGIN
INSERT INTO employee(
	   empname ,
	   empage,
	   empsex)
	   
    VALUES (
	   @empname,
	   @empage,
	   @empsex)
	   
 
SET @empid = SCOPE_IDENTITY()
 
END

IF OBJECT_ID('emp_Update') IS NOT NULL
BEGIN 
DROP PROC emp_Update 
END
GO
CREATE PROCEDURE emp_Update
@empname VARCHAR(25),
@empage INT,
@empsex VARCHAR(25),
@empid int 
AS
BEGIN

 
UPDATE employee SET 
	empname = @empname,
	empage = @empage,
	empsex=@empsex
	FROM employee
	WHERE empid = @empid
 
END

GO
IF OBJECT_ID('emp_Delete') IS NOT NULL
BEGIN 
DROP PROC emp_Delete 
END
GO
CREATE PROCEDURE emp_Delete	 
	   @empid int 	 
AS
BEGIN

 
DELETE 	FROM employee
	WHERE empid = @empid
 
END

GO


IF OBJECT_ID('emp_Get') IS NOT NULL
BEGIN 
DROP PROC emp_Get 
END
GO
CREATE PROCEDURE emp_Get	 
	   @empid int 	 
AS
BEGIN

 
SELECT * 	FROM employee
	WHERE empid= @empid
 
END
GO

IF OBJECT_ID('emp_GetAll') IS NOT NULL
BEGIN 
DROP PROC emp_GetAll 
END
GO
CREATE PROCEDURE emp_GetAll	 
	   
AS
BEGIN

 
SELECT * 	FROM employee
ORDER BY empid desc;
	
 
END
GO
GO

declare @id int
EXECUTE emp_Insert 'harish', 9, 'M',@empid=@id Output
select @id
declare @id int
Execute emp_Insert 'siva',36,'M',@empid=@id Output
select @id

declare @id int
Execute emp_Insert 'Ram',10,'M',@empid=@id Output
select @id
GO
EXECUTE emp_Update 'Ramkumar', 35, 'M',4

GO

EXECUTE emp_Get 4

go

EXECUTE emp_GetAll
