---- Extract Time-Based Features ----
-- To understand how sales vary throughout the day, day of the week, and month, we can create new features from the existing date column:
-- Time of Day: Create a new column named `time_of_day` that categorizes transactions into Morning, Afternoon, or Evening. This will help identify peak sales periods.
-- Day of Week: Create a new column named `day_name` to capture the day of the week (Monday, Tuesday, etc.) for each transaction. This will allow you to analyze which weekdays are busiest for specific branches.
-- Month: Create a new column named `month_name` to show the month (January, February, etc.) for each transaction. This will help determine seasonal sales trends and identify the months with the highest sales and profits.

select time,
(case
    when time between '00:00:00' and '12:00:00' then 'Morning'
    when time between '12:01:00' and '16:00:00' then 'Afternoon'
    else 'Evening'
    END
) as time_of_day
from WalmartSales.dbo.sales;

alter table sales add time_of_day
as (case
    when time between '00:00:00' and '12:00:00' then 'Morning'
    when time between '12:01:00' and '16:00:00' then 'Afternoon'
    else 'Evening'
    END
);

ALTER TABLE sales
ADD day_name as DATENAME(weekday, date);

ALTER TABLE sales
ADD month_name as DATENAME(month, date);

---- Exploratory Data Analysis (EDA) ----
---- Generic Question ----
-- 1. How many unique cities does the data have? --
select 
    distinct city 
from WalmartSales.dbo.sales;

-- 2. In which city is each branch? --
select 
    distinct city, 
    branch
from WalmartSales.dbo.sales;

---- Product and Customer Analysis ----
-- 1. How many unique product lines does the data have? --
select 
    count(distinct Product_line) as Product_count
from WalmartSales.dbo.sales;

 -- 2. What is the most common payment method? --
 select 
    Payment,
    count(Payment) as Payment_count
from WalmartSales.dbo.sales
group by Payment
order by Payment_count desc;

-- 3. What is the most selling product line? --
select 
    Product_line,
    count(Product_line) as Product_count
from WalmartSales.dbo.sales
group by Product_line
order by Product_count desc;

-- 4. What is the total revenue by month? --
select
    month_name,
    round(sum(total),2) as Total_revenue
from WalmartSales.dbo.sales
group by month_name;

-- 5. What month had the largest COGS? --
select
    month_name,
    round(sum(cogs),2) as Total_cogs
from WalmartSales.dbo.sales
group by month_name
order by Total_cogs desc;

-- 6. What product line had the largest revenue? --
select
    Product_line,
    round(sum(total),2) as product_revenue
from WalmartSales.dbo.sales
group by Product_line
order by product_revenue desc;

-- 7. What is the city with the largest revenue? --
select
    city,
    round(sum(total),2) as city_revenue
from WalmartSales.dbo.sales
group by city
order by city_revenue desc;

-- 8. What product line had the largest VAT? --
select
    Product_line,
    round(sum(VAT),2) as product_vat
from WalmartSales.dbo.sales
group by Product_line
order by product_vat desc;

-- 10. Which branch sold more products than average product sold? --
select
    Branch,
    sum(Quantity) as product_sold
from WalmartSales.dbo.sales
group by Branch
having sum(Quantity) > (select sum(Quantity)/count(distinct Branch) from WalmartSales.dbo.sales);

-- 11. What is the most common product line by gender --
select top 3
    Product_line,
    Gender,
    count(*) as total_count
from WalmartSales.dbo.sales
where Gender = 'Female'
group by Product_line, Gender
order by total_count desc;

select top 3
    Product_line,
    Gender,
    count(*) as total_count
from WalmartSales.dbo.sales
where Gender = 'Male'
group by Product_line, Gender
order by total_count desc;

-- 12. What is the average rating of each product line --
select
    Product_line,
    round(avg(Rating),4) as avg_rating
from WalmartSales.dbo.sales
group by Product_line;

-- 13. How many unique customer types does the data have? --
select
    distinct Customer_type
from WalmartSales.dbo.sales;

-- 14. What is the gender of most of the customers? --
select
    Gender,
    count(*) as count_gender
from WalmartSales.dbo.sales
group by Gender
order by count_gender desc;

-- 15. What is the gender distribution per branch? --
select
    Branch,
    Gender,
    count(*) as gender_count
from WalmartSales.dbo.sales
group by Branch, Gender;

-- 16. Which time of the day do customers give most ratings? --
select
    time_of_day,
    round(avg(Rating),4) as avg_rating
from WalmartSales.dbo.sales
group by time_of_day
order by avg_rating desc;

-- 17. Which time of the day do customers give most ratings per branch? --
select
    time_of_day,
    round(avg(Rating),4) as avg_rating
from WalmartSales.dbo.sales
where Branch = 'A'
group by time_of_day
order by avg_rating desc;

select
    time_of_day,
    round(avg(Rating),4) as avg_rating
from WalmartSales.dbo.sales
where Branch = 'B'
group by time_of_day
order by avg_rating desc;

select
    time_of_day,
    round(avg(Rating),4) as avg_rating
from WalmartSales.dbo.sales
where Branch = 'C'
group by time_of_day
order by avg_rating desc;

-- 18. Which day fo the week has the best avg ratings? --
select
    day_name,
    round(avg(Rating), 4) as avg_rating
from WalmartSales.dbo.sales
group by day_name
order by avg_rating desc;

-- 19. Number of sales made in each time of the day per weekday --
with DailyMaxRatings as (
    select
        day_name,
        time_of_day,
        round(avg(Rating),4) as avg_rating,
        row_number() over (partition by day_name order by AVG(Rating) desc) as rn
    from WalmartSales.dbo.sales
    group by day_name, time_of_day
)
select
    day_name,
    time_of_day,
    avg_rating
from DailyMaxRatings
where rn = 1
order by
    case day_name
        when 'Monday' then 1
        when 'Tuesday' then 2
        when 'Wednesday' then 3
        when 'Thursday' then 4
        when 'Friday' then 5
        when 'Saturday' then 6
        when 'Sunday' then 7
    end;

-- 20. Which of the customer types brings the most revenue?--
select
    Customer_type,
    round(sum(Total),2) as total_revenue
from WalmartSales.dbo.sales
group by Customer_type
order by total_revenue desc;

-- 21. Which city has the largest tax/VAT percent? --
select
    City,
    round(avg(VAT),2) as avg_vat
from WalmartSales.dbo.sales
group by City
order by avg_vat desc;

-- 22. Which customer type pays the most in VAT? --
select
    Customer_type,
    round(avg(VAT),2) as avg_vat
from WalmartSales.dbo.sales
group by Customer_type
order by avg_vat desc;


