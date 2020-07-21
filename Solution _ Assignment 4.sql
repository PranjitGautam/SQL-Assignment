/*TASK 1
This database contains Sales details of transaction of a superstore. 
 The structure has 5 tables, namely cust_dimen (containing details about 
 customer and their respective locations), prod_dimen (containing 
 product category and their subcategories), orders_dimen (with order no,
 date, and priority), shipping_dimen (with ship date, order and shipping 
 mode), and market_fact (orderwise customerwise marketwise orderquantity, 
 sales value, discount profit and shipping cost details).

 Upon proper database design these tables will get informationn handy upon 
 querying. These are having dimensions and has facts releated to it. using 
 market_fact we can derive various insights which will aid in helping decisions 
 regarding Product segmentwise sales and profitability, Shipping mode wise 
 profitability etc.

 Base Tables
 1. cust_dimen - Cust_id as Primary Key, no foreign key
 2. prod_dimen - Prod_id as Primary Key, no foreign key 
 3. orders_dimen - Ord_id as Primary Key, although Order_ID is also there but 
	it is advisable to use Ord_id as primary Key to ensure relationship consistency. 
	But Order_ID will as foreign key in shipping_dimen will help retrieve the details
 4. shipping_dimen - Shipping id as primary key and Order_ID as foreign key.
 5. market_fact - Ord_id, Prod_id, Ship_id and Cust_id as foreign key. No Primary Key.
*/
/*TASK 2*/
/* Question 8*/
select c.Region as "Region", c.Customer_Name as "Customer Name", 
		p.Product_Sub_Category as "Product Sub Category", 
        sum(m.Order_Quantity) as "Order Quantity"
from market_fact m 
		join cust_dimen c on m.Cust_id = c.Cust_id
        join prod_dimen p on m.Prod_id = p.Prod_id
where c.Region = "ATLANTIC" and p.Product_Sub_Category = "TABLES"
group by c.Customer_Name
Order by sum(m.Order_Quantity) DESC;
/*Question 7*/
select Region, count(Cust_id) as "No. of Customers"
from cust_dimen
group by Region
order by count(Cust_id) DESC
LIMIT 1;
/*Question 4*/
select round(sum(Sales),2) as "TOTAL SALES", Round(avg(Sales),2) as "AVERAGE SALES"
from market_fact;
/*Question 6*/
select Region, count(Cust_id) as "No. of Customers"
from cust_dimen
group by Region
order by count(Cust_id);
/*Question 13*/
select p.Product_Category as "Product Category", p.Product_Sub_Category as "Product Sub Category",
		round(sum(m.Profit), 2) as "Total Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Sub_Category
Order by p.Product_Category;
/*Question 18*/
select c.Region as "Region",count(m.Ship_id) as "No of Shipments", 
		round(sum(m.Profit),2) as "Profit in each region"
from market_fact m 
		join cust_dimen c on m.Cust_id = c.Cust_id
        join prod_dimen p on m.Prod_id = p.Prod_id
Where Product_Sub_Category = (
				Select p.Product_Sub_Category 
				from market_fact m 
					join prod_dimen p on m.Prod_id = p.Prod_id
					group by Product_Sub_Category
					order by sum(m.Profit)
					LIMIT 1) 
group by c.Region
order by sum(m.Profit);
/*Question 5*/
SELECT MAX(sales), MIN(sales) 
     FROM  maket_fact;
/*Question 15*(1)*/
SELECT Customer_Name  
FROM cust_dimen
WHERE Customer_Name LIKE '_R%';
/*Question 15*(11)*/
SELECT Customer_Name  
FROM cust_dimen
WHERE Customer_Name LIKE '___D%';
/*Question 1*/
SELECT  Customer_Name  AS  CustomerName 
FROM cust_dimen;
SELECT  Customer_Segment  AS  CustomerName 
FROM cust_dimen;
/*Question 2*/
SELECT * FROM cust_dimen
ORDER BY Cust_id DESC;
/*Question 12*/
select p.Product_Category as product_category, sum(m.profit) as profit 
from prod_dimen p inner join market_fact m on p.Prod_id = m.Prod_id 
group by p.Product_Category 
order by profit desc;
/*Question 10*/
select Prod_id, count(*) as no_of_products from market_fact 
group by Prod_id 
order by no_of_products desc;
