/*
================================================================================
PROJECT : AtliQ Grands Hotel — Business Revenue Analysis( Hospitality Domain)
DATE : 11th March , 2026
RDBMS : SQL SERVER MANAGEMENT STUDIO(SSMS)
DATABASE : AtliQ_Hotel_Bookings_DB
AUTHOR : Biswajit Sasmal
================================================================================
*/
-- Task 1:- What is the total revenue generated vs total revenue realized across all hotels?
-- SQL Code:
select
     round(cast(sum(revenue_generated) as float) / 1000000 , 2) as total_revenue_generated_mln_inr,
     round(cast(sum(revenue_realized) as float) / 1000000 , 2) as total_revenue_realized_mln_inr,
     round(cast((sum(revenue_generated) - sum(revenue_realized)) as float) / 1000000 , 2) as revenue_lost_mln_inr
from fact_bookings;
-- Combine Result --
-- SQL Code:
select
     'Total Revenue Generated (in Millions INR)' as metric_list,
     round(cast(sum(revenue_generated) as float) / 1000000 , 2) as metric_value
from fact_bookings
union
select
     'Total Revenue Realized (in Millions INR)' as metric_list,
     round(cast(sum(revenue_realized) as float) / 1000000 , 2) as metric_value
from fact_bookings
union
select
     'Total Revenue Lost (in Millions INR) Due to Cancellation' as metric_list,
      round(cast((sum(revenue_generated) - sum(revenue_realized)) as float) / 1000000 , 2) as metric_value
from fact_bookings
union
select
     'Revenue Lost (%) Due to Cancellation' as metric_list,
     round(cast(sum(revenue_generated) - sum(revenue_realized) as float) *100 / sum(revenue_generated) , 2) as metric_value
from fact_bookings     

-- Task 2:- What is the total revenue generated (revenue_realized) for each of our hotel properties?
-- SQL Code:

select
     h.property_name,
     round(cast(sum(fb.revenue_realized) as float) / 1000000 , 2) as total_revenue_realized_in_mln_inr
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.property_name
order by total_revenue_realized_in_mln_inr desc;

-- Task 3: - Which city is generating the highest revenue?
--SQL Code:
select
     h.city,
     round(cast(sum(fb.revenue_realized) as float) / 1000000 , 2) as total_revenue_realized_in_mln_inr
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by  h.city
order by total_revenue_realized_in_mln_inr desc;

-- Task 4: - Show me the total number of bookings that were successfull, property-wise.
-- SQL Code:
select
     h.property_name,
     count(case when fb.booking_status in ('Checked Out' , 'No Show') then fb.booking_id else null end) as total_successfull_bookings
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.property_name 
order by total_successfull_bookings desc;

-- Task 5: - Which hotel category (Luxury or Business) earns more revenue?
-- SQL Code:
select
     h.category as property_category,
     round(cast(sum(fb.revenue_realized) as float) / 1000000 , 2) as total_revenue_realized_mln_inr
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.category
order by total_revenue_realized_mln_inr desc ;

-- Task 6:- What is the monthly revenue trend? Is it going up or down?
-- SQL Code:

select
     d.mmm_yy,
     round(cast(sum(revenue_realized) as float) / 1000000 , 2) as total_revenue_realized_mln_inr,
     coalesce(round(cast((sum(revenue_realized) - lag(sum(revenue_realized)) over(order by d.mmm_yy asc)) as float) * 100 / lag(sum(revenue_realized)) over(order by d.mmm_yy asc) , 2) , 0) as mom_revenue_change 
from dim_date as d
left join fact_bookings as fb on d.date = fb.check_in_date
group by d.mmm_yy 
order by d.mmm_yy asc;

-- Task 7: - What is the average rating given by customers for each property category (Luxury vs. Business)?
-- SQL Code:
select
     h.category,
     round(avg(fb.ratings_given) , 2) as average_rating
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
where booking_status in ('No Show' , 'Checked Out')
group by h.category
order by average_rating desc ;

