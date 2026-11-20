Set 1 – Bank Funds Transfer

Mangodb Task - 5

const { MongoClient } = require("mongodb");

const uri = "mongodb://localhost:27017";

async function transferMoney() {

    const client = new MongoClient(uri);

    await client.connect();

    const session = client.startSession();

    try {

        session.startTransaction();

        const db = client.db("BankDB");

        const accounts = db.collection("accounts");

        await accounts.updateOne(
            { accountId: 101 },
            { $inc: { balance: -5000 } },
            { session }
        );

        await accounts.updateOne(
            { accountId: 102 },
            { $inc: { balance: 5000 } },
            { session }
        );

        await session.commitTransaction();

        console.log("Transfer Successful");

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

transferMoney();