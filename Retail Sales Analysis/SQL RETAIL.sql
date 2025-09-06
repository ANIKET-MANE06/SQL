-- RetailSalesDB
create database RetailSalesDB;

-- create table
CREATE TABLE RetailSales ( 
    transaction_id INT PRIMARY KEY, 
    sale_date DATE, 
    sale_time TIME, 
    customer_id INT, 
    gender ENUM('Male', 'Female', 'Others'), 
    age INT, 
    category VARCHAR(20), 
    quantity INT, 
    price_per_unit DECIMAL(10,2), 
    cogs DECIMAL(10,2), 
    total_sale DECIMAL(10,2)
);

-- INSTER DATA
select * from retailsales;

-- Data Explortaion 

-- How Many Sales We Have?
select count(*) as TOTAL_SALES from retailsales;

-- How Many Unique customers We Have?
select count(distinct customer_id) as customer from retailsales;

 -- How Many Uniquue Category We Have?
 select count(distinct Category) as Catagory from retailsales;

 -- Which Uniquue Category We Have?
  select distinct Category as Catagory from retailsales;
  
-- Business key problems
  -- 1.	Retrieve all columns for sales made on '2022-11-05'.
  select * from retailsales where sale_date = '2022-11-05';
  
  -- 2.	Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of November 2022.
SELECT 
  *
FROM retailsales
WHERE 
    category = 'Clothing'
    AND 
	DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantity >= 4;

  -- 3.	Calculate the total sales ( total_sale) for each category.
  select 
		category As CATEGORY,
		sum(total_sale) as NET_SALES,
		count(*) as TOTAL_ORDERS
  from retailsales
  group by 1;
  
  
  -- 4.	Find the average age of customers who purchased items from the 'Beauty' category.
  select round(avg(age), 1) as AVG_AGE from retailsales
  where category = 'Beauty';
  
  -- 5.	Find all transactions where the total_sale is greater than 1000.
  select * from retailsales
  where total_sale > 1000;
  
  -- 6.	Find the total number of transactions (via transaction_id) made, grouped by gender and category.
  select 
  category, 
  gender,
  count(*) as TOTAL_TRANSACTION
  from	retailsales
  group by
  category,
  gender
  order by 1;
  
  -- 7.	Calculate the average sale for each month and determine the best selling month for each year.
select * from
(	  
	  select 
			Extract(year from sale_date) as YEAR,
			extract(month from sale_date) as MONTH,
			AVG(total_sale) As AVG_SALES,
			RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as AVG_SALES_RANK
	  from retailsales
	  group by 1, 2
) as Table1
where AVG_SALES_RANK = 1;

	 
  
  
  -- 8.	Find the top 5 customers based on the highest total sales.
  select 
  customer_id as CUSTOMER,
  sum(Total_sale) As TOTAL_SALES
  from retailsales
  group by 1
  order by TOTAL_SALES desc
  limit 5;
  
  -- 9.	Find the number of unique customers who purchased items in each category.

  select 
  category,
  count(distinct Customer_id) AS UNIQUE_CUSTOMER
  from retailsales
  group by category;

  
  
  -- 10.	Determine shifts and number of orders, with 'Morning' (before 12), 'Afternoon' (12–17), and 'Evening' (>17).

  with Hourly_Sale
  As
  (
 select *,
	case
		when Extract(hour from Sale_time) < 12 then 'MORNING'
        when extract(hour from sale_time) between 12 AND 17 then 'AFTERNOON'
        else 'EVENING'
	end as SHIFT
from retailsales) 
select 
	shift,
    count(*) AS TOTAL_ORDER
from Hourly_sale
group by SHift;

-- END PROJECT