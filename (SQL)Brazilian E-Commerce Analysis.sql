use e_commerce;

select
count(*) as total_orders
from orders;

select 
order_status,
count(*) as orders_count,
round(count(*)*100.0/(select count(*) from orders),2) as percentage
from orders
group by order_status
order by orders_count desc;

select
round(sum(oi.price),2) as product_revenue,
round(sum(oi.freight_value),2) as freight_revenue,
round(sum(oi.price+oi.freight_value),2) as total_gmv
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered";

select
round(sum(oi.price)/count(distinct o.order_id),2) as AOV
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered";

select
o.order_status,
count(distinct o.order_id) as order_count,
round(sum(oi.price),2) as revenue_lost
from orders o 
join order_items oi on o.order_id = oi.order_id
where o.order_status in ("canceled", "unavailable")
group by o.order_status;

select
year(o.order_purchase_timestamp) as business_year,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as revenue
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by business_year
order by business_year;

select 
c.product_category_name_english as category,
count(oi.order_item_id) as units_sold
from products p 
left join category c on p.product_category_name = c.product_category_name
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = "delivered"
group by category
order by units_sold desc
limit 10;


select 
c.product_category_name_english as category,
round(sum(oi.price),2) as revenue
from products p 
left join category c on p.product_category_name = c.product_category_name
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = "delivered"
group by category
order by revenue desc
limit 10;


select 
c.product_category_name_english as category,
round(sum(oi.price),2) as revenue
from products p 
left join category c on p.product_category_name = c.product_category_name
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = "delivered"
group by category
order by revenue
limit 10;

select 
c.product_category_name_english as category,
count(oi.order_item_id) as units_sold,
round(avg(oi.price),2) as avg_item_price
from products p 
left join category c on p.product_category_name = c.product_category_name
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = "delivered"
group by category
having units_sold >= 50
order by avg_item_price desc
limit 10;


select 
c.product_category_name_english as category,
round(avg(oi.price),2) as avg_item_price,
round(avg(oi.freight_value),2) as avg_freight,
round(sum(oi.freight_value)*100.0/sum(oi.price),2) as freight_to_price_perc
from products p 
left join category c on p.product_category_name = c.product_category_name
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = "delivered"
group by category
having count(*) >= 100
order by freight_to_price_perc desc
limit 10;

with basket as (
select order_id,
count(*) as item_count
from order_items
group by order_id)
select 
case when item_count = 1 then "Single Item" else "Multi Item (2+)" end as order_type,
count(*) as order_count,
round(count(*)*100.0/(select count(*) from basket),2) as percentage
from basket
group by order_type;


select 
coalesce(c.product_category_name_english,"uncategorized")as  category,
count(distinct o.order_id) as total_orders,
sum(case when o.order_status = "canceled" then 1 else 0 end) as canceled_orders,
round(sum(case when o.order_status = "canceled" then 1 else 0 end) * 100.0/count(distinct o.order_id),2) as cancel_rate_pect
from products p 
left join category c on p.product_category_name = c.product_category_name
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
group by category
having total_orders >= 200
order by cancel_rate_pect desc
limit 10;

select
count(distinct c.customer_unique_id) as total_unique_customers
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_status = "delivered";

with buyer_counts as (
select c.customer_unique_id,
count(distinct o.order_id) as orders_placed
from customers c 
join orders o on c.customer_id = o.customer_id
where o.order_status = "delivered"
group by c.customer_unique_id)
select count(*) as total_buyers,
sum(case when orders_placed > 1 then 1 else 0 end) as repeat_buyers,
round(sum(case when orders_placed > 1 then 1 else 0 end)* 100.0/count(*),2) as repeat_rate_pect
from buyer_counts;

select 
c.customer_state,
count(distinct c.customer_unique_id) as unique_customers,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as total_revenue
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by c.customer_state
order by total_revenue desc
limit 10;


select 
c.customer_state,
count(distinct c.customer_unique_id) as unique_customers,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as total_revenue
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by c.customer_state
order by total_orders desc
limit 10;


select 
c.customer_state,
count(distinct c.customer_unique_id) as unique_customers,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as total_revenue
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by c.customer_state
order by unique_customers desc
limit 10;


