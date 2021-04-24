CREATE VIEW Marketing.EmailList AS
SELECT CustomerId, FirstName, LastName, Email, OptIn
FROM Booking.Customers
WHERE OptIn = 1