// Pipeline 1
// Shipments with Delivery Events

db.shipments.aggregate([
{
    $lookup:
    {
        from: "deliveryevents",
        localField: "ShipmentID",
        foreignField: "ShipmentID",
        as: "DeliveryEvents"
    }
},
{
    $project:
    {
        _id: 0,
        ShipmentID: 1,
        CustomerID: 1,
        CarrierID: 1,
        HubID: 1,
        ShippingCost: 1,
        DeliveryEvents: 1
    }
}
]);

// Pipeline 2
// Customers with their Shipments

db.customers.aggregate([
{
    $lookup:
    {
        from: "shipments",
        localField: "CustomerID",
        foreignField: "CustomerID",
        as: "Shipments"
    }
},
{
    $project:
    {
        _id: 0,
        CustomerID: 1,
        CustomerName: 1,
        City: 1,
        Shipments: 1
    }
}
]);

// Pipeline 3
// Carriers with Delay Statistics

db.carriers.aggregate([
{
    $lookup:
    {
        from: "shipments",
        localField: "CarrierID",
        foreignField: "CarrierID",
        as: "ShipmentDetails"
    }
},
{
    $unwind: "$ShipmentDetails"
},
{
    $group:
    {
        _id: "$CarrierName",
        TotalShipments:
        {
            $sum: 1
        },
        AverageDelay:
        {
            $avg: "$ShipmentDetails.DelayDays"
        },
        MaximumDelay:
        {
            $max: "$ShipmentDetails.DelayDays"
        },
        MinimumDelay:
        {
            $min: "$ShipmentDetails.DelayDays"
        }
    }
},
{
    $sort:
    {
        AverageDelay: -1
    }
}
]);