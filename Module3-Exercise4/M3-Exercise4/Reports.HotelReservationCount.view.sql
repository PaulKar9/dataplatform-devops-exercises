CREATE VIEW Reports.HotelReservationCount AS
SELECT 
	r.HotelId, 
	h.Name AS HotelName, 
	h.HotelState, 
	COUNT(r.ReservationId) AS ReservationCount
FROM Vendors.Hotels h
RIGHT JOIN Booking.Reservations r
	ON r.HotelId = h.HotelId
GROUP BY r.HotelId, h.Name, h.HotelState