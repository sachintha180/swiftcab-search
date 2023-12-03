-- Create a SwiftDB database
-- Note: The following CREATE DATABASE command must only be run once.
-- CREATE DATABASE SwiftDB;

-- Use SwiftDB database
USE SwiftDB;

-- Drop all tables before running CREATE TABLE statements
DROP TABLE BOOKING_LOCATIONS;
DROP TABLE LOCATIONS;
DROP TABLE BOOKING;
DROP TABLE PAYMENT;
DROP TABLE "USER";
DROP TABLE VEHICLE;
DROP TABLE DRIVER;

-- Create DRIVER table + constraints
CREATE TABLE DRIVER
(
    DriverID INT NOT NULL,
    LicenseNo CHAR(7) NOT NULL,
    FirstName VARCHAR(30) NOT NULL,
    MiddleName VARCHAR(30),
    LastName VARCHAR(30) NOT NULL,
    MobileNo CHAR(10) NOT NULL,
    Email VARCHAR(50),
    DOB DATE,
    Rating DECIMAL(2,1) DEFAULT 0,
    Sex CHAR(2),

    -- Primary key constraint
    CONSTRAINT DRIVER_PK PRIMARY KEY (DriverID, LicenseNo),

    -- Check constraints
    CONSTRAINT DRIVER_LICENSENO_FORMAT CHECK (
        LicenseNo LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9]'
    ),
    CONSTRAINT DRIVER_RATING_RANGE CHECK (
        Rating BETWEEN 0 and 5
    ),
    CONSTRAINT DRIVER_EMAIL_FORMAT CHECK (
        Email LIKE '%@%.%'
    )
);

-- Create VEHICLE table + constraints
CREATE TABLE VEHICLE
(
    VehicleID INT NOT NULL,
    PlateNumber CHAR(11) NOT NULL,
    Model VARCHAR(30),
    Colour VARCHAR(15),
    Manufacturer VARCHAR(30),
    Mileage INT,
    DriverID INT NOT NULL,
    LicenseNo CHAR(7) NOT NULL,

    -- Primary key constraint
    CONSTRAINT VEHICLE_PK PRIMARY KEY (VehicleID),

    -- Foreign key constraint
    CONSTRAINT VEHICLE_DRIVER_FK FOREIGN KEY (DriverID, LicenseNo)
        REFERENCES DRIVER(DriverID, LicenseNo),

    -- Check constraints
    CONSTRAINT VEHICLE_LICENSENO_FORMAT CHECK (
        LicenseNo LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9]'
    ),
    CONSTRAINT VEHICLE_PLATENO_FORMAT CHECK (
        PlateNumber LIKE '[NSWE]P-[A-Z][A-Z][A-Z]-[0-9][0-9][0-9][0-9]'
    )
);

-- Create USER table + constraints
CREATE TABLE "USER"
(
    UserID INT NOT NULL,
    NIC CHAR(12) NOT NULL,
    Username VARCHAR(30) NOT NULL,
    MobileNo CHAR(10),
    DOB DATE,
    Email VARCHAR(30),
    RideStreak INT DEFAULT 0,

    -- Primary key constraint
    CONSTRAINT USER_PK PRIMARY KEY (UserID, NIC),

    -- Check constraints
    CONSTRAINT USER_NIC_FORMAT CHECK (
        NIC LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    ),
    CONSTRAINT USER_DOB_RANGE CHECK (
        DATEDIFF(year, DOB, GETDATE()) >= 18 
    ),
    CONSTRAINT USER_EMAIL_FORMAT CHECK (
        Email LIKE '%@%.%'
    ),
    CONSTRAINT USER_RIDESTREAK_RANGE CHECK (
        RideStreak BETWEEN 0 AND 20
    )
);

-- Create PAYMENT table + constraints
CREATE TABLE PAYMENT
(
    PaymentID INT NOT NULL,
    Amount DECIMAL(6,2) NOT NULL,
    PaymentMethod VARCHAR(10) NOT NULL DEFAULT 'Cash',
    Discount DECIMAL(3,1) DEFAULT 0,

    -- Primary key constraint
    CONSTRAINT PAYMENT_PK PRIMARY KEY (PaymentID),

    -- Check constraints
    CONSTRAINT PAYMENT_DISCOUNT_RANGE CHECK (
        Discount BETWEEN 0 AND 99.9
    )
);

-- Create BOOKING table + constraints
CREATE TABLE BOOKING
(
    BookingID INT NOT NULL,
    BookingTime TIME NOT NULL,
    ETA Time,
    Distance DECIMAL(6,2) DEFAULT 0,
    DriverID INT NOT NULL,
    LicenseNo CHAR(7) NOT NULL,
    UserID INT NOT NULL,
    NIC CHAR(12) NOT NULL,
    PaymentID INT NOT NULL,

    -- Primary key constraint
    CONSTRAINT BOOKING_PK PRIMARY KEY (BookingID),

    -- Foreign key constraints
    CONSTRAINT BOOKING_DRIVER_FK FOREIGN KEY (DriverID, LicenseNo)
        REFERENCES DRIVER(DriverID, LicenseNo),

    CONSTRAINT BOOKING_USER_FK FOREIGN KEY (UserID, NIC)
        REFERENCES "USER"(UserID, NIC),

    CONSTRAINT BOOKING_PAYMENT_FK FOREIGN KEY (PaymentID)
        REFERENCES PAYMENT(PaymentID),

    -- Check constraints
    CONSTRAINT BOOKING_LICENSENO_FORMAT CHECK (
        LicenseNo LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9]'
    ),

    CONSTRAINT BOOKING_NIC_FORMAT CHECK (
        NIC LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    )
);

-- Create LOCATIONS table + constraints
CREATE TABLE LOCATIONS
(
    LocationID INT NOT NULL,
    LocationName VARCHAR(30) NOT NULL,
    Latitude DECIMAL(10,8),
    Longitude DECIMAL(11,8),

    -- Primary key constraint
    CONSTRAINT LOCATIONS_PK PRIMARY KEY (LocationID),

    -- Check constraints
    CONSTRAINT LOCATIONS_LAT_RANGE CHECK (
        Latitude BETWEEN -90 AND 90
    ),

    CONSTRAINT LOCATIONS_LONG_RANGE CHECK (
        Longitude BETWEEN -180 AND 180
    )
);

-- Create BOOKING_LOCATIONS table + constraints
CREATE TABLE BOOKING_LOCATIONS
(
    BookingID INT NOT NULL,
    LocationID INT NOT NULL,
    LocationType VARCHAR(10) NOT NULL,
    "Order" INTEGER NOT NULL DEFAULT 1,

    -- Primary key constraint
    CONSTRAINT BOOKING_LOCATIONS_PK PRIMARY KEY (BookingID, LocationID),

    -- Foreign key constraints
    CONSTRAINT BOOKING_LOCATIONS_FK FOREIGN KEY (BookingID)
        REFERENCES BOOKING(BookingID),

    CONSTRAINT LOCATIONS_BOOKING_FK FOREIGN KEY (LocationID)
        REFERENCES LOCATIONS(LocationID),

    -- Check constraints
    CONSTRAINT ORDER_RANGE CHECK (
        "Order" BETWEEN 1 AND 5
    ),
);