EXEC tSQLt.NewTestClass 'Reports_StateYearReservationCount_Tests';
GO

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test 1 - getting 0 hotel reservations; 0 hotels, 0 reservations] 
AS
BEGIN
	SELECT ReservationYear, ReservationState, ReservationCount
	INTO #Actual
	FROM Reports.StateYearReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO
