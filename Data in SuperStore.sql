# QUESTION 1
#How many sales and the total sales occured in every country?
SELECT
	Country,
    COUNT(Sales) Number_of_Sales,
    SUM(Sales) Total_Sales
FROM superstore
GROUP BY Country;

-- Question 2 Which top 10 countries had the highest total sales?
 SELECT
	Country,
    COUNT(Sales) Number_of_Sales,
    SUM(Sales) Total_Sales
FROM superstore
GROUP BY Country
ORDER BY Total_Sales DESC LIMIT 10;

-- Question 3:What is the %sales of each country to the total sales?
  SELECT
	Country,
    COUNT(Sales) Number_of_Sales,
    SUM(Sales) Total_Sales,
    ROUND(SUM(Sales) * 100 /(SELECT SUM(Sales) FROM superstore1),2) Sales_Percent
FROM superstore
GROUP BY Country
WITH ROLLUP
ORDER BY Sales_Percent DESC;

-- QUESTION 4: What is the average profit made per country?
SELECT
	Country,
    ROUND(AVG(Sales),2) Average_Sales,
    SUM(Sales) Total_Sales
FROM superstore
GROUP BY Country;

-- Question 5: What is the number of sales made per year?
 SELECT
	Year,
    COUNT(Sales) Number_of_Sales
FROM superstore
GROUP BY Year;

-- Question 6: What is the percentage of profit per market? 
SELECT 
	market,
    ROUND(SUM(profit)) Profit,
    ROUND(SUM(profit) * 100 / (SELECT(SUM(profit)) FROM superstore1), 2) Profit_Percent
FROM superstore
group by market
WITH ROLLUP;

-- Question 7: What is the shipping cost and sales made for every category where year is 2012?
SET @Exact_Year:='2011';

SELECT 
	Category,
    year,
    round(sum(Shipping_Cost), 2) Shipping_Cost,
    round(sum(Sales), 2) Sales
FROM superstore
WHERE year = @Exact_Year
group by year, Category
ORDER BY Year, Sales desc;

-- Question 8:Can we identify any trend of sales based on customer name and market.
SELECT 
	Customer_Name,
    Market,
    sales,
    count(Customer_Name) Number_of_times_Customer_Orders,
    CASE 
		when  count(Customer_Name) < 30 then 'Low'
        when  count(Customer_Name) BETWEEN 30 and 70 then 'moderate'
        else 'high'
	end cond,
	year
FROM superstore
where market like 'US'
group by Customer_Name, Market
having cond = 'moderate'
order by sales desc;

-- Question 9: Top 20 Customers based on the sales for a specific market
SET @Market := 'Africa';
SELECT 
	Customer_Name,
    Market,
    SUM(Sales) Sales
FROM superstore
WHERE Market = @Market
GROUP BY Customer_Name
ORDER BY Sales DESC
LIMIT 20;