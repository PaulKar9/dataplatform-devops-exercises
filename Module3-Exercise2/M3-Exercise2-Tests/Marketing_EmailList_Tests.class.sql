EXEC tSQLt.NewTestClass 'Marketing_EmailList_Tests';
GO

CREATE PROCEDURE Marketing_EmailList_Tests.[test one preson opted in]
AS
BEGIN
	IF OBJECT_ID(N'ActualEmailList') IS NOT NULL DROP TABLE ActualEmailList;
    IF OBJECT_ID(N'ExpectedEmailList') IS NOT NULL DROP TABLE ExpectedEmailList;

	EXEC tSQLt.FakeTable 'Booking.Customers';

	INSERT INTO Booking.Customers (CustomerId, FirstName, LastName, Email, OptIn)
						   VALUES (11, 'Paul', 'Kardash', 'pkardash@gmail.com', 1);

	SELECT CustomerId, FirstName, LastName, Email, OptIn
	INTO ActualEmailList
	FROM Marketing.EmailList

	SELECT 
		11 AS CustomerId, 
		'Paul' AS FirstName, 
		'Kardash' AS LastName, 
		'pkardash@gmail.com' AS Email, 
		1 AS OptIn
	INTO ExpectedEmailList

	EXEC tSQLt.AssertEqualsTable ExpectedEmailList, ActualEmailList;


END
GO

CREATE PROCEDURE Marketing_EmailList_Tests.[test two preson opted in]
AS
BEGIN
	IF OBJECT_ID(N'ActualEmailList') IS NOT NULL DROP TABLE ActualEmailList;
    IF OBJECT_ID(N'ExpectedEmailList') IS NOT NULL DROP TABLE ExpectedEmailList;

	EXEC tSQLt.FakeTable 'Booking.Customers';

	INSERT INTO Booking.Customers (CustomerId, FirstName, LastName, Email, OptIn)
						   VALUES (11, 'Paul', 'Kardash', 'pkardash@gmail.com', 1)
								  ,(12, 'Oksana', 'Kardash', 'okardash@gmail.com', 1);

	SELECT CustomerId, FirstName, LastName, Email, OptIn
	INTO ActualEmailList
	FROM Marketing.EmailList

	SELECT TOP 0 *
	INTO ExpectedEmailList
	FROM Marketing.EmailList

	INSERT INTO ExpectedEmailList (CustomerId, FirstName, LastName, Email, OptIn)
						   VALUES (12, 'Oksana', 'Kardash','okardash@gmail.com',1)
						         ,(11, 'Paul', 'Kardash', 'pkardash@gmail.com', 1)

	EXEC tSQLt.AssertEqualsTable ExpectedEmailList, ActualEmailList;


END
GO

CREATE PROCEDURE Marketing_EmailList_Tests.[test no one opted in]
AS
BEGIN
	IF OBJECT_ID(N'ActualEmailList') IS NOT NULL DROP TABLE ActualEmailList;

	EXEC tSQLt.FakeTable 'Booking.Customers';

	INSERT INTO Booking.Customers (CustomerId, FirstName, LastName, Email, OptIn)
						   VALUES (11, 'Paul', 'Kardash', 'pkardash@gmail.com', 0)
								  ,(12, 'Oksana', 'Kardash', 'okardash@gmail.com', 0);

	SELECT CustomerId, FirstName, LastName, Email, OptIn
	INTO ActualEmailList
	FROM Marketing.EmailList

	EXEC tSQLt.AssertEmptyTable ActualEmailList;
END
GO