// TASK 5

// Claims Per Status

db.claims_notes.aggregate([
  {
    $group: {
      _id: "$claim_status",
      totalClaims: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      totalClaims: -1
    }
  }
]);


// Average Settlement Time

db.claims_notes.aggregate([
  {
    $match: {
      settlement_date: { $ne: null }
    }
  },
  {
    $group: {
      _id: null,
      averageSettlementDays: {
        $avg: {
          $dateDiff: {
            startDate: "$claim_date",
            endDate: "$settlement_date",
            unit: "day"
          }
        }
      }
    }
  }
]);


// Top Three Damage Categories

db.claims_notes.aggregate([
  {
    $group: {
      _id: "$damage_category",
      totalClaims: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      totalClaims: -1
    }
  },
  {
    $limit: 3
  }
]);