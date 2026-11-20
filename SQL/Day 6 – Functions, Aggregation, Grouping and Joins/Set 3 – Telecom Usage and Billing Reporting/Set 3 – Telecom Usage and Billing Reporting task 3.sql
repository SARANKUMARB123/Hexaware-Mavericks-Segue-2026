-- TASK 3

Demonstrating the Effect of NULL on SUM and AVG

When a subscriber has no matching usage record, the usage values become NULL after a LEFT JOIN.

- SUM(column) ignores NULL values while calculating the total.
- AVG(column) ignores NULL values when calculating the average.
- If every value is NULL, both SUM() and AVG() return NULL.

Example Query

SELECT
    s.subscriber_id,
    s.subscriber_name,
    SUM(cr.data_used_mb) AS total_data_usage,
    AVG(cr.data_used_mb) AS average_data_usage
FROM subscribers s
LEFT JOIN call_records cr
ON s.subscriber_id = cr.subscriber_id
GROUP BY
    s.subscriber_id,
    s.subscriber_name;

Explanation

- Subscribers with usage records will display the total and average data usage.
- Subscribers without any usage records will have NULL for both Total Data Usage and Average Data Usage because there are no values to aggregate.
- NULL values are ignored by SUM() and AVG() and are not treated as zero.