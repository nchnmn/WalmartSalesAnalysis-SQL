# WalmartSalesAnalysis-SQL
This SQL project delves into Walmart's sales data to identify top-performing branches and products, analyze sales trends, and understand customer behavior. 

This project's questions and instructions were sourced from https://github.com/Princekrampah/WalmartSalesAnalysis.

### Walmart Sales Data Dictionary

```markdown
| Field Name             | Description                               | Data Type         |
|------------------------|-------------------------------------------|-------------------|
| invoice_id             | Invoice of the sales made                 | VARCHAR(30)       |
| branch                 | Branch at which sales were made           | VARCHAR(5)        |
| city                   | The location of the branch                | VARCHAR(30)       |
| customer_type          | The type of the customer                  | VARCHAR(30)       |
| gender                 | Gender of the customer making purchase    | VARCHAR(10)       |
| product_line           | Product line of the product sold          | VARCHAR(100)      |
| unit_price             | The price of each product                 | DECIMAL(10,2)     |
| quantity               | The amount of the product sold            | INT               |
| VAT                    | The amount of tax on the purchase         | FLOAT(6,4)        |
| total                  | The total cost of the purchase            | DECIMAL(10,2)     |
| date                   | The date on which the purchase was made   | DATE              |
| time                   | The time at which the purchase was made   | TIMESTAMP         |
| payment_method         | The total amount paid                     | DECIMAL(10,2)     |
| cogs                   | Cost Of Goods Sold                        | DECIMAL(10,2)     |
| gross_margin_percentage| Gross margin percentage                   | FLOAT(11,9)       |
| gross_income           | Gross Income                              | DECIMAL(10,2)     |
| rating                 | Rating                                    | FLOAT(2,1)        |
```
### Approach Used

#### Data Wrangling:
1. Built a database.
2. Created tables and inserted the data.
3. Selected columns with null values, which were filtered out due to setting NOT NULL for each field during table creation.

#### Feature Engineering:
1. Added a new column named `time_of_day` to categorize sales into Morning, Afternoon, and Evening, aiding in analyzing sales trends throughout the day.
2. Added a new column named `day_name` to identify the day of the week for each transaction (Mon, Tue, Wed, Thur, Fri), helping to understand each branch's busiest days.
3. Added a new column named `month_name` to identify the month of the year for each transaction (Jan, Feb, Mar), facilitating analysis of monthly sales and profit trends.

#### Exploratory Data Analysis (EDA):
Conducted exploratory data analysis to address the project's questions and objectives.



### Business Questions To Answer

#### Generic Question
1. How many unique cities does the data have?
2. In which city is each branch located?

#### Product
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the best-selling product line?
4. What is the total revenue by month?
5. Which month had the largest COGS?
6. Which product line had the largest revenue?
7. Which city has the largest revenue?
8. Which product line had the largest VAT?
9. For each product line, add a column indicating "Good" or "Bad" based on whether its sales are greater than the average sales.
10. Which branch sold more products than the average number of products sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?

#### Sales
1. Number of sales made at each time of the day per weekday.
2. Which customer type generates the most revenue?
3. Which city has the largest tax percentage/VAT (Value Added Tax)?
4. Which customer type pays the most in VAT?

#### Customer
1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most customers?
6. What is the gender distribution per branch?
7. At which time of the day do customers give the most ratings?
8. At which time of the day do customers give the most ratings per branch?
9. Which day of the week has the best average ratings?
10. Which day of the week has the best average ratings per branch?
