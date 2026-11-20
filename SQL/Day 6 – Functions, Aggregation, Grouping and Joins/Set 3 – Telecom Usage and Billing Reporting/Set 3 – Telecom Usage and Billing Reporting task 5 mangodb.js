// TASK 5

// Hourly Usage

db.usage_events.aggregate([
  {
    $group: {
      _id: {
        hour: { $hour: "$event_time" }
      },
      totalUsageMB: {
        $sum: "$data_used_mb"
      }
    }
  },
  {
    $sort: {
      "_id.hour": 1
    }
  }
]);


// Average Session Length

db.usage_events.aggregate([
  {
    $group: {
      _id: null,
      averageSessionLength: {
        $avg: "$session_length_minutes"
      }
    }
  }
]);


// Busiest Cell Tower

db.usage_events.aggregate([
  {
    $group: {
      _id: "$cell_tower_id",
      totalConnections: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      totalConnections: -1
    }
  },
  {
    $limit: 1
  }
]);