EXEC tSQLt.NewTestClass 'LostAndFound_CalculateHandling_Tests';
GO

CREATE PROCEDURE LostAndFound_CalculateHandling_Tests.[test different permutation of different input parameters]
AS
BEGIN
	DECLARE @ExpectedHandlingCost INTEGER;
	DECLARE @ActualHandlingCost INTEGER;

	SELECT @ActualHandlingCost = LostAndFound.CalculateHandling(1000);

	SET @ExpectedHandlingCost = 0;
	EXEC tSQLt.AssertEquals @ExpectedHandlingCost, @ActualHandlingCost;

	
	SELECT @ActualHandlingCost = LostAndFound.CalculateHandling(999);

	SET @ExpectedHandlingCost = 35;
	EXEC tSQLt.AssertEquals @ExpectedHandlingCost, @ActualHandlingCost;

	SELECT @ActualHandlingCost = LostAndFound.CalculateHandling(0);

	SET @ExpectedHandlingCost = 35;
	EXEC tSQLt.AssertEquals @ExpectedHandlingCost, @ActualHandlingCost;
END
GO