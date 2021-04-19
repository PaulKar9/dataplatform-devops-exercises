EXEC tSQLt.NewTestClass 'LostAndFound_CalculateShipping_Tests';
GO

CREATE PROCEDURE LostAndFound_CalculateShipping_Tests.[test something]
AS
BEGIN
	DECLARE @ExpectedShippingCost INTEGER;
	DECLARE @ActualShippingCost INTEGER;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping('FL','FL');

	SET @ExpectedShippingCost = 10;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping('FL','NY');

	SET @ExpectedShippingCost = 25;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping(NULL,'NY');

	SET @ExpectedShippingCost = NULL;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping('FL',NULL);

	SET @ExpectedShippingCost = NULL;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping(NULL,NULL);

	SET @ExpectedShippingCost = NULL;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping('','');

	SET @ExpectedShippingCost = NULL;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;

	SELECT @ActualShippingCost = LostAndFound.CalculateShipping(' ','');

	SET @ExpectedShippingCost = NULL;
	EXEC tSQLt.AssertEquals @ExpectedShippingCost, @ActualShippingCost;
END
GO