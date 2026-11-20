const { MongoClient } = require("mongodb");

const uri = "mongodb://localhost:27017";

async function updateStock(){

    const client = new MongoClient(uri);

    await client.connect();

    const db = client.db("RetailDB");

    const products = db.collection("products");

    await products.updateOne(

        { productId:101 },

        {
            $inc:
            {
                stock:-2
            }
        }

    );

    console.log("Stock Updated");

    await client.close();

}

updateStock();

Explanation Note
When MongoDB Transactions Are Required
Use MongoDB transactions when:
- Updating stock in one collection.
- Creating an order document.
- Creating multiple order-line documents.
- Every operation must either succeed together or fail together (ACID transaction).
Example:
- Decrease stock.
- Insert order.
- Insert order lines.
If any step fails, the transaction is rolled back.
When Single-Document Atomic Updates Are Enough
A MongoDB transaction is not required when only a single document is modified.

Example:
db.products.updateOne(
    { productId:101 },
    {
        $inc:{stock:-2}
    }
);

The $inc operation is atomic on a single document, making it efficient without the overhead of a transaction.