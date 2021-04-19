CREATE FUNCTION LostAndFound.CalculateHandling (@RewardsBalance INTEGER)
RETURNS INTEGER
AS
BEGIN
	IF (@RewardsBalance >= 1000)
		BEGIN
			RETURN 0
		END
	ELSE
		IF (@RewardsBalance IS NULL)
			BEGIN
				RETURN NULL;
			END
	RETURN 35
END
GO