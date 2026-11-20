Brazilian E-Commerce Supply Chain & Customer Retention Analytics
An end-to-end data analytics project analyzing 99,441 orders from the Olist Brazilian marketplace (2016–2018) using Python, MySQL, and Power BI to uncover how delivery delays impact customer ratings and how buyer retention can be improved.
Tech Stack & Workflow
Python (Pandas): Explored 9 relational tables (~1.5M+ total rows), imputed missing product dimensions with column medians, labeled missing categories as uncategorized, and removed free-text review columns (review_comment_title, review_comment_message) to ensure clean CSV parsing into MySQL.
MySQL: Executed 35 targeted SQL queries covering order status, revenue trends, category performance, freight burden, customer geography, delivery stages, seller ratings, and payment installments.
Power BI: Built a Star Schema with 3 calculated tables (Dim_date, _Measures, Dim_customer_rfm), 4 calculated columns, and 17 DAX measures powering an interactive 3-page dashboard.
Dashboard Overview
1. Executive Overview: Tracks R$13.22M in product revenue (R$15.42M GMV), 96,478 delivered orders, R$137.04 AOV, monthly trends, payment shares, and top revenue categories/states.
2. Logistics & SLA: Analyzes the 91.89% on-time delivery rate, 12.50-day average transit time, 16.63% freight ratio, state-level delay hotspots (AL at 23.93%, MA at 19.67%), and the sharp rating drop on late deliveries.
3. Customers & Sellers: Evaluates the 3.00% repeat purchase rate, R$141.62 Customer LTV, 3,095 active sellers, and RFM customer segmentation (Recent One-Timers, Churned One-Timers, At-Risk High Value, Loyal Repeaters, Champions).
Key Insights & Recommendations
97% One-Time Buyers (2,801 repeat buyers out of 93,358): Send automated discount coupons 2–3 weeks post-delivery to drive repeat orders, and target the 8,213 At-Risk High Value customers (R$3.66M revenue) with win-back offers.
Late Deliveries Crush Reviews (8.11% late rate): On-time orders average 4.3 stars (only 6.60% 1-star reviews), whereas late orders drop to 2.6 stars (46.16% 1-star reviews). Penalize late-shipping sellers, reward reliable sellers with a "Fast Delivery" badge, and add regional hubs in the North/Northeast.
90.06% Single-Item Orders & High Shipping Burden: Offer free shipping on multi-item carts and co-fund freight on high-margin categories where shipping exceeds 25%–36% of item price (Christmas Supplies, Electronics, Furniture).
High-Ticket Installment Dependence: Credit cards drive 73.92% of transactions (R$12.54M), with 10-installment plans averaging R$415.09 vs. R$112.42 for single payments.
Repository Structure
REPORT Brazilian E-Commerce Ananysis.pdf — Complete project documentation, SQL outputs, DAX formulas, and dashboard screenshots
/sql — MySQL queries for sales, logistics, customer, and seller analysis
/powerbi — Interactive .pbix dashboard file
