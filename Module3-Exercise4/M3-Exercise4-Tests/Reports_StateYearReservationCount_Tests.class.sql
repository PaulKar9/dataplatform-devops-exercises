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

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test 2 - getting 1 hotel reservations; 1 hotels, 1 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	

	INSERT INTO Vendors.Hotels(HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES(1, N'PaulHotel', 'AB', 100, NULL)

	INSERT INTO Booking.Reservations(ReservationId, CustomerId, HotelId, ReservationDate, AdditionalColumns)
							  VALUES(1, 1, 1, CAST('2019-01-01' AS DATE), NULL)

	SELECT ReservationYear, ReservationState, ReservationCount
	INTO #Actual
	FROM Reports.StateYearReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (ReservationYear, ReservationState, ReservationCount) 
				   VALUES (2019, 'AB', 1);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test 3 - getting 0 hotel reservations; 1 hotels, 0 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	

	INSERT INTO Vendors.Hotels(HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES(1, N'PaulHotel', 'AB', 100, NULL)

	SELECT ReservationYear, ReservationState, ReservationCount
	INTO #Actual
	FROM Reports.StateYearReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test 4 - getting 3 hotel reservations; 0 hotels, 3 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	
	INSERT INTO Booking.Reservations(ReservationId, CustomerId, HotelId, ReservationDate, AdditionalColumns)
							  VALUES(1, 1, 1, CAST('2019-01-01' AS DATE), NULL),(2, 1, 1, CAST('2019-01-01' AS DATE), NULL),(3, 1, 1, CAST('2019-01-01' AS DATE),NULL)

	SELECT ReservationYear, ReservationState, ReservationCount
	INTO #Actual
	FROM Reports.StateYearReservationCount

	SELECT TOP(0) A.* INTO #Expected FROM #Actual A RIGHT JOIN #Actual X ON 1=0;

	INSERT INTO #Expected (ReservationYear, ReservationState, ReservationCount) 
				   VALUES (2019, NULL, 3);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test 5 - getting 0 hotel reservations; 3 hotels, 0 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	
	INSERT INTO Vendors.Hotels(HotelId,Name, HotelState, CostPerNight, AdditionalColumns)
					   VALUES (1, N'PaulHotel', 'AB', 100, NULL),
							  (2, N'OksanaHotel', 'AB', 110, NULL),
							  (3, N'PaulHotel', 'AB', 120, NULL);

	SELECT ReservationYear, ReservationState, ReservationCount
	INTO #Actual
	FROM Reports.StateYearReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test 6 - getting 3 hotel reservations; 3 hotels, 3 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	
	INSERT INTO Vendors.Hotels (HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES (1, N'PaulHotel', 'AB', 100, NULL),
							   (2, N'OksanaHotel', 'AB', 110, NULL),
							   (3, N'LevHotel', 'AB', 120, NULL);

	INSERT INTO Booking.Reservations (ReservationId, CustomerId, HotelId, ReservationDate, AdditionalColumns)
							  VALUES (1, 1, 1, CAST('2019-01-01' AS DATE), NULL),(2, 1, 2, CAST('2019-01-01' AS DATE), NULL),(3, 1, 3, CAST('2019-01-01' AS DATE), NULL);

	SELECT ReservationYear, ReservationState, ReservationCount
	INTO #Actual
	FROM Reports.StateYearReservationCount

	SELECT TOP(0) A.* INTO #Expected FROM #Actual A RIGHT JOIN #Actual X ON 1=0;

	INSERT INTO #Expected (ReservationYear, ReservationState, ReservationCount) 
				   VALUES (2019, 'AB', 3);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO
