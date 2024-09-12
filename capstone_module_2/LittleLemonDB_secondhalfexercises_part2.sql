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

USE littlelemondb;
DELIMITER //
CREATE PROCEDURE CheckBooking2(IN bd DATE, IN tableis INT)
BEGIN
  DECLARE datevar DATE;
  SELECT Date INTO datevar FROM Bookings WHERE TableNumber = tableis;
  IF datevar = bd THEN
     SELECT CONCAT("Table ", tableis, " is already booked");
  ELSE
     SELECT CONCAT("Table ", tableis, " is available"); 
  END IF;
END //

DELIMITER ;

#SELECT * FROM Bookings WHERE TableNumber = 5;
CALL CheckBooking2('2022-11-12', 3)



