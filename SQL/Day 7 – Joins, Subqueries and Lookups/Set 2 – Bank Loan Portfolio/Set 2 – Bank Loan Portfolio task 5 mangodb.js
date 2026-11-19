// Pipeline 1
// Loans with Customer Details

db.loans.aggregate([
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
        LoanID: 1,
        LoanAmount: 1,
        LoanDate: 1,
        CustomerDetails: 1
    }
}
]);

// Pipeline 2
// Loans with Repayment Details

db.loans.aggregate([
{
    $lookup:
    {
        from: "repayments",
        localField: "LoanID",
        foreignField: "LoanID",
        as: "RepaymentHistory"
    }
},
{
    $project:
    {
        _id: 0,
        LoanID: 1,
        LoanAmount: 1,
        RepaymentHistory: 1
    }
}
]);

// Pipeline 3
// Last Repayment for Each Loan

db.loans.aggregate([
{
    $lookup:
    {
        from: "repayments",
        localField: "LoanID",
        foreignField: "LoanID",
        as: "Repayments"
    }
},
{
    $unwind: "$Repayments"
},
{
    $sort:
    {
        "Repayments.PaymentDate": -1
    }
},
{
    $group:
    {
        _id: "$LoanID",
        LoanAmount:
        {
            $first: "$LoanAmount"
        },
        CustomerID:
        {
            $first: "$CustomerID"
        },
        LastRepaymentDate:
        {
            $first: "$Repayments.PaymentDate"
        },
        LastRepaymentAmount:
        {
            $first: "$Repayments.Amount"
        }
    }
},
{
    $sort:
    {
        _id: 1
    }
}
]);