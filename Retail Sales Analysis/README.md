**Retail Sales Analysis SQL Project**

**Project Overview**

**Introduction**
 	
   I worked on this project to apply my SQL skills in a practical way by exploring and analyzing retail sales data. I created a retail sales database, carried out exploratory data analysis (EDA), and wrote SQL queries to answer real business-related questions. Through this process, I was able to practice data cleaning, analysis, and problem-solving using SQL. This project helped me strengthen my foundation in SQL and gain hands-on experience with the kind of tasks a data analyst typically handles.

**Objectives**

•	Database Setup: I created and populated a retail sales database using the given sales data.

•	Data Cleaning: I worked on detecting and removing records that contained missing or null values to ensure data accuracy.

•	Exploratory Data Analysis (EDA): I carried out an initial analysis to get a clear understanding of the dataset and its key patterns.

•	Business Analysis: I used SQL queries to address specific business questions and extract meaningful insights from the sales data.

**1. Database Setup**

•	Database Creation: I began the project by creating a database named retailsalesdb.

•	Table Creation: Within this database, I built a table called retail_sales to store all the sales records. The table structure was designed to capture key details such as transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sales amount.

**2. Data Exploration & Cleaning**

•	Record Count: I started by checking the total number of records available in the dataset to understand its overall size.

•	Customer Count: I identified how many unique customers were present to gauge the customer base.

•	Category Count: I reviewed all distinct product categories to get a sense of the product diversity.

•	Null Value Check: I checked for null or missing values in the dataset and removed any incomplete records to maintain data quality.

**3. Data Analysis & Findings**

As part of the analysis, I created SQL queries to address different business questions and uncover insights from the sales data.

**I.	Business Question:**  Retrieve all columns for sales made on '2022-11-05'.

**a.	SQL Query:**
  
    select * from retailsales 
    	where 
    	sale_date = '2022-11-05';

**II.	Business Question:**  Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of November 2022.

**a.	SQL Query:**

    SELECT 
    *
    FROM retailsales
      WHERE 
        category = 'Clothing'
        AND 
  	    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND
        quantity >= 4;

**III.	Business Question:** Calculate the total sales (total sale) for each category.

**a.	SQL Query:**

    select 
		  category As CATEGORY,
		  sum(total_sale) as NET_SALES,
	  	count(*) as TOTAL_ORDERS
      from retailsales
    group by 1;
  

**IV.	Business Question:** Find the average age of customers who purchased items from the 'Beauty' category.

**a.	SQL Query:**

    select round(avg(age), 1) as AVG_AGE 
  	  from retailsales
  	  where category = 'Beauty';

**V.	Business Question:** Find all transactions where the total sale is greater than 1000.

**a.	SQL Query:**

    select * from retailsales
      where 
      total_sale > 1000;

**VI.	Business Question:** Find the total number of transactions (via transaction id) made, grouped by gender and category.

**a.	SQL Query:**

    select 
      category, 
      gender,
      count(*) as TOTAL_TRANSACTION
      from	retailsales
      group by
      category,
      gender
      order by 1;

**VII.	Business Question:** Calculate the average sale for each month and determine the best-selling month for each year.

**a.	SQL Query:**

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

**VIII.	Business Question:** Find the top 5 customers based on the highest total sales.

**a.	SQL Query:**

    select 
     customer_id as CUSTOMER,
     sum(Total_sale) As TOTAL_SALES
     from retailsales
     group by 1
     order by TOTAL_SALES desc
    limit 5;

**IX.	Business Question:** Find the number of unique customers who purchased items in each category.

**a.	SQL Query:** 

    select 
        category,
        count(distinct Customer_id) AS UNIQUE_CUSTOMER
        from retailsales
        group by category;

**X.	Business Question:** Determine shifts and number of orders, with 'Morning' (before 12), 'Afternoon' (12–17), and 'Evening' (>17).

**a.	SQL Query:** 

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


**Findings**

**•	Customer Demographics:** I observed that the customer base spans multiple age groups, and sales are spread across categories like Clothing, Beauty, and others.

**•	High-Value Transactions:** I identified several premium purchases, with transaction amounts exceeding 1000.

**•	Sales Trends:** By analyzing sales month by month, I was able to spot fluctuations that highlight peak seasons and periods of lower activity.

**•	Customer Insights:** My analysis revealed the top-spending customers along with the product categories that generated the most demand.

Reports

**•	Sales Summary:** I prepared a summary report that highlights overall sales figures, customer demographics, and the performance of different product categories.

**•	Trend Analysis:** I generated insights into monthly sales patterns and also looked at variations across different shifts.

**•	Customer Insights:** I created reports to showcase the top customers and calculated the unique customer counts within each category.

**Conclusion**

Through this project, I was able to put SQL into practice by setting up a database, cleaning raw data, performing exploratory analysis, and writing queries to answer real business questions. The analysis not only gave me hands-on experience but also revealed valuable insights into sales performance, customer behavior, and product trends. These findings demonstrate how SQL can be applied to support better business decision-making.
