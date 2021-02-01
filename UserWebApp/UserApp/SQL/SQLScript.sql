CREATE TABLE Users (
    Userid int IDENTITY(1,1) PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
	Sex varchar(10)
);

GO

IF OBJECT_ID('Users_Insert') IS NOT NULL
BEGIN 
DROP PROC Users_Insert 
END
GO
CREATE PROCEDURE Users_Insert
	   @LastName varchar(20),
	   @FirstName varchar(20),
	   @Age int,
	   @Sex varchar(10),
	   @UserID int Output
	 
AS
BEGIN
INSERT INTO Users  (
	   FirstName,
	   LastName,
	   Age,
	   Sex)
    VALUES (
	   @FirstName,
	   @LastName,
	   @Age,
	   @Sex)
 
SET @UserID = SCOPE_IDENTITY()
 
END

GO

IF OBJECT_ID('Users_Update') IS NOT NULL
BEGIN 
DROP PROC Users_Update 
END
GO
CREATE PROCEDURE Users_Update
	   @LastName varchar(20),
	   @FirstName varchar(20),
	   @Age int,
	   @Sex varchar(10),
	   @UserID int 
	 
AS
BEGIN

 
UPDATE Users SET 
	FirstName = @FirstName,
	LastName = @LastName,
	Age=@Age,
	Sex=@Sex
	FROM Users
	WHERE UserID = @UserID
 
END

GO

IF OBJECT_ID('Users_Delete') IS NOT NULL
BEGIN 
DROP PROC Users_Delete 
END
GO
CREATE PROCEDURE Users_Delete	 
	   @UserID int 	 
AS
BEGIN

 
DELETE 	FROM Users
	WHERE UserID = @UserID
 
END

GO


IF OBJECT_ID('Users_Get') IS NOT NULL
BEGIN 
DROP PROC Users_Get 
END
GO
CREATE PROCEDURE Users_Get	 
	   @UserID int 	 
AS
BEGIN

 
SELECT * 	FROM Users
	WHERE UserID = @UserID
 
END
GO

IF OBJECT_ID('Users_GetAll') IS NOT NULL
BEGIN 
DROP PROC Users_GetAll 
END
GO
CREATE PROCEDURE Users_GetAll	 
	   
AS
BEGIN

 
SELECT * 	FROM Users
	
 
END
GO
GO

declare @id int
EXECUTE Users_Insert 'priya2','kumar', 29, 'F',@userid=@id Output
select @id

GO
EXECUTE Users_Update 'priya','kumar', 29, 'F',1

GO

EXECUTE Users_Get 2

go

EXECUTE Users_GetAll