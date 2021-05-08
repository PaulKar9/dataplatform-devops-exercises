CREATE VIEW Reports.StateYearReservationCount AS
SELECT * --0 ReservationYear, h.HotelState AS ReservationState, ReservationCount
FROM Vendors.Hotels h
--JOIN Booking.Reservations r 
--	ON r.HotelId = h.HotelId