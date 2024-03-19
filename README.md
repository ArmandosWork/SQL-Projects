# Car Sales Data Analysis Project - SQL

### Project Overview:
The purpose of this project was to answer several questions concerning the Car Sales of a Dealership Group.

### Data Information:
Dataset obtained as Excel Workbook.

### Analysis Questions:
These were the questions to be answered:
1.	What was the Total Sales for the Dealership Group as a Whole in 2020?
2.	From these Total Sales above, what was the Average Price of Cars sold in 2020?
3.	Which Franchise was the Top Seller and what was its Total Sales amount in 2020?
4.	Which Region was the Top Seller in 2020?
5.	Which were the Top-10 Car Brands/Makes that sold the Most in 2020?
6.	Which Car Model sold the Most in 2020?
7.	What Body Style was the Most Popular in 2020?
8.	What Transmission Type was the Least Popular in 2020? 
9.	What Color was the Most Popular in 2020?
10.	Who was the Customer Buying the Most Expensive Car in 2020?
11.	What was the Annual Income of that Customer? 

### Work Methodology:
- Import, clean and prepare data.
- Write specific queries to answer each question.

### Tools Used:
- **Excel:** The main tool to prepare and clean data.
- **SQL:** Language to write queries.
- **SQL Server / SSMS:** Main tools for analysis, database management and executing SQL queries.
- **Github:** For version control and sharing my work.

### Skills Applied:
- Data Importing, Inspection and Cleaning.
- Writing Queries.
- Working with Aggregates.
- Working with CTE’s.
- Creating Views to store Data for possible Visualization Projects with Tableau or PowerBI.

### Here is a Selection of Some of the Queries Written:
```sql
/* Q3: Which Franchise was the Top Seller and What was its Total Sales Amount in 2020? */
WITH Total_Sales_CTE AS (
	SELECT dealer_name, SUM(price) AS Total_Sales_Amount
	FROM CarSales..Sales
	WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
	GROUP BY dealer_name
)
SELECT TOP 1
	dealer_name AS Top_Seller_Franchise,
    FORMAT(Total_Sales_Amount, 'C') AS Total_Yearly_Sales
FROM Total_Sales_CTE
ORDER BY Total_Sales_Amount DESC
```

```sql
/* Q5: Which were the Top-10 Car Brands/Makes that Sold the Most in 2020? */
SELECT TOP 10 company AS Top_Car_Brands, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY company 
ORDER BY Total_Cars_Sold DESC
```

```sql
/* Create a View to store Data for possible Visualization Project with Tableau or PowerBI. */
CREATE VIEW TopCarBrandsView AS
SELECT TOP 10 company AS Top_Car_Brands, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date < '2021-01-01' -- YYYY-MM-DD Format
GROUP BY company 
ORDER BY Total_Cars_Sold DESC
```

```sql
/* Q10: Who was the Customer Buying the Most Expensive Car in 2020? */
SELECT TOP 1 customer_name AS Customer_Buying_Most_Expensive_Car, 
	MAX(price) AS Purchase_Price
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY customer_name
ORDER BY Purchase_Price DESC
```
