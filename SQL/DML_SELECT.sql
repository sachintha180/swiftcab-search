-- 6. Find the first name, last name and license number of DRIVER(s)
--    that attended to BOOKING(s) during early morning rush hour (6:00 AM - 9:00 AM)
SELECT
    D.FirstName AS "First Name",
    D.LastName AS "Last Name",
    D.LicenseNo AS "License Number"
FROM
    DRIVER AS D
    INNER JOIN BOOKING AS B ON D.DriverID = B.DriverID
    AND D.LicenseNo = B.LicenseNo
WHERE
    B.BookingTime BETWEEN '6:00 AM'
    AND '9:00 AM';

-- 7. Find the names of all DISTINCT dropoff LOCATION(s) for all BOOKING_LOCATIONS.
SELECT
    DISTINCT(L.LocationName) AS "Dropoff Locations"
FROM
    LOCATIONS AS L FULL
    OUTER JOIN BOOKING_LOCATIONS AS BL ON L.LocationID = BL.LocationID
WHERE
    BL.LocationType = 'Dropoff';

-- 8. Find the username and date of birth (in YYYY-MM-DD format) of USER(s)
--    with a ride streak greater than 6.
SELECT
    Username,
    CONVERT(CHAR, DOB, 23) AS "Date of Birth"
FROM
    "USER"
WHERE
    RideStreak > 6;

-- 9. Find the average PAYMENT amount (to the nearest upper whole number) and
--    total discount for VEHICLE(s) whose manufacturer is 'Toyota'
SELECT
    CEILING(AVG(P.Amount)) AS "Average Toyota Payment",
    SUM(P.Discount) AS "Total Toyota Discount"
FROM
    PAYMENT AS P
    INNER JOIN BOOKING AS B ON P.PaymentID = B.PaymentID
    INNER JOIN DRIVER AS D ON D.DriverID = B.DriverID
    AND D.LicenseNo = B.LicenseNo
    INNER JOIN VEHICLE AS V ON V.DriverID = D.DriverID
WHERE
    V.Manufacturer = 'Toyota';

-- 10. Find each PAYMENT method and their count, for methods
--     with an average PAYMENT amount greater than 3000.
SELECT
    PaymentMethod AS "Payment Method",
    COUNT(PaymentID) AS "Total Payments"
FROM
    PAYMENT
GROUP BY
    PaymentMethod
HAVING
    AVG(Amount) > 3000;

-- 11. Find the cost per meter (rounded to 1 decimal place) 
--     for all rides made on the app, in descending order
SELECT
    -- (d) Calculate the cost per ride in Rs/m
    B.BookingID,
    ROUND(D.Distance / P.Amount, 1) AS "Cost per Meter (Rs/m)"
FROM
    PAYMENT AS P
    INNER JOIN BOOKING AS B ON B.PaymentID = P.PaymentID
    INNER JOIN (
        SELECT
            -- (c) Calculate the distance travelled (in meters) for each ride
            PL.BookingID,
            (
                SQRT(
                    SQUARE(PL.Longitude - DL.Longitude) + SQUARE(PL.Latitude - DL.Latitude)
                ) * 1000
            ) AS "Distance"
        FROM
            (
                -- (a) Find the BookingID, longitude and latitude 
                --     for all final (i.e. order = 1) pickup locations.
                SELECT
                    BL.BookingID,
                    L.Longitude,
                    L.Latitude
                FROM
                    LOCATIONS AS L
                    INNER JOIN BOOKING_LOCATIONS AS BL ON BL.LocationID = L.LocationID
                WHERE
                    BL.LocationType = 'Pickup'
                    AND BL."Order" = 1
            ) AS PL
            INNER JOIN (
                -- (b) Find the BookingID, longitude and latitude
                --     for all final (i.e. order = 1) dropoff locations.
                SELECT
                    BL.BookingID,
                    L.Longitude,
                    L.Latitude
                FROM
                    LOCATIONS AS L
                    INNER JOIN BOOKING_LOCATIONS AS BL ON BL.LocationID = L.LocationID
                WHERE
                    BL.LocationType = 'Dropoff'
                    AND BL."Order" = 1
            ) AS DL ON PL.BookingID = DL.BookingID
    ) AS D ON D.BookingID = B.PaymentID

-- (e) Order by descending order of cost per meter
ORDER BY
    "Cost per Meter (Rs/m)" DESC;