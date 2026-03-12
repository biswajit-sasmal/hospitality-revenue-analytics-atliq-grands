-- ============================================================
-- AtliQ Grands Hotel — Data Quality Check (EDA)
-- GOAL: Check all 5 tables for nulls, duplicates & bad data before writing any business analysis queries
-- DATE : 11th March , 2026
-- AUTHOR : Biswajit Sasmal 
-- ============================================================
-- Print All Rows & All Columns from dim_rooms table. 
-- Look at all rows in the table first
-- SQL Code:
select
     *
from dim_rooms;

-- Count total rows and unique values
-- SQL Code:
select
     count(*) as total_rows,
     count(distinct room_id) as total_rooms,
     count(distinct room_class) as total_room_class
from dim_rooms;

-- Check if one room_id maps to more than one room class (bad data)
-- SQL Code:
select
     room_id,
     count(distinct room_class) as total_rooms
from dim_rooms
group by room_id
having count(distinct room_class) > 1;

-- Check if one room class maps to more than one room_id (bad data)
-- SQL Code:
select
     room_class,
     count(distinct room_id) as total_rooms
from dim_rooms
group by room_class
having count(distinct room_id) > 1 ;

-- Check for nulls values in both room_id and room_class column
--SQL Code:
select
     sum(case when room_id is null then 1 else 0 end) as null_room_id,
     sum(case when room_class is null then 1 else 0 end) as null_room_class
from dim_rooms;

-- Print All Rows & All Columns for dim_hotels table
-- Look at all rows in the table first
-- SQL Code:
select
     *
from dim_hotels;

-- Count total rows and unique hotels
-- SQL Code:
select
     count(*) as total_rows,
     count(distinct property_id) as total_property
from dim_hotels;

-- Print all the Different cities where AtliQ Grands Hotels located across india
-- SQL Code:
select
    distinct city as unique_city_list
from dim_hotels;

-- City wise hotels breakdown
-- How many hotels are in each city?
-- SQL Code:
select
     city,
     count(property_id) as total_hotel
from dim_hotels
group by city ;

-- Category Wise Hotels Breakdown
-- How many Luxury vs Business hotels do we have?
-- SQL Code:
select
     category,
     count(distinct property_id) as total_hotels
from dim_hotels
group by category;

-- City & Category Wise hotels breakdown
-- SQL Code:
select
    city,
    category,
    count(property_id) as total_hotels
from dim_hotels
group by city , category
order by city asc , category asc;

-- Check For nulls values for All coumns in dim_hotels table.
-- SQL Code:
select
     sum(case when property_id is null then 1 else 0 end ) as null_property_id,
     sum(case when property_name is null then 1 else 0 end ) as null_property_name,
     sum(case when category is null then 1 else 0 end ) as null_category,
     sum(case when city is null then 1 else 0 end ) as null_city
from dim_hotels;

-- Check for Duplicate values in property_id column
-- SQL Code:
select
    property_id,
    count(distinct property_name) as total_rooms
from dim_hotels
group by property_id 
having count(distinct property_name) > 1;

-- Print All Rows & All Columns from dim_date table.
-- Look at all rows in the table first
-- SQL Code:
select
    *
from dim_date;

-- Check Date range for analysis
-- SQL Code:
select
     min(date) as first_date,
     max(date) as last_date,
     DATEDIFF(day , min(date) , max(date)) + 1  as total_days,
     DATEDIFF(month , min(date) , max(date)) + 1 as total_months
from dim_date;

-- Check for nulls values for all columns in dim_date table.
-- SQL Code:
select
     sum(case when date is null then 1 else 0 end) as null_dates,
     sum(case when mmm_yy is null then 1 else 0 end) as null_mmm_yy,
     sum(case when week_no is null then 1 else 0 end) as null_week_no,
     sum(case when day_type is null then 1 else 0 end) as null_week_days
from dim_date;

-- Print All Rows & All Columns for fact_bookings table.
-- Look at all rows in the table first
-- SQL Code:
select
      *
from fact_bookings;

-- Check For nulls values in fact_bookings table.
-- SQL Code:
select
     sum(case when booking_id is null then 1 else 0 end) as null_booking_id,
     sum(case when booking_date is null then 1 else 0 end) as null_booking_date,
     sum(case when booking_platform is null then 1 else 0 end) as null_booking_platform,
     sum(case when booking_status is null then 1 else 0 end) as null_booking_status,
     sum(case when property_id is null then 1 else 0 end) as null_property_id,
     sum(case when check_in_date is null then 1 else 0 end) as null_check_in_date,
     sum(case when checkout_date is null then 1 else 0 end) as null_checkout_date,
     sum(case when no_guests is null then 1 else 0 end) as null_number_of_guests,
     sum(case when room_category is null then 1 else 0 end) as null_room_category,
     sum(case when ratings_given is null then 1 else 0 end) as null_rating_given,
     sum(case when revenue_generated is null then 1 else 0 end) as null_revenue_generated,
     sum(case when revenue_realized is null then 1 else 0 end) as null_revenue_realized
from fact_bookings;

-- Check for duplicate bookings
-- SQL Code:
select
     count(*) as total_rows,
     count(distinct booking_id) as total_bookings
from fact_bookings;

-- List all possible booking statuses
-- SQL Code:
select
     distinct booking_status as unique_booking_status
from fact_bookings;

-- Print All Booking Platform name list
-- SQL Code:
select
    distinct booking_platform as unique_booking_platform
from fact_bookings;

-- Check for negative number of guests or no guests. 
-- Business Rule Number of guests can't be negative
-- SQL Code:
select
     count(*) as total_rows
from fact_bookings
where no_guests  <= 0;

-- Check min and max guest count to spot any outliers
-- Find Out Maximum and Minimum Number of Guests
-- SQL Code:
select
     min(no_guests) as minimum_number_guests,
     max(no_guests) as maximum_number_of_guests,
     max(no_guests) - min(no_guests) as guests_gap
from fact_bookings;

-- Check for booking_date is greater than check_in_date
-- Check if booking date is AFTER check-in date (impossible situation)
-- SQL Code:
select
     count(*) as total_rows
from fact_bookings
where check_in_date < booking_date;

-- Check For Check_in_date is greater than checkout_date
-- SQL Code:
select
    count(*) as total_rows
from fact_bookings
where  checkout_date < check_in_date; 

-- Print All Rows & All Columns From fact_aggregated_bookings
-- SQL Code:
select
     *
from fact_aggregated_bookings;
-- ============================================================
--  CROSS TABLE CHECK
--  Compare fact_aggregated_bookings vs fact_bookings
--  Both tables track bookings — do they agree with each other?
with manual_table as
(
select
     property_id , 
     check_in_date,
     room_category,
     count(booking_id) as successfull_bookings
from fact_bookings
-- where booking_status in ('No Show' , 'Checked Out')
group by property_id , check_in_date, room_category
)
select
     *
from fact_aggregated_bookings as t1
left join manual_table as t2 
    on t1.property_id = t2.property_id 
    and 
    t1.check_in_date = t2.check_in_date 
    and 
    t1.room_category = t2.room_category
where t1.successful_bookings <> t2.successfull_bookings
-- ==================================================================
-- END OF SQL