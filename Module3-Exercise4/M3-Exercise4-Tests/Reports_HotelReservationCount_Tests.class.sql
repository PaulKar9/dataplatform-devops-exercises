EXEC tSQLt.NewTestClass 'Reports_HotelReservationCount_Tests';
GO
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test getting one hotel reservation for one hotel] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	EXEC tSQLt.FakeTable @TableName = N'Customers', @SchemaName = N'Booking';
	

	INSERT INTO Vendors.Hotels
	(
	    HotelId,
	    Name,
	    HotelState,
	    CostPerNight,
	    AdditionalColumns
	)
	VALUES
	(   1,    -- HotelId - int
	    N'PaulHotel',  -- Name - nvarchar(400)
	    'AB',   -- HotelState - char(2)
	    100, -- CostPerNight - numeric(10, 2)
	    NULL  -- AdditionalColumns - binary(200)
	    )

	INSERT INTO Booking.Reservations
	(
	    ReservationId,
	    CustomerId,
	    HotelId,
	    AdditionalColumns
	)
	VALUES
	(   1,   -- ReservationId - int
	    1,   -- CustomerId - int
	    1,   -- HotelId - int
	    NULL -- AdditionalColumns - binary(200)
	    )

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Marketing.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				  VALUES (1, 'PaulHotel', 'AB', 1);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test getting no hotel reservations count] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	

	INSERT INTO Vendors.Hotels(HotelId,Name, HotelState, CostPerNight, AdditionalColumns)
					   VALUES (1, N'PaulHotel', 'AB', 100, NULL)

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Marketing.HotelReservationCount

	EXEC tSQLt.AssertEmptyTable #Actual;
END
GO

CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test getting 2 hotel reservations count for 1 hotel] 
AS
BEGIN
	EXEC tSQLt.FakeTable @TableName = N'Reservations', @SchemaName = N'Booking';
	EXEC tSQLt.FakeTable @TableName = N'Hotels', @SchemaName = 'Vendors';
	
	INSERT INTO Vendors.Hotels (HotelId, Name, HotelState, CostPerNight, AdditionalColumns)
						VALUES (1, N'PaulHotel', 'AB', 100, NULL);

	INSERT INTO Booking.Reservations (ReservationId, CustomerId, HotelId, AdditionalColumns)
							  VALUES (1, 1, 1, NULL)
									,(2, 1, 1, NULL);

	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Marketing.HotelReservationCount

	SELECT TOP 0 *
	INTO #Expected
	FROM #Actual

	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				  VALUES (1, 'PaulHotel', 'AB', 2);

	EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO
