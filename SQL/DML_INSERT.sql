-- DDL.sql must be run before the commands below

-- DELETE all rows of the table before running INSERT statements
DELETE FROM BOOKING_LOCATIONS;
DELETE FROM LOCATIONS;
DELETE FROM BOOKING;
DELETE FROM PAYMENT;
DELETE FROM "USER";
DELETE FROM VEHICLE;
DELETE FROM DRIVER;

-- DRIVER table INSERT statements (10 rows)
INSERT INTO DRIVER
	(DriverID, LicenseNo, FirstName, MiddleName, LastName, MobileNo, Email, DOB, Rating, Sex)
VALUES
	(1, 'Z053656', 'John', 'Mila', 'Hayes', '0759937425', 'srumbellow0@diigo.com', '10/23/1989', 3.8, 'F'),
	(2, 'Y644515', 'Michael', 'Avery', 'Tran', '0721959822', 'aroebuck1@prnewswire.com', '1/17/1967', 4.5, 'M'),
	(3, 'Q883229', 'Emily', NULL, 'Campbell', '0715287306', 'etaunton2@nytimes.com', '3/12/1950', 0.7, NULL),
	(4, 'S260608', 'Jessica', 'Lucas', 'Jackson', '0727972385', 'rtassell3@reference.com', '2/12/1979', 4.0, 'M'),
	(5, 'O206632', 'Daniel', 'Lily', 'Carey', '0758613499', 'jmcquin4@purevolume.com', '8/18/2005', 3.4, 'F'),
	(6, 'G639418', 'Sophia', 'Harper', 'Berry', '0724374949', 'mbuncom5@time.com', '11/7/1957', 2.1, NULL),
	(7, 'L478421', 'David', NULL, 'Jackson', '0733629351', 'rbowmen6@plala.or.jp', '5/14/1976', 2.4, NULL),
	(8, 'T363762', 'Olivia', NULL, 'Hayes', '0735817434', 'lpohlak7@360.cn', '4/7/1972', 4.9, NULL),
	(9, 'C791736', 'Andrew', 'Chloe', 'Johnson', '0762849505', 'ltewkesberrie8@ft.com', '2/6/1971', 0.2, 'F'),
	(10, 'Q519496', 'Emma', 'Owen', 'Hayes', '0725496726', 'gheskey9@yolasite.com', '3/26/1993', 2.1, 'M');

-- VEHICLE table INSERT statements (15 rows)
INSERT INTO VEHICLE
	(VehicleID, PlateNumber, Model, Colour, Manufacturer, Mileage, DriverID, LicenseNo)
VALUES
	(1, 'SP-SQX-4150', 'Camry', 'Red', 'Toyota', 24396, 1, 'Z053656'),
	(2, 'WP-TGK-3771', 'Accord', 'White', 'Honda', 29342, 2, 'Y644515'),
	(3, 'NP-ZRZ-7708', 'Fusion', 'Blue', 'Ford', 194170, 3, 'Q883229'),
	(4, 'SP-IWB-7387', 'Malibu', 'Blue', 'Chevrolet', 142376, 4, 'S260608'),
	(5, 'SP-AXA-1478', 'Altima', 'Gray', 'Nissan', NULL, 5, 'O206632'),
	(6, 'SP-OTM-2914', 'Camry', 'Blue', 'Toyota', 13765, 6, 'G639418'),
	(7, 'WP-BWD-8609', 'Accord', 'Green', 'Honda', NULL, 7, 'L478421'),
	(8, 'WP-MVG-7709', 'Fusion', 'Gray', 'Ford', 14599, 8, 'T363762'),
	(9, 'NP-IKM-0576', 'Malibu', NULL, 'Chevrolet', 77686, 9, 'C791736'),
	(10, 'NP-YHZ-6677', 'Altima', 'White', 'Nissan', 169017, 10, 'Q519496'),
	(11, 'WP-KMN-0560', 'Camry', 'Red', 'Toyota', 108244, 1, 'Z053656'),
	(12, 'SP-VEI-0212', 'Accord', 'White', 'Honda', NULL, 2, 'Y644515'),
	(13, 'NP-RSO-4035', 'Fusion', 'Yellow', 'Ford', 57829, 3, 'Q883229'),
	(14, 'WP-NGY-2640', 'Malibu', NULL, 'Chevrolet', NULL, 4, 'S260608'),
	(15, 'WP-XON-5412', 'Altima', 'Brown', 'Nissan', 135627, 5, 'O206632');

-- USER table INSERT statements (10 rows)
INSERT INTO "USER"
	(UserID, NIC, Username, MobileNo, DOB, Email, RideStreak)
VALUES
	(1, '199854184012', 'JohnSmith1234', '0796157571', '12/6/1951', 'dstelfax0@discuz.net', 7),
	(2, '199397077499', 'EmilyDavis4567', '0777223713', '5/17/1972', 'ofaucherand1@kickstarter.com', 14),
	(3, '199892836078', 'MichaelJohnson7890', '0737675970', '9/29/1984', 'jkennham2@va.gov', 11),
	(4, '199757962356', 'SarahBrown2345', '0768287280', '2/22/1975', 'aashbrook3@zdnet.com', 6),
	(5, '199439611404', 'DavidWilson5678', '0773485026', '12/20/1968', 'kfilochov4@npr.org', 10),
	(6, '199534031148', 'JenniferLee8901', '0721520008', '9/29/1992', 'jlamport5@github.com', 20),
	(7, '199258714412', 'WilliamClark1234', '0749948565', '10/13/1960', 'creece6@so-net.ne.jp', 4),
	(8, '199371679143', 'LindaMoore4567', '0732217374', '10/1/1953', 'krougier7@statcounter.com', 3),
	(9, '199399826086', 'JamesAnderson7890', '0717658200', '2/9/1951', null, 11),
	(10, '199100804782', 'SusanMartin2345', '0708882810', '5/4/1965', 'pmaciocia9@livejournal.com', 3);

