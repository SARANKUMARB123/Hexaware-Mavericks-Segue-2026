const { MongoClient } = require("mongodb");

const uri = "mongodb://localhost:27017";

async function bookSeat(){

    const client = new MongoClient(uri);

    await client.connect();

    const session = client.startSession();

    try{

        session.startTransaction();

        const db = client.db("AirlineDB");

        const seats = db.collection("seats");

        const bookings = db.collection("bookings");

        await seats.updateOne(
            {
                seatId:101,
                seatStatus:"Available"
            },
            {
                $set:{seatStatus:"Booked"}
            },
            {session}
        );

        await bookings.insertOne(
        {
            passengerName:"Rahul",
            flightId:1,
            seatId:101,
            fare:6500,
            bookingDate:new Date()
        },
        {session}
        );

        await session.commitTransaction();

        console.log("Booking Successful");

    }

    catch(err){

        await session.abortTransaction();

        console.log(err.message);

    }

    finally{

        await session.endSession();

        await client.close();

    }

}

bookSeat();

Short Explanation of Observed Behaviour
READ COMMITTED
- Prevents dirty reads.
- Two users may initially view the same seat as available.
- The first transaction to commit books the seat.
- The second transaction waits and then discovers the seat is already booked.
SERIALIZABLE
- The strictest isolation level.
- Locks the seat record for the duration of the transaction.
- The second transaction cannot proceed until the first completes.
- Prevents double booking and ensures consistent results.