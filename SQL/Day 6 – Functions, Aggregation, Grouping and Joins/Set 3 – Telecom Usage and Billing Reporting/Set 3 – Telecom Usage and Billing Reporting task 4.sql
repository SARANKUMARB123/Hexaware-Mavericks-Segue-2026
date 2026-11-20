-- TASK 4

1. Total Call Minutes Per Plan
Expected Result:
Displays the total number of call minutes used by subscribers for each telecom plan.
Columns:
- Plan Name
- Total Call Minutes

2. Subscribers Exceeding Their Data Limit
Expected Result:
Lists subscribers whose total data usage exceeds the limit defined by their subscribed plan.
Columns:
- Subscriber ID
- Subscriber Name
- Plan Name
- Total Data Used
- Data Limit

3. Month-wise Revenue
Expected Result:
Displays the total revenue generated each month from invoices.
Columns:
- Revenue Month
- Total Revenue

4. Invoices Overdue by More Than 15 Days
Expected Result:
Displays unpaid invoices that are overdue by more than 15 days.
Columns:
- Invoice ID
- Invoice Number
- Subscriber ID
- Due Date
- Amount

5. Subscribers With No Usage
Expected Result:
Lists subscribers who have no call or data usage records.
Columns:
- Subscriber ID
- Subscriber Name

6. Average Revenue Per User (ARPU) by Circle
Expected Result:
Displays the average revenue generated per subscriber in each telecom circle.
Columns:
- Circle
- ARPU

7. Plan Popularity
Expected Result:
Displays the number of subscribers enrolled in each telecom plan.
Columns:
- Plan Name
- Total Subscribers

8. Top 10 Data Consumers
Expected Result:
Displays the ten subscribers with the highest total data usage.
Columns:
- Subscriber ID
- Subscriber Name
- Total Data Used

9. Formatted Invoice Number
Expected Result:
Displays invoice numbers in a standardized format (e.g., INV-00001).
Columns:
- Invoice ID
- Formatted Invoice Number

10. Due-Date Status
Expected Result:
Displays the payment status of each invoice based on the due date and payment date.
Columns:
- Invoice ID
- Invoice Number
- Due Date
- Due-Date Status

11. Days Until Due Date
Expected Result:
Displays the number of days remaining until the invoice due date.
Columns:
- Invoice ID
- Invoice Number
- Days Until Due Date

12. Customer-Friendly Invoice Report
Expected Result:
Displays a formatted invoice report with subscriber details, invoice dates, amount, and payment status.
Columns:
- Invoice ID
- Formatted Invoice Number
- Subscriber Name
- Invoice Date
- Due Date
- Amount
- Due-Date Status

13. NULL Behaviour Using SUM and AVG
Expected Result:
Demonstrates that SUM() and AVG() ignore NULL values. Subscribers without usage records will have NULL values for total and average data usage.
Columns:
- Subscriber ID
- Subscriber Name
- Total Data Usage
- Average Data Usage