from flask import Flask, jsonify, render_template, request
import pymssql as mssql

app = Flask(__name__)

MSSQL_USER = "SwiftCabApp"
MSSQL_USERPASS = "67Syjg:D4^uS"
MSSQL_DB = "SwiftDB"


@app.route("/")
def home():
    with mssql.connect("localhost", MSSQL_USER, MSSQL_USERPASS, MSSQL_DB) as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT LocationName FROM LOCATIONS", )
            locations = cursor.fetchall()
    return render_template("index.html", locations=[location[0] for location in locations])


@app.route("/search", methods=["POST"])
def search():
    pickupLocation, dropffLocation = request.json["pickupLocation"], request.json["dropoffLocation"]
    with mssql.connect("localhost", MSSQL_USER, MSSQL_USERPASS, MSSQL_DB) as conn:
        with conn.cursor(as_dict=True) as cursor:
            cursor.execute("""
                SELECT
                    DISTINCT(B.BookingID),
                    CONVERT(VARCHAR, B.BookingTime, 108) AS "BookingTime",
                    CONVERT(VARCHAR, B.ETA, 108) AS "ETA",
                    CONVERT(VARCHAR, B.Distance) AS "Distance",
                    D.LicenseNo,
                    D.FirstName + ' ' + D.LastName AS "FullName",
                    D.Email AS "DriverEmail",
                    D.MobileNo,
                    CONVERT(VARCHAR, D.DOB, 105) AS "DriverDOB",
                    CONVERT(VARCHAR, D.Rating) AS "Rating",
                    U.NIC,
                    U.Username,
                    U.Email AS "UserEmail",
                    CONVERT(VARCHAR, U.DOB, 105) AS "UserDOB",
                    CONVERT(VARCHAR, U.RideStreak) AS "RideStreak"
                FROM BOOKING AS B
                INNER JOIN DRIVER AS D ON D.DriverID = B.DriverID
                INNER JOIN "USER" AS U ON U.UserID = B.UserID
                INNER JOIN BOOKING_LOCATIONS AS BL ON BL.BookingID = B.BookingID
                INNER JOIN LOCATIONS AS L ON L.LocationID = BL.LocationID
                WHERE BL.LocationType = 'Pickup' AND L.LocationName = %s
                OR BL.LocationType = 'Dropoff' AND L.LocationName = %s; 
            """, (pickupLocation, dropffLocation))
            user_driver_data = cursor.fetchall()

            bookings = {}
            for user_driver in user_driver_data:
                bookingID = user_driver["BookingID"]
                cursor.execute("""
                    SELECT BL.BookingID, L.LocationName, BL."Order", BL.LocationType FROM LOCATIONS AS L
                    INNER JOIN BOOKING_LOCATIONS AS BL on L.LocationID = BL.LocationID
                    WHERE BL.BookingID = %s
                    ORDER BY BL."Order";
                """, bookingID)
                locations = cursor.fetchall()

                pickupString = ""
                dropoffString = ""
                for location in locations:
                    if location["LocationType"] == "Pickup":
                        pickupString += f"{location['LocationName']} ({location['Order']}) "
                    else:
                        dropoffString += f"{location['LocationName']} ({location['Order']}) "

                del user_driver["BookingID"]
                bookings[bookingID] = user_driver | {
                    "Pickup": pickupString.strip(),
                    "Dropoff": dropoffString.strip()
                }

    return jsonify(bookings=bookings)


if __name__ == "__main__":
    app.run(debug=True)