-- PAYMENT table INSERT statements (15 rows)
INSERT INTO PAYMENT
	(PaymentID, Amount, PaymentMethod, Discount)
VALUES
	(1, 7278.2, 'Cash', 0),
	(2, 1137.86, 'Mobile', 25.5),
	(3, 6544.3, 'Cash', 10.5),
	(4, 4603.43, 'Mobile', 18.5),
	(5, 3872.63, 'Credit', 0),
	(6, 1896.14, 'Credit', 30.0),
	(7, 8711.64, 'Cash', 15.0),
	(8, 338.52, 'Credit', 0),
	(9, 7775.45, 'Credit', 0),
	(10, 1353.44, 'Credit', 0),
	(11, 7822.04, 'Cash', 0),
	(12, 1462.93, 'Cash', 0),
	(13, 661.88, 'Cash', 5.5),
	(14, 5864.39, 'Credit', 4.5),
	(15, 7199.52, 'Credit', 15.0);

-- BOOKING table INSERT statements (15 rows)
INSERT INTO BOOKING
	(BookingID, BookingTime, ETA, Distance, DriverID, LicenseNo, UserID, NIC, PaymentID)
VALUES
	(1, '09:25 AM', '09:45 AM', 3.6, 1, 'Z053656', 7, '199258714412', 7),
	(2, '02:30 PM', '03:00 PM', 2.8, 2, 'Y644515', 1, '199854184012', 12),
	(3, '11:40 AM', '10:30 AM', 3.7, 3, 'Q883229', 8, '199371679143', 3),
	(4, '10:45 AM', '07:15 PM', 3.6, 4, 'S260608', 3, '199892836078', 6),
	(5, '05:40 PM', '11:50 AM', 4.3, 5, 'O206632', 10, '199100804782', 15),
	(6, '05:40 PM', '03:40 PM', 3.7, 6, 'G639418', 6, '199534031148', 8),
	(7, '10:00 AM', '08:00 AM', 3.3, 7, 'L478421', 2, '199397077499', 5),
	(8, '01:40 PM', '05:45 PM', 4.7, 8, 'T363762', 4, '199757962356', 9),
	(9, '09:00 AM', '02:10 PM', 5, 9, 'C791736', 9, '199399826086', 14),
	(10, '09:25 AM', '09:55 AM', 4.9, 10, 'Q519496', 5, '199439611404', 1),
	(11, '01:40 PM', '01:20 PM', 2.8, 1, 'Z053656', 7, '199258714412', 2),
	(12, '05:15 PM', '05:25 PM', 3.7, 2, 'Y644515', 1, '199854184012', 11),
	(13, '09:15 AM', '08:30 AM', 3.6, 3, 'Q883229', 8, '199371679143', 13),
	(14, '09:00 AM', '06:45 PM', 3.3, 4, 'S260608', 3, '199892836078', 4),
	(15, '09:15 AM', '11:15 AM', 4.2, 5, 'O206632', 10, '199100804782', 10);

-- LOCATIONS table INSERT statements (10 rows)
INSERT INTO LOCATIONS
	(LocationID, LocationName, Latitude, Longitude)
VALUES
	(1, 'Colombo', 6.9271, 79.8612),
	(2, 'Kandy', 7.2906, 80.6337),
	(3, 'Galle', 6.032, 80.217),
	(4, 'Jaffna', 9.6612, 80.0255),
	(5, 'Nuwara Eliya', 6.9709, 80.7832),
	(6, 'Negombo', 7.2083, 79.8398),
	(7, 'Anuradhapura', 8.322, 80.4071),
	(8, 'Matara', 5.9487, 80.535),
	(9, 'Polonnaruwa', 7.9403, 81.0188),
	(10, 'Ratnapura', 6.7054, 80.3847);

-- BOOKING_LOCATIONS table INSERT statements (20 rows)
INSERT INTO BOOKING_LOCATIONS
	(BookingID, LocationID, LocationType, "Order")
VALUES
	(1, 1, 'Pickup', 1),
	(1, 2, 'Dropoff', 1),
	(2, 1, 'Pickup', 1),
	(2, 3, 'Dropoff', 1),
	(3, 4, 'Pickup', 1),
	(3, 8, 'Pickup', 2),
	(3, 6, 'Dropoff', 2),
	(3, 5, 'Dropoff', 1),
	(4, 3, 'Pickup', 1),
	(4, 6, 'Dropoff', 1),
	(5, 2, 'Pickup', 1),
	(5, 1, 'Dropoff', 1),
	(7, 5, 'Pickup', 1),
	(7, 7, 'Dropoff', 1),
	(10, 10, 'Pickup', 1),
	(10, 9, 'Dropoff', 1),
	(12, 5, 'Pickup', 1),
	(12, 6, 'Dropoff', 1),
	(13, 7, 'Pickup', 1),
	(13, 3, 'Dropoff', 1);