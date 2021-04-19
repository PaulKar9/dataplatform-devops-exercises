CREATE FUNCTION LostAndFound.CalculateShipping (@HotelState VARCHAR(2), @ShippingState VARCHAR(2))
RETURNS INTEGER
AS
BEGIN
	IF (@HotelState = @ShippingState)
		BEGIN
			IF (@HotelState IS NULL OR LTRIM(@HotelState) = '')
				BEGIN
					RETURN NULL;
				END
			RETURN 10
		END
	ELSE
		IF (@HotelState IS NULL OR LTRIM(@HotelState) = '' OR @ShippingState IS NULL OR LTRIM(@ShippingState) = '')
			BEGIN
				RETURN NULL;
			END
	RETURN 25
END
GO