create database zomato;
use zomato;

## number of Resturants based on city .
select city,count(restaurantid) from mains group by city;

## number of Resturants based on  country
select countryname,count(restaurantid) from mains left join country on CountryCode=CountryID group by countryname;

##Total resturants open yearwise
select distinct year ,count(*) from mains group by year;

##Total resturants open monthwise.
select distinct Month ,count(*) from mains group by Month;

##Total resturants open monthwise.
WITH QR AS (
  SELECT 
    *,
    CASE
      WHEN Month BETWEEN 1 AND 3 THEN 'Q1'
      WHEN Month BETWEEN 4 AND 6 THEN 'Q2'
      WHEN Month BETWEEN 7 AND 9 THEN 'Q3'
      WHEN Month BETWEEN 10 AND 12 THEN 'Q4'
      ELSE 'Unknown'
    END AS Quarter
  FROM mains
)
SELECT
  Quarter,
  COUNT(*) AS Restaurants_Opened
FROM QR
GROUP BY Quarter
ORDER BY FIELD(Quarter, 'Q1', 'Q2', 'Q3', 'Q4', 'Unknown');

## Pecentage of Resturants based on "Has Table booking"
select has_table_booking,count(*) as totalRestaurants,
round((count(*)/(select count(*) from mains))*100,2) as Percentage from mains group by Has_Table_booking;

## Pecentage of Resturants based on "Has online delivery"
select has_online_delivery,count(*) as totalRestaurants,
round((count(*)/(select count(*) from mains))*100,2) as Percentage from mains group by has_online_delivery;

## count of Resturants based on Ratings
select rating as individualrating,count(*) as Restaurantcount from mains 
 where rating is not null group by rating order by rating desc;
 
 ## find Total Cuisines
 select cuisines,count(cuisines) from mains group by Cuisines;
 
 ##find cost bucket list and restauarant comes under bucket
 select cost_range,count(*) as totalrestaurants 
   from(select case when average_cost_for_two between 0 and 300 then '0-300'
                     when average_cost_for_two between 301 and 600 then '301-600'
                      when average_cost_for_two between 600 and 1000 then '601-1000'
                       when average_cost_for_two between 1001 and 430000 then '1001-430000'
                       else 'other'
                       end as cost_range
                       from mains)as sunquery group by cost_range;
                       
                       
