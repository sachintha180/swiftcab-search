async function getBookings(pickupLocation, dropoffLocation) {

    const response = await fetch("/search", {
        method: "POST",
        headers: {
            "Content-type": "application/json"
        },
        body: JSON.stringify({
            pickupLocation: pickupLocation,
            dropoffLocation: dropoffLocation
        })
    });

    return response.json();

}

function populateBookings(bookings) {

    document.querySelector("#booking-items").innerHTML = ""

    for (const bookingID in bookings) {

        const bookingItem = document.createElement("input");

        bookingItem.setAttribute("type", "button")
        bookingItem.setAttribute("name", `${bookingID}`)
        bookingItem.setAttribute("id", `booking-btn-${bookingID}`)
        bookingItem.setAttribute("class", "primary-btn no-top-margin")
        bookingItem.setAttribute("value", `ID #${bookingID} | ${bookings[bookingID]["Pickup"].split("(")[0]} ➡ ${bookings[bookingID]["Dropoff"].split("(")[0]}`);

        document.querySelector("#booking-items").appendChild(bookingItem);
    }


    document.querySelectorAll("#booking-items input").forEach(bookingBtn => {

        bookingBtn.addEventListener("click", (event) => {

            let bookingID = event.target.getAttribute("name");

            document.getElementById("booking-id").innerHTML = `Booking ID: ${bookingID}`;
            document.getElementById("booking-time").innerHTML = `Time: ${bookings[bookingID]["BookingTime"]}`
            document.getElementById("booking-distance").innerHTML = `Distance: ${bookings[bookingID]["Distance"]} km`
            document.getElementById("booking-eta").innerHTML = `ETA: ${bookings[bookingID]["ETA"]}`
            document.getElementById("booking-pickups").innerHTML = `Pickups: ${bookings[bookingID]["Pickup"]}`
            document.getElementById("booking-dropoffs").innerHTML = `Dropoffs: ${bookings[bookingID]["Dropoff"]}`

            document.getElementById("driver-licenseno").innerHTML = `License No: ${bookings[bookingID]["LicenseNo"]}`;
            document.getElementById("driver-name").innerHTML = bookings[bookingID]["FullName"]
            document.getElementById("driver-email").innerHTML = bookings[bookingID]["DriverEmail"]
            document.getElementById("driver-mobileno").innerHTML = `Mobile No: ${bookings[bookingID]["MobileNo"]}`
            document.getElementById("driver-dob").innerHTML = `DOB: ${bookings[bookingID]["DriverDOB"]}`
            document.getElementById("driver-rating").innerHTML = `Rating: ${bookings[bookingID]["Rating"]}/5.0`

            document.getElementById("user-nic").innerHTML = `User NIC: ${bookings[bookingID]["NIC"]}`;
            document.getElementById("user-name").innerHTML = bookings[bookingID]["Username"]
            document.getElementById("user-email").innerHTML = bookings[bookingID]["UserEmail"]
            document.getElementById("user-dob").innerHTML = `DOB: ${bookings[bookingID]["UserDOB"]}`
            document.getElementById("user-streak").innerHTML = `Ride Streak: ${bookings[bookingID]["RideStreak"]}`

            document.querySelectorAll(".entity-details").forEach(detailSection => {
                detailSection.classList.add("visible")
            });
        });

    });

}

document.addEventListener("DOMContentLoaded", () => {

    const errorContainer = document.querySelector("#error")
    const errorMessage = document.querySelector("#error-message")
    let data = null

    document.querySelector("#search-btn").addEventListener("click", async () => {

        document.querySelectorAll(".entity-details").forEach(detailSection => {
            detailSection.classList.remove("visible")
        });

        const pickupLocation = document.querySelector("#pickup-location").value;
        const dropoffLocation = document.querySelector("#dropoff-location").value;

        if (pickupLocation === "null" && dropoffLocation === "null") {
            errorMessage.innerHTML = "Please select a valid pickup / dropoff location."
            errorContainer.classList.add("visible")
        }
        else {
            errorContainer.classList.remove("visible")
            errorMessage.innerHTML = ""
            data = await getBookings(pickupLocation, dropoffLocation);
            populateBookings(data.bookings);
        }

    });

})