// Pipeline 1
// Returns with Customer Details

db.returns.aggregate([
{
    $lookup:
    {
        from: "customers",
        localField: "CustomerID",
        foreignField: "CustomerID",
        as: "CustomerDetails"
    }
},
{
    $project:
    {
        _id: 0,
        ReturnID: 1,
        ProductID: 1,
        ReturnDate: 1,
        Quantity: 1,
        CustomerDetails: 1
    }
}
]);

// Pipeline 2
// Returns with Feedback

db.returns.aggregate([
{
    $lookup:
    {
        from: "feedback",
        localField: "ReturnID",
        foreignField: "ReturnID",
        as: "FeedbackDetails"
    }
},
{
    $project:
    {
        _id: 0,
        ReturnID: 1,
        ProductID: 1,
        FeedbackDetails: 1
    }
}
]);

// Pipeline 3
// Returns with Product, Customer and Feedback

db.returns.aggregate([
{
    $lookup:
    {
        from: "customers",
        localField: "CustomerID",
        foreignField: "CustomerID",
        as: "Customer"
    }
},
{
    $lookup:
    {
        from: "products",
        localField: "ProductID",
        foreignField: "ProductID",
        as: "Product"
    }
},
{
    $lookup:
    {
        from: "feedback",
        localField: "ReturnID",
        foreignField: "ReturnID",
        as: "Feedback"
    }
},
{
    $project:
    {
        _id: 0,
        ReturnID: 1,
        ReturnDate: 1,
        Quantity: 1,
        Customer: 1,
        Product: 1,
        Feedback: 1
    }
}
]);