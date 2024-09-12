USE littlelemondb;

DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(IN cid INT, IN bid INT, IN tn INT, IN bd DATE)
BEGIN
  INSERT INTO CustomerDetails(CustomerID, CustomerFirstName, CustomerLastName, ContactDetails) VALUES(cid, "", "", "");
  INSERT INTO Bookings(BookingID, Date, TableNumber, CustomerID) VALUES (bid, bd, tn, cid);
  SELECT CONCAT("New Booking for table number ", tn, " for the date ", bd, " for customer id ", cid, " with booking id ", bid, " has been added");
END //

DELIMITER ;

#CALL AddBooking(13, 10 , 4, "2022-12-30");


DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN bid INT, IN bd DATE)
BEGIN
  UPDATE Bookings
  SET Date = bd
  WHERE BookingID = bid;
  SELECT CONCAT("Booking date updated to ", bd, " for the booking id ", bid);
END //

DELIMITER ;

#CALL UpdateBooking(10 , "2022-12-31");

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(IN bid INT)
BEGIN
  DELETE FROM Bookings
  WHERE BookingID = bid;
  SELECT CONCAT("Booking with bookingid ", bid, " has been deleted");
END //

DELIMITER ;

CALL CancelBooking(10);








 
