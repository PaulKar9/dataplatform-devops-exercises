EXEC tSQLt.NewTestClass 'Reports_HotelReservationCount_Tests';
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test 1 - getting 0 hotel reservations; 0 hotels, 0 reservations] 
AS
BEGIN
	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test 2 - getting 1 hotel reservations; 1 hotels, 1 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	

	INSERT INTO Vendors.Hotels(HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES(1, N'PaulHotel', 'AB', 100, NULL)

	INSERT INTO Booking.Reservations(ReservationId, CustomerId, HotelId, AdditionalColumns)
							  VALUES(1, 1, 1, NULL)

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				   VALUES (1, 'PaulHotel', 'AB', 1);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test 3 - getting 0 hotel reservations; 1 hotels, 0 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	

	INSERT INTO Vendors.Hotels(HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES(1, N'PaulHotel', 'AB', 100, NULL)

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test 4 - getting 3 hotel reservations; 0 hotels, 3 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	
	INSERT INTO Booking.Reservations(ReservationId, CustomerId, HotelId, AdditionalColumns)
							  VALUES(1, 1, 1, NULL),(2, 1, 1, NULL),(3, 1, 1, NULL)

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				   VALUES (1, NULL, NULL, 3);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test 5 - getting 0 hotel reservations; 3 hotels, 0 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	
	INSERT INTO Vendors.Hotels(HotelId,Name, HotelState, CostPerNight, AdditionalColumns)
					   VALUES (1, N'PaulHotel', 'AB', 100, NULL),
							  (2, N'OksanaHotel', 'AB', 110, NULL),
							  (3, N'PaulHotel', 'AB', 120, NULL);

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test 6 - getting 3 hotel reservations; 3 hotels, 3 reservations] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	
	INSERT INTO Vendors.Hotels (HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES (1, N'PaulHotel', 'AB', 100, NULL),
							   (2, N'OksanaHotel', 'AB', 110, NULL),
							   (3, N'LevHotel', 'AB', 120, NULL);

	INSERT INTO Booking.Reservations (ReservationId, CustomerId, HotelId, AdditionalColumns)
							  VALUES (1, 1, 1, NULL),(2, 1, 2, NULL),(3, 1, 3, NULL);

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Reports.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				   VALUES (1, 'PaulHotel', 'AB', 1),
						  (2, 'OksanaHotel', 'AB', 1),
						  (3, 'LevHotel', 'AB', 1);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO
