#USE littlelemondb;
#CREATE VIEW OrdersView9 AS SELECT OrderID, Quantity, TotalCost FROM littlelemondb.Orders WHERE Quantity > 20;
#SELECT * FROM OrdersView9;

#USE littlelemondb;
#SELECT CustomerDetails.CustomerID, CONCAT(CustomerDetails.CustomerFirstName, " ", CustomerDetails.CustomerLastName) AS CustomFullName, Orders.OrderID, Orders.TotalCost, Menu.DishName, Menu.IsStarter, Menu.Course 
#FROM CustomerDetails 
#INNER JOIN Bookings ON CustomerDetails.CustomerID = Bookings.CustomerID
#INNER JOIN Orders ON Bookings.BookingID = Orders.BookingID
#INNER JOIN Menu ON Menu.MenuID = Orders.MenuID
#WHERE Orders.TotalCost > 200;

#USE littlelemondb;
#CREATE VIEW checktemp5 AS SELECT MenuID, COUNT(MenuID) AS checktempcol FROM Orders GROUP BY MenuID;
#SELECT DishName FROM Menu WHERE MenuID IN (SELECT MenuID FROM checktemp5 WHERE checktempcol > 2);

#USE littlelemondb;
#CREATE PROCEDURE GetMaxQuantity()
#SELECT MAX(Quantity) AS "Max Quantity in Order" FROM Orders;
#CALL GetMaxQuantity();

#PREPARE GetOrderDetail FROM "SELECT OrderID, Quantity, TotalCost FROM Orders WHERE BookingID = ?";
#SET @id = 1;
#EXECUTE GetOrderDetail USING @id;

##SELECT Orders.OrderID, Orders.Quantity, Orders.TotalCost FROM Orders INNER JOIN Bookings ON Orders.BookingID = Bookings.BookingID WHERE Bookings.CustomerID = 1;
##SELECT OrderID, Quantity, TotalCost FROM Orders WHERE BookingID = 1;

#DELIMITER //
#CREATE PROCEDURE CancelOrder(IN orderidwa INT)
#BEGIN
#DELETE FROM Orders WHERE OrderID = orderidwa;
#END //

#DELIMITER;
#SELECT * FROM Orders;
#CALL CancelOrder(3);
#SELECT * FROM Orders;

#USE littlelemondb;
#DELIMITER //
#CREATE PROCEDURE CheckBooking2(IN bd DATE, IN tableis INT)
#BEGIN
#  DECLARE datevar DATE;
#  SELECT Date INTO datevar FROM Bookings WHERE TableNumber = tableis;
#  IF datevar = bd THEN
#     SELECT CONCAT("Table ", tableis, " is already booked");
#  ELSE
#     SELECT CONCAT("Table ", tableis, " is available"); 
#  END IF;
#END //

#DELIMITER ;

##SELECT * FROM Bookings WHERE TableNumber = 5;
#CALL CheckBooking2('2022-11-12', 3)

USE littlelemondb;

DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN bd DATE, IN tableis INT, IN cid INT, IN cfn VARCHAR(45), IN cln VARCHAR(45), IN cd VARCHAR(45), IN bid INT)
BEGIN
  DECLARE datevar DATE;
  START TRANSACTION;
  SELECT Date INTO datevar FROM Bookings WHERE TableNumber = tableis;
  INSERT INTO CustomerDetails(CustomerID, CustomerFirstName, CustomerLastName, ContactDetails) VALUES(cid, cfn, cln, cd);
  INSERT INTO Bookings(BookingID, Date, TableNumber, CustomerID) VALUES (bid, bd, tableis, cid);
  IF datevar = bd THEN
     ROLLBACK ;
     SELECT CONCAT("Table ", tableis, " is already booked");
  ELSE
     COMMIT ;
     SELECT CONCAT("Table ", tableis, " is available"); 
  END IF;
END //

DELIMITER ;

#CALL AddValidBooking('2022-12-17', 5, 6, "fn5", "ln4", "4123", 5);
#CALL AddValidBooking('2022-12-17', 5, 7, "fn6", "ln5", "5123", 6);
#CALL AddValidBooking('2022-12-18', 5, 8, "fn7", "ln6", "6123", 7);

#CALL AddValidBooking('2022-12-17', 5, 6, "fn5", "ln4", "4123", 5);
#SELECT * FROM CustomerDetails;
#SELECT * FROM Bookings;

#CALL AddValidBooking('2022-12-17', 3, 7, "fn7", "ln7", "4123", 6);
CALL AddValidBooking('2022-12-18', 1, 10, "fn10", "ln10", "4123", 9);












 