-- Task 8: - What is the overall occupancy percentage for each hotel?
-- SQL Code:
select
     h.property_name,
     round(cast(sum(fab.successful_bookings) as float) * 100 / sum(fab.capacity) , 2) as occupancy_rate
from dim_hotels as h
left join fact_aggregated_bookings as fab on h.property_id = fab.property_id
group by h.property_name
order by occupancy_rate desc ;

-- Task 9 : - Show the occupancy percentage for each room class  across all hotels.
-- SQL Code:
select
     r.room_class,
     round(cast(sum(fab.successful_bookings) as float) * 100 / sum(fab.capacity) , 2) as occupancy_rate
from dim_rooms as r
left join fact_aggregated_bookings as fab on r.room_id = fab.room_category
group by r.room_class 
order by occupancy_rate desc;

-- Task 10 :- Is occupancy higher on weekends or weekdays?
-- SQL Code:

select
     (case when datename(weekday , cast(d.date as date)) in ('Friday' , 'Saturday') then 'Weekend' else 'Weekday' end ) as day_type,
     round(cast(sum(fab.successful_bookings) as float) * 100 / sum(fab.capacity) , 2) as occupancy_rate
from dim_date as d
left join fact_aggregated_bookings as fab on d.date = fab.check_in_date
group by (case when datename(weekday , cast(d.date as date)) in ('Friday' , 'Saturday') then 'Weekend' else 'Weekday' end )
order by occupancy_rate desc;

-- Task 11 : - Compare the total successful bookings for weekdays vs. weekends.
-- SQL Code:
select
     (case when datename(weekday , cast(d.date as date)) in ('Friday' , 'Saturday') then 'Weekend' else 'Weekday' end ) as day_type,
     count(fb.booking_id) as total_successfull_bookings
from dim_date as d
left join fact_bookings as fb on d.date = fb.check_in_date
where fb.booking_status in ('Checked Out' , 'No Show')
group by  (case when datename(weekday , cast(d.date as date)) in ('Friday' , 'Saturday') then 'Weekend' else 'Weekday' end )
order by total_successfull_bookings desc;

-- Task 12: - What is the overall cancellation rate?
-- SQL Code:

select
     round(cast(count(case when booking_status = 'Cancelled' then booking_id else null end) as float) *100 / count(*) , 2) as cancellation_rate
from fact_bookings; 

-- Task 13: - Which booking platform has the highest cancellation rate?
-- SQL Code:

select
     booking_platform,
     round(cast(count(case when booking_status = 'Cancelled' then booking_id else null end) as float) *100 / count(*) , 2) as cancellation_rate
from fact_bookings
group by booking_platform
order by cancellation_rate desc;

-- Task 14: - What is the cancellation rate for each hotel?
--SQL Code:
select
     h.property_name,
     round(cast(count(case when booking_status = 'Cancelled' then booking_id else null end) as float) *100 / count(*) , 2) as cancellation_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.property_name
order by cancellation_rate desc;

-- Task 15:- What is the realisation percentage for each property?
-- SQL Code:

select
     h.property_name,
     round(cast(count(case when booking_status = 'Checked Out' then booking_id else null end) as float) *100 / count(*) , 2) as realisation_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.property_name
order by realisation_rate desc;

-- Task 16: - What is the total successful bookings broken down by week number?
-- SQL Code:
select
    week_no , 
    total_successfull_bookings,
    coalesce(round(cast((total_successfull_bookings - lag(total_successfull_bookings) over(order by week_no asc)) as float) * 100 / lag(total_successfull_bookings) over(order by week_no asc) , 2) , 0) as wow_successfull_bookings_change
from (select
         d.week_no,
         count(case when booking_status in ('Checked Out' , 'No Show') then booking_id else null end) as total_successfull_bookings
    from dim_date as d
    left join fact_bookings as fb on d.date = fb.check_in_date
    group by d.week_no ) as t;