select 
c.customer_city,
count(distinct c.customer_unique_id) as unique_customers,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as total_revenue
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by c.customer_city
order by total_revenue desc
limit 10;


select 
c.customer_city,
count(distinct c.customer_unique_id) as unique_customers,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as total_revenue
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by c.customer_city
order by total_orders desc
limit 10;


select 
c.customer_city,
count(distinct c.customer_unique_id) as unique_customers,
count(distinct o.order_id) as total_orders,
round(sum(oi.price),2) as total_revenue
from customers c 
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = "delivered"
group by c.customer_city
order by unique_customers desc
limit 10;

select
c.customer_unique_id,
count(distinct o.order_id) as order_count,
round(sum(p.payment_value),2) as lifetime_spend
from customers c 
join orders o on c.customer_id = o.customer_id
join order_payments p on o.order_id = p.order_id
where o.order_status = "delivered"
group by c.customer_unique_id
order by lifetime_spend desc
limit 10;

select
case when order_delivered_customer_date < order_estimated_delivery_date then "On Time" else "Late" end as status,
count(*) as total_orders,
round(count(*)*100.0/(select count(*)from orders where order_status="delivered" and status is not null),2) as perc
from orders
where order_status = "delivered"
group by status;

select
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) as avg_delivery_days
from orders
where order_status="delivered";

select
round(avg(timestampdiff(hour,order_purchase_timestamp,order_approved_at)),1) as avg_approving_hours,
round(avg(datediff(order_delivered_carrier_date,order_approved_at)),1) as avg_handling_days,
round(avg(datediff(order_delivered_customer_date,order_delivered_carrier_date)),1) as avg_carrier_transit_days
from orders
where order_status = "delivered"
and order_delivered_customer_date >= order_delivered_carrier_date;

select
c.customer_state,
count(*) as total_orders,
round(avg(datediff(o.order_delivered_customer_date,o.order_purchase_timestamp)),2) as avg_days,
round(sum(case when order_delivered_customer_date < order_estimated_delivery_date then 0 else 1 end)*100.0/count(*),2)as late_pect
from orders o 
join customers c on o.customer_id = c.customer_id
where o.order_status = "delivered"
group by c.customer_state
having total_orders>=200
order by late_pect desc
limit 10;

select
count(distinct seller_id) as total_sellers
from sellers;

select
seller_state,
count(distinct seller_id) as sellers_count
from sellers
group by seller_state
order by sellers_count desc
limit 5;

select s.seller_id,
round(sum(oi.price),2) as revenue
from order_items oi
join sellers s on oi.seller_id = s.seller_id
group by s.seller_id
order by revenue desc
limit 10;


select s.seller_id,
count(distinct oi.order_id) as order_count
from order_items oi
join sellers s on oi.seller_id = s.seller_id
group by s.seller_id
order by order_count desc
limit 10;

select
s.seller_id,
count(distinct oi.order_id) as total_orders,
round(avg(r.review_score),2) as avg_rating
from order_items oi
join sellers s on oi.seller_id = s.seller_id
join order_reviews r on oi.order_id = r.order_id
group by s.seller_id
having total_orders >=100
order by avg_rating 
limit 10;

select
payment_type,
count(*) as transaction_count,
round(count(*)*100.0/(select count(*) from order_payments where payment_type<>"not_defined"),2) as perc,
round(sum(payment_value),2) as total_value
from order_payments
where payment_type <> "not_defined"
group by payment_type
order by total_value desc;

select
payment_installments,
count(*) as counts,
round(sum(payment_value),2) as total_amount,
round(avg(payment_value),2) as avg_payment_value
from order_payments
where payment_installments >0
group by payment_installments
order by payment_installments;

select review_score,
count(*) as review_count,
round(count(*)*100.0/(select count(*) from order_reviews),2) as pect
from order_reviews
group by review_score
order by review_score desc;

select 
coalesce(c.product_category_name_english,"uncategorized") as category,
count(distinct o.order_id) as total_orders,
round(avg(r.review_score),2) as avg_rating
from order_items oi
join products p on oi.product_id = p.product_id
left join category c on p.product_category_name = c.product_category_name
join orders o on oi.order_id = o.order_id
join order_reviews r on o.order_id = r.order_id
where o.order_status = "delivered"
group by category
having total_orders>=200
order by avg_rating
limit 10;
