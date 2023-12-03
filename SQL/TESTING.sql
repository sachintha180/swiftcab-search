-- 12.1. Testing via `DELETE` commands
DELETE FROM
    PAYMENT
WHERE
    PaymentID = 5;

-- 12.2. Testing via `DELETE` commands
DELETE FROM
    BOOKING_LOCATIONS
WHERE
    BookingID = 3
    AND LocationID = 6;

-- 13.1. Testing via `UPDATE` commands
UPDATE
    BOOKING
SET
    NIC = '199534031143'
WHERE
    BookingID = 6;

-- 13.2. Testing via `UPDATE` commands
UPDATE
    "USER"
SET
    Username = 'Jeremy Lamport'
WHERE
    UserID = 6;

-- 14.1. Testing via `INSERT` commands
INSERT INTO VEHICLE
    (VehicleID, PlateNumber, Model, Colour, Manufacturer, Mileage, DriverID, LicenseNo)
VALUES
    (7, 'NP-XED-1359', 'E-Class', 'Brown', 'Benz', NULL, 7, 'L478421');

-- 14.2. Testing via `INSERT` commands
INSERT INTO VEHICLE
    (VehicleID, PlateNumber, Model, Colour, Manufacturer, Mileage, DriverID, LicenseNo)
VALUES
    (16, 'NP-XED-1359', 'E-Class', 'Brown', 'Benz', NULL, 7, 'L478421');