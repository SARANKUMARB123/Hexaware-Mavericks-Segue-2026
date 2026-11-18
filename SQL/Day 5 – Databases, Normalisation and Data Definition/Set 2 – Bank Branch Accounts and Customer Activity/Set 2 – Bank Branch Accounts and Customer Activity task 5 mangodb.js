// TASK 5: MONGODB CAPPED COLLECTION
use("BankManagementDB");

// Create a capped collection for customer activity logs

db.createCollection("CustomerActivityLogs", {
  capped: true,
  size: 102400,
  max: 1000
});

// Insert 20 activity log documents

db.CustomerActivityLogs.insertMany([
{customerId:1,customerName:"Arun",activity:"Login",activityTime:new Date("2026-11-01T09:00:00")},
{customerId:2,customerName:"Priya",activity:"Login",activityTime:new Date("2026-11-01T09:15:00")},
{customerId:1,customerName:"Arun",activity:"Fund Transfer",activityTime:new Date("2026-11-01T10:00:00")},
{customerId:3,customerName:"Rahul",activity:"Login",activityTime:new Date("2026-11-01T10:15:00")},
{customerId:4,customerName:"Sneha",activity:"Balance Check",activityTime:new Date("2026-11-01T10:30:00")},
{customerId:1,customerName:"Arun",activity:"Login",activityTime:new Date("2026-11-02T08:00:00")},
{customerId:5,customerName:"Vijay",activity:"Login",activityTime:new Date("2026-11-02T08:20:00")},
{customerId:6,customerName:"Meena",activity:"Cash Deposit",activityTime:new Date("2026-11-02T09:00:00")},
{customerId:1,customerName:"Arun",activity:"Bill Payment",activityTime:new Date("2026-11-02T09:30:00")},
{customerId:7,customerName:"Karthik",activity:"Login",activityTime:new Date("2026-11-02T10:00:00")},
{customerId:8,customerName:"Anitha",activity:"Login",activityTime:new Date("2026-11-02T10:30:00")},
{customerId:1,customerName:"Arun",activity:"Login",activityTime:new Date("2026-11-03T09:00:00")},
{customerId:9,customerName:"Suresh",activity:"Fund Transfer",activityTime:new Date("2026-11-03T09:20:00")},
{customerId:10,customerName:"Deepa",activity:"Login",activityTime:new Date("2026-11-03T09:40:00")},
{customerId:1,customerName:"Arun",activity:"Balance Check",activityTime:new Date("2026-11-03T10:00:00")},
{customerId:2,customerName:"Priya",activity:"Cash Withdrawal",activityTime:new Date("2026-11-03T10:20:00")},
{customerId:3,customerName:"Rahul",activity:"Login",activityTime:new Date("2026-11-03T10:40:00")},
{customerId:1,customerName:"Arun",activity:"Login",activityTime:new Date("2026-11-04T09:00:00")},
{customerId:5,customerName:"Vijay",activity:"Bill Payment",activityTime:new Date("2026-11-04T09:30:00")},
{customerId:1,customerName:"Arun",activity:"Login",activityTime:new Date("2026-11-04T10:00:00")}
]);

// Display all activity logs

db.CustomerActivityLogs.find();

// Display the last five login events of customer Arun

db.CustomerActivityLogs.find({
    customerName: "Arun",
    activity: "Login"
})
.sort({activityTime:-1})
.limit(5);