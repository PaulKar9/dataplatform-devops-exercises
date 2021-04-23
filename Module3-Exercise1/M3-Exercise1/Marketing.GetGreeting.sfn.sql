CREATE FUNCTION Marketing.GetGreeting(@FirstName VARCHAR(MAX), @LastName VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN 'Dear ' + LEFT(@FirstName,1) + '. ' + @LastName
END