-- Task 17 : - Calculate the Average Daily Rate (ADR) for each hotel.
-- SQL Code:
-- Solutuion 1: -
select
     h.property_name,
     round(cast(sum(fb.revenue_realized) as float) / count(fb.booking_id) , 2) as average_daily_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.property_name
order by h.property_name asc;

-- Solution 2: -
select
     h.property_name,
     round(cast(sum(fb.revenue_realized) as float) / sum(datediff(day , fb.check_in_date  , fb.checkout_date)) , 2) as average_daily_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
where fb.booking_status in ('Checked Out' , 'No Show')
group by h.property_name
order by h.property_name asc;


-- Task 18:- Calculate the Revenue per Available Room (RevPAR) for each hotel.
-- SQL Code:
with hotel_capacity as 
(
select
     h.property_name,
     sum(fab.capacity) as total_capacity
from dim_hotels as h
left join fact_aggregated_bookings as fab on h.property_id = fab.property_id
group by h.property_name
),
hotel_revenue_generated as
(
select
     h.property_name,
     sum(fb.revenue_generated) as total_revenue
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.property_name
)
select
     t1.property_name,
     t1.total_capacity,
     t2.total_revenue,
     round(cast(t2.total_revenue as float) / t1.total_capacity , 2) as revenue_per_available_room
from hotel_capacity as t1
join hotel_revenue_generated as t2 on t1.property_name = t2.property_name
order by revenue_per_available_room desc;

-- Task 19:- Compare the ADR of 'Luxury' vs. 'Business' hotels.
-- SQL Code:
-- Solution 1:- 
select
     h.category,
     round(cast(sum(fb.revenue_realized) as float) / count(fb.booking_id) , 2) as average_daily_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
group by h.category ;

-- Solution 2 : -
select
     h.category,
     round(cast(sum(fb.revenue_realized) as float) / sum(datediff(day , fb.check_in_date , fb.checkout_date)) , 2) as average_daily_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id
where fb.booking_status in ('Checked Out' , 'No Show')
group by h.category ;

-- Task 20: - What is the most popular room category (by successful_bookings) for each city?
-- SQL Code:
select
     city,
     room_class as most_popular_room_category
from (select
             h.city,
             r.room_class,
             count(fb.booking_id) as successfull_bookings,
             dense_rank() over(partition by h.city order by count(fb.booking_id) desc) as room_category_rank
        from dim_hotels as h
        join fact_bookings as fb on h.property_id = fb.property_id
        join dim_rooms as r on fb.room_category = r.room_id
        where fb.booking_status in ('Checked Out' , 'No Show')
        group by h.city, r.room_class ) as t
where room_category_rank = 1 ;

-- Task 21 : - Create a summary report showing for each property: Total Bookings, Total Revenue, Average Rating, and Cancellation Rate.
-- SQL Code:
select
     h.property_name,
     count(fb.booking_id) as total_bookings,
     round(cast(sum(fb.revenue_realized) as float) / 1000000 , 2) as total_revenue_mln_inr,
     round(avg(fb.ratings_given) , 2) as average_rating,
     count(case when fb.booking_status in ('Checked Out' , 'No Show') then fb.booking_id else null end) as total_successfull_bookings,
     round(cast(count(case when fb.booking_status in ('No Show' , 'Checked Out') then fb.booking_id else null end) as float) * 100 / count(*) , 2) as successfull_bookings_rate,
     count(case when fb.booking_status = 'Cancelled' then fb.booking_id else null end) as total_cancelled_bookings,
     round(cast(count(case when fb.booking_status = 'Cancelled' then fb.booking_id else null end) as float) * 100 / count(*) , 2) as cancellation_rate
from dim_hotels as h
left join fact_bookings as fb on h.property_id = fb.property_id 
group by h.property_name
order by average_rating asc;


-- ===============================================================================================
-- END OF SQL 



