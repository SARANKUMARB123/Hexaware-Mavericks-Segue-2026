// TASK 5

use("RetailInventoryDB");

// Product Reviews: Stored in MongoDB because reviews are unstructured and vary in length.
// Search Activity: Stored in MongoDB because search logs are high-volume and schema-flexible.

db.createCollection("reviews", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["reviewId", "sku", "customerName", "rating", "review"],
      properties: {
        reviewId: { bsonType: "int" },
        sku: { bsonType: "string" },
        customerName: { bsonType: "string" },
        rating: { bsonType: "int", minimum: 1, maximum: 5 },
        review: { bsonType: "string" },
        reviewDate: { bsonType: "date" }
      }
    }
  }
});

db.createCollection("searchActivity");

db.reviews.insertMany([
{reviewId:1,sku:"P101",customerName:"Arun",rating:5,review:"Excellent laptop.",reviewDate:new Date()},
{reviewId:2,sku:"P102",customerName:"Kumar",rating:4,review:"Comfortable chair.",reviewDate:new Date()},
{reviewId:3,sku:"P103",customerName:"Priya",rating:5,review:"Very good quality.",reviewDate:new Date()},
{reviewId:4,sku:"P104",customerName:"John",rating:3,review:"Useful book.",reviewDate:new Date()},
{reviewId:5,sku:"P105",customerName:"Meena",rating:4,review:"Nice fabric.",reviewDate:new Date()},
{reviewId:6,sku:"P106",customerName:"Rahul",rating:5,review:"Good football.",reviewDate:new Date()},
{reviewId:7,sku:"P107",customerName:"Sneha",rating:4,review:"Kids loved it.",reviewDate:new Date()},
{reviewId:8,sku:"P108",customerName:"Vijay",rating:5,review:"Works perfectly.",reviewDate:new Date()},
{reviewId:9,sku:"P109",customerName:"Anitha",rating:4,review:"Nice shampoo.",reviewDate:new Date()},
{reviewId:10,sku:"P110",customerName:"Suresh",rating:5,review:"Very useful notebook.",reviewDate:new Date()}
]);

db.searchActivity.insertMany([
{user:"Arun",keyword:"Laptop",searchTime:new Date()},
{user:"Priya",keyword:"Java Book",searchTime:new Date()},
{user:"Rahul",keyword:"Football",searchTime:new Date()},
{user:"Meena",keyword:"Shampoo",searchTime:new Date()},
{user:"Kumar",keyword:"Notebook",searchTime:new Date()}
]);

db.reviews.find();

db.reviews.find({ sku: "P101" });

db.reviews.updateOne(
  { reviewId: 2 },
  {
    $set: {
      rating: 5,
      review: "Very comfortable office chair."
    }
  }
);

db.reviews.find({ reviewId: 2 });

db.reviews.deleteOne({ reviewId: 10 });

db.reviews.find();

db.searchActivity.find();

db.getCollectionNames();