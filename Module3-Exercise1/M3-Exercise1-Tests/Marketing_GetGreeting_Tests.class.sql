EXEC tSQLt.NewTestClass 'Marketing_GetGreeting_Tests';
GO

CREATE PROCEDURE Marketing_GetGreeting_Tests.[test first and last name Greeting]
AS
BEGIN
	DECLARE @ExpectedGreeting VARCHAR(MAX);
	DECLARE @ActualGreeting VARCHAR(MAX);

	SELECT @ActualGreeting = (Marketing.GetGreeting('Paul', 'Kardash'))

	SET @ExpectedGreeting = 'Dear P. Kardash';

	EXEC tSQLt.AssertEqualsString @ExpectedGreeting, @ActualGreeting;
	
END
GO

CREATE PROCEDURE Marketing_GetGreeting_Tests.[test another first and last name Greeting]
AS
BEGIN
	DECLARE @ExpectedGreeting VARCHAR(MAX);
	DECLARE @ActualGreeting VARCHAR(MAX);

	SELECT @ActualGreeting = (Marketing.GetGreeting('Oksana', 'Kardash'))

	SET @ExpectedGreeting = 'Dear O. Kardash';

	EXEC tSQLt.AssertEqualsString @ExpectedGreeting, @ActualGreeting;
	
END
GO

CREATE PROCEDURE Marketing_GetGreeting_Tests.[test not Kardash first and last name Greeting]
AS
BEGIN
	DECLARE @ExpectedGreeting VARCHAR(MAX);
	DECLARE @ActualGreeting VARCHAR(MAX);

	SELECT @ActualGreeting = (Marketing.GetGreeting('Mila', 'Shtein'))

	SET @ExpectedGreeting = 'Dear M. Shtein';

	EXEC tSQLt.AssertEqualsString @ExpectedGreeting, @ActualGreeting;
	
END
GO