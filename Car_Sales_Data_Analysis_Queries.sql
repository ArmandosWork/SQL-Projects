/** Car Sales Data Analysis Project by Armando Lopez - March 18, 2024 **/

/*********************************************************************
NOTE: In some of the queries below I used: FORMAT(SUM(price), 'C'). 
'C' specifies Currency style for amount results (ie. $300,340,345.00).
**********************************************************************/

/* Q1: What was the Total Sales for the Dealership Group as a Whole in 2020? */
SELECT 
	FORMAT(SUM(price), 'C') AS Total_Sales_For_Dealership_Group 
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format

--

/* Q2: From these Total Sales above, What was the Average price of Cars sold in 2020? */
SELECT 
	FORMAT(AVG(price), 'C') AS Avg_Price_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format

--

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

--

/* Q4: Which Region was the Top Seller and what was its Total Sale Amount in 2020? */
SELECT TOP 1 dealer_region AS Top_Seller_Dealer_Region,
	FORMAT(SUM(price), 'C') AS Total_Sales
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY dealer_region
ORDER BY Total_Sales DESC

--

/* Q5: Which were the Top-10 Car Brands/Makes that Sold the Most in 2020? */
SELECT TOP 10 company AS Top_Car_Brands, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY company 
ORDER BY Total_Cars_Sold DESC

/* Creating a View for possible Visualization Project with Tableau or PowerBI: */
CREATE VIEW TopCarBrandsView AS
SELECT TOP 10 company AS Top_Car_Brands, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date < '2021-01-01' -- YYYY-MM-DD Format
GROUP BY company 
ORDER BY Total_Cars_Sold DESC

--

/* Q6: Which Car Model sold the Most in 2020? */
SELECT TOP 1 model AS Top_Car_Model, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY model 
ORDER BY Total_Cars_Sold DESC

--

/* Q7: What Body Style was the Most Popular in 2020? */
SELECT TOP 1 body_style AS Most_Popular_Body_Style, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY body_style 
ORDER BY Total_Cars_Sold DESC

--

/* Q8: What Transmission Type was the Least Popular in 2020?  */
SELECT TOP 1 transmission AS Least_Popular_Transmission_Type,
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY transmission 
ORDER BY Total_Cars_Sold ASC

--

/* Q9: What Color was the Most Popular in 2020?  */
SELECT TOP 1 color AS Most_Popular_Car_Color, 
	COUNT(*) AS Total_Cars_Sold
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY color 
ORDER BY Total_Cars_Sold DESC

--

/* Q10: Who was the Customer Buying the Most Expensive Car in 2020? */
SELECT TOP 1 customer_name AS Customer_Buying_Most_Expensive_Car, 
	MAX(price) AS Purchase_Price
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
GROUP BY customer_name
ORDER BY Purchase_Price DESC

--

/* Q11: What is the Annual Income of that Customer? */
SELECT customer_name AS Customer_Buying_Most_Expensive_Car, 
	FORMAT(annual_income, 'C') AS Annual_Income
FROM CarSales..Sales
WHERE date BETWEEN '2020-01-01' AND '2020-12-31' -- YYYY-MM-DD Format
	AND customer_name = 'Dariel'
	AND price = 85800