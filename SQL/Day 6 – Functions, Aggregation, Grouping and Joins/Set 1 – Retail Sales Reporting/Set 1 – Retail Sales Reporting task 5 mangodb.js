// TASK 5

// Month-wise Sales

db.orders.aggregate([
  {
    $lookup: {
      from: "order_items",
      localField: "order_id",
      foreignField: "order_id",
      as: "items"
    }
  },
  {
    $unwind: "$items"
  },
  {
    $group: {
      _id: {
        year: { $year: "$order_date" },
        month: { $month: "$order_date" }
      },
      totalSales: {
        $sum: {
          $multiply: ["$items.quantity", "$items.unit_price"]
        }
      }
    }
  },
  {
    $sort: {
      "_id.year": 1,
      "_id.month": 1
    }
  }
]);


// Top 5 Products by Revenue

db.order_items.aggregate([
  {
    $lookup: {
      from: "products",
      localField: "product_id",
      foreignField: "product_id",
      as: "product"
    }
  },
  {
    $unwind: "$product"
  },
  {
    $group: {
      _id: "$product.product_name",
      totalRevenue: {
        $sum: {
          $multiply: ["$quantity", "$unit_price"]
        }
      }
    }
  },
  {
    $sort: {
      totalRevenue: -1
    }
  },
  {
    $limit: 5
  }
]);


// Average Basket Value Per City

db.orders.aggregate([
  {
    $lookup: {
      from: "order_items",
      localField: "order_id",
      foreignField: "order_id",
      as: "items"
    }
  },
  {
    $unwind: "$items"
  },
  {
    $group: {
      _id: "$order_id",
      customer_id: { $first: "$customer_id" },
      basketValue: {
        $sum: {
          $multiply: ["$items.quantity", "$items.unit_price"]
        }
      }
    }
  },
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $group: {
      _id: "$customer.city",
      averageBasketValue: {
        $avg: "$basketValue"
      }
    }
  },
  {
    $sort: {
      averageBasketValue: -1
    }
  }
]);