-- All Records where customers last name is not Young
SELECT *
FROM CUSTOMERS
WHERE CONTACTLASTNAME <> 'Young';

-- Show Custoername, First Name, Last Name, Phone, City & Country where First name is Julie and she is from USA
SELECT customerName, contactFirstName, contactLastName, phone, city, country
FROM customers
where country = 'USA' and contactFirstName ='Julie';

-- First Name and Last name for customers from Norway or Sweden:
SELECT contactFirstName, contactLastName, city, country
FROM customers
where country = 'Norway'
or country ='Sweden';

-- show all columns for customers from the USA with surname Brown
SELECT *
FROM CUSTOMERS
where country = 'USA'  
and ContactLastName = 'Brown';

-- For employees who are sales reps, display their email.
SELECT email
FROM employees
where jobTitle = 'Sales Rep';

-- Upper and Lower Convert
-- Lower() - Convert a string to lowercase
SeleCt * from classicmodels.employees
where lower(FirstName) = 'leslie';

-- upper () Convert a stiring to uppercase
Select *
From classicmodels.employees
where upper(Email) = "DMURPHY@CLASSICMODELCARS.COM";

-- NOT IN() - PUT MULTIPLE CONDITIONS IN BRACKETS  - WILL EXCLUDE THESE
SELECT *
FROM classicmodels.employees
where upper(email) NOT IN
('PMARSH@CLASSICMODELCARS.COM',
'GBONDUR@CLASSICMODELCARS.COM',
'ABOW@CLASSICMODELCARS.COM');

-- IN() - PUT MULTIPLE CONDITIONS IN BRACKETS  - WILL INCLUDED THESE
SELECT *
FROM classicmodels.employees
where upper(email) IN
('PMARSH@CLASSICMODELCARS.COM',
'GBONDUR@CLASSICMODELCARS.COM',
'ABOW@CLASSICMODELCARS.COM');


/* Show all columns for customers who are from New York, London or Mumbai using IN

A table named Customer has been created.

Display all columns for customers who's cust_city in in any of the following:

New York

London

Mumbai

select *
from customer
where Cust_city in ('New York', 'London', 'Mumbai');
*/

-- Distint
-- used before the column name to provide a unique list

-- Eg. Unique list of counties in the customer table

Select distinct country
from customers;

-- Like
-- % - used a Wildcard character
-- where city like '%New%'

-- Can be used anywhere, % represnets anything
-- where EmailAddress Like 'classicmodel%'

Select *
from customers
where city like '%New%';

-- Order By
Select *
From classicmodels.employees
order by lastName;

Select *
From classicmodels.employees
order by lastName, firstName desc;

-- Order the results of our query by any column name using the order by function

-- If you want the results in dexcending order, you need to add desc after the column name. Otherwise SQL will return them in ascending order

SELECT distinct orderdate
FROM classicmodels.orders
order by orderdate;

SELECT distinct customerNumber
FROM classicmodels.customers;

SELECT *
FROM classicmodels.orders
where comments like '%negotiate%';

/*
-- Inner Join, Left Join, and Right Join
Inner Join
- Retuns only matching rows
Select column1, column2 etc.
From table1
inner join table2
on table1.key = table2.key
*/

Select *
from orders T1
inner join customers t2 -- if you forgot to add inner sql will take as inner join
on t1.customernumber = t2.customernumber;

/*
Left Join
- Retuns all returns from the first table, and any matching record from the secound table.
 
- If there are no matching records, it will return NULL for the coulums from the second table.
*/

-- Example
SELECT
FIRSTNAME,
LASTNAME,
CUSTOMERNAME
FROM CLASSICMODELS.EMPLOYEES T1
LEFT JOIN CLASSICMODELS.CUSTOMERS T2
ON T1.EMPLOYEENUMBER - T2.SALESREPEMPLOYEENUMBER;

-- to bring all
SELECT *
FROM CLASSICMODELS.EMPLOYEES T1
LEFT JOIN CLASSICMODELS.CUSTOMERS T2
ON T1.EMPLOYEENUMBER - T2.SALESREPEMPLOYEENUMBER
where t2.customernumber is null
and jobtitle = 'sales Rep';

/*
Righ Join
- Works similarly to Left Join, but will return all rows from the second table listed,
  and any matching row from the first table.
*/

-- Example
SELECT
FIRSTNAME,
LASTNAME,
CUSTOMERNAME
FROM CLASSICMODELS.EMPLOYEES T2
LEFT JOIN CLASSICMODELS.CUSTOMERS T1
ON T2.EMPLOYEENUMBER - T1.SALESREPEMPLOYEENUMBER;

-- all
SELECT *
FROM classicmodels.customers A
inner join classicmodels.payments B
on A.customerNumber = B.customerNumber;

-- certain rows
SELECT A.customerName, B.amount, B.paymentDate
FROM classicmodels.customers A
inner join classicmodels.payments B
on A.customerNumber = B.customerNumber;

-- even they didn't make payment
SELECT A.customerName, B.amount, B.paymentDate
FROM classicmodels.customers A
left join classicmodels.payments B
on A.customerNumber = B.customerNumber
where b.customerNumber is null;

/*
1. Show the customer first name, last name, orderdate and status for each order
   in the orders table with a matching customer in the customer table.
   
2. Display the first name and last name of all customers, and the order date and
   ordernumber of all their orders, even if the customer made no orders.
*/

-- question 1
SELECT t2.contactFirstName, t2.contactLastName, t1.orderdate, t1.status
FROM orders t1
INNER JOIN customers t2
ON t1.customerNumber = t2.customerNumber;

-- question 2
SELECT t1.contactFirstName, t1.contactLastName, t2.orderdate, t2.ordernumber
FROM customers t1
LEFT JOIN orders t2
ON t1.customerNumber =t2.customerNumber;

-- if customer is not order we can write this query
SELECT t1.contactFirstName, t1.contactLastName, t2.orderdate, t2.ordernumber
FROM customers t1
LEFT JOIN orders t2
ON t1.customerNumber =t2.customerNumber
where t2.orderNumber is not null;

/* Practice question
Show all customers and their orders, even if they made no orders. Both tables have a cust_code field

2 tables have been created - customer and orders.

Display all columns from both tables to show each customer and their orders, even if the customer made no orders.
SELECT *
FROM customer
LEFT JOIN orders ON customer.cust_code = orders.cust_code;
*/


/* UNION
- Combines the result set of 2 or more select statements
- Rules
- Each result set must have the same column
    - The columns must be in the same order
   
Select columnname(s) from table1
Union
Select columnname(s) from table
    */
   
select *
from customers;

select *
from employees;

select
contactFirstName as firstname,
contactLastName as lastname
from customers

union

select
firstname,
lastname
from employees;

-- if we want to show them with their type
select 'customer' as type,
contactFirstName as firstname,
contactLastName as lastname,
city
from customers

union

select 'employee' as type,
firstname,
lastname,
'unknow' as city -- if you don't have city on both column you will have to add as 'unknown' as city or column name which is not included on different column
from employees;

/* Example Excersice
Show all Employees and Customers

Two tables called customer and employee have been created with the following columns:

Customer:

customerid

firstname

lastname

country


Employee:

employeeid

firstname

lastname

country


Show the firstname, lastname and country of all customers and employees in the same output, and do not include duplicates.
SELECT firstname, lastname, country FROM Customer
UNION
SELECT firstname, lastname, country FROM Employee;
*/

/*
QUIZ 1
1. Which type of JOIN in MySQL returns only the rows from both tables that have matching values in the specified columns, and discards non-matching rows?
- INNER JOIN

2. When using a LEFT JOIN in MySQL, which of the following best describes the result set?
- All rows from the first (left) table and matching rows from the second (right) table.

3. In a SQL query using an INNER JOIN, what is the primary purpose of the "ON" clause?
- To specify the columns used to match rows between tables.

4. When using the UNION operator in MySQL to combine the results of two SELECT statements, which of the following is true?
- It includes all rows from both select statements and removes duplicates.

Which of the following is a valid use case for using UNION ALL in MySQL?
- When you want to combine results from two unrealted tables.
*/

-- Aggregate Functions: SUB, ROUND, GROUP BY & HAVING

/*
SUM
- We can sum any column which displays a value, and diusplay it broken down by a certain field such as product or date.
- Name a coulmn using AS
- Any not-aggregated column we displayed must be used in a group by cluse

eg. SELECT paymentDate, sum(amount) as total_payments
FROM classicmodels.payments
group by paymentDate;
*/

SELECT paymentDate, sum(amount) as total_payments
FROM classicmodels.payments
group by paymentDate;

SELECT paymentDate, sum(amount) as total_payments
FROM classicmodels.payments
group by paymentDate
order by paymentDate;

/*
ROUND
- The output of the previous query can be rounded to
1 decimal place by adding ROUND(columnname, 1)
- you can change the 1 to the desired amount of decimal places

SELECT paymentDate, round(sum(amount), 1) as total_payments
From classicmodels.payments
group by paymentDate;
*/

SELECT paymentDate, round(sum(amount), 1) as total_payments
From classicmodels.payments
group by paymentDate;

/*
HAVING
- Having is the same as WHERE, but it used after the group by clause with aggregate functions.
*/
-- all amount
SELECT paymentDate, round(sum(amount), 1) as total_payments
FROM classicmodels.payments
group by paymentDate
order by total_payments desc;

-- less than 50000
SELECT paymentDate, sum(amount) as total_payments
FROM classicmodels.payments
group by paymentDate
having total_payments < 50000
order by total_payments desc;

-- greather than 50000
SELECT paymentDate, round(sum(amount), 1) as total_payments
FROM classicmodels.payments
group by paymentDate
having round(sum(amount), 1) > 50000
order by total_payments desc;

-- date after 2003-06-01
SELECT paymentDate, round(sum(amount), 1) as total_payments
FROM classicmodels.payments
group by paymentDate
having paymentDate > '2003-06-01'
order by total_payments;

/*
Question Example
Show the sum of all orders on each day

A table named Orders has been created with the following columns:

ORD_NUM

ORD_AMOUNT

ADVANCE_AMOUNT

ORD_DATE

CUST_CODE

AGENT_CODE

ORD_DESCRIPTION


Display each ord_date and the sum of the ord_amount.
  ANS:
SELECT ORD_DATE, SUM(ORD_AMOUNT) AS TOTAL_ORD_AMOUNT
FROM Orders
GROUP BY ORD_DATE;
*/

/*
Count
- Could be used to count records to find out how many eg sales there were on a given day.
- we use count(column_name) for this
 SELECT Count(orderNumber) as Orders
 From classicmodels.orders
- Or we can count how many orders for each Product
 Select ProductCode, Count(OrderNumber) as Orders
 From classicmodels.orderdetails
 Group By ProductCode
*/

SELECT Count(orderNumber) as Orders
From classicmodels.orders;

SELECT Count(distinct orderNumber) as Orders
From classicmodels.orderdetails;
 
Select ProductCode, Count(OrderNumber) as Orders
From classicmodels.orderdetails
Group By ProductCode;

/*
MAX AND MIN
- we can add two aggregate functions to a Select Statement
- Let's look at the higest and lowest payment received on the 9th December 2003.
 */
 
 Select paymentDate,
 max(amount) as higest_payment,
 min(amount) as lowest_payment
 from classicmodels.payments
 group by paymentDate
 having paymentDate='2003-12=09';
 
 /*
 AVERAGE
 - AVG is used to display the Average
 - This query would show each day and the average payment amount
 */
 
 Select paymentDate, avg(amount) as average_payment_received
 from classicmodels.payments
 group by paymentDate
 order by paymentDate;
 
 select avg(amount) as average
 from classicmodels.payments;
 
 /*
Count how many distinct customers there were on each day

A table named sales has been created, with 4 columns:

orderdate

customerkey

salesid

salesvalue

Please write your query below.

Show a distinct count of each customer key broken down by day. Name the output column as customers.

SELECT orderdate, COUNT(DISTINCT customerkey) AS customers
FROM sales
GROUP BY orderdate;

SELECT orderdate, COUNT(DISTINCT customerkey) AS customers
FROM sales
GROUP BY orderdate;
*/

-- SAMPLE QUESTION
-- 1. show the customer name of the company which made the most amount of orders.
SELECT customername, count(ordernumber) as orders
FROM orders t1
INNER JOIN customers t2
ON t1.customerNumber = t2.customerNumber
GROUP BY customername
ORDER BY orders DESC
LIMIT 1;

-- 2. Display each cutomers first and last order date.
SELECT customername, min(orderDate) as first_orderdate, max(orderdate) as latest_orderdate
FROM orders t1
INNER JOIN customers t2
ON t1.customerNumber = t2.customerNumber
group by customername;

/*
SUBQUERY
- A Query that appears inside another query statement
- The query inside the brackets is a  subquery, and it must be named. In this example it has been named t1

Select * from (select column1, column2, etc from table1) t1;
*/

Select *
from
(select orderdate, count(ordernumber) as orders
from classicmodels.orders
group by orderdate) t1;

select avg(orders)
from
(select orderdate, count(ordernumber) as orders
from classicmodels.orders
group by orderdate) t1
where orderdate > '2005-05-01';

/*
CTE (COMMON TABLE EXPRESSION)
- Another way of writting a subquery(and personal preference) is a Common Table Expression(CTE)
With cte_name AS
(Select column1, column2 etc
From table_name)

Select * From cte_name
*/

with cte_orders as
(select orderdate, count(ordernumber) as orders
from classicmodels.orders
group by orderdate),

cte_payments as
(select *
from payments)

select avg(orders)
from cte_orders
where orderdate > '2005-05-01';


/*
CASE STATEMENT
- Return a specific value based on a condition, and is often used
to group a column into ranges, or to create a flag.
- Syntax:
CASE when condition1 THEN output1
WHEN condition2 THEN output2
WHEN condition3 THEN output3
ELSE output4
END
*/

/* CASE STATEMENT
NOTE: Good practice to put a final condition showing 'Other' in case a mistake was made.
 Output will be a character data type if you put it in quotation marks.
         <  LESS THAN
<= LESS THAN OR EQUAL TO
         =  EQUAL TO
         >  GREATER THAN
         >= GREATER THAN OR EQUAL TO
         <> NOT EQUAL TO
*/
Select
case when creditLimit < 75000 then 'a: Less than $75K'
when creditLimit between 75000 and 100000 then 'b: $75k-$100k'
when creditLimit between 100000 and 150000 then 'c: $100k-$150k'
when creditLimit > 150000 then 'd: Over $150K'
else 'Other' end as credit_limit_grp,
count(distinct c.customernumber) as customers
from classicmodels.customers c group by 1;

select *
from customers;

/* FLAG - USING CASE WHEN FLAG
- I often use a case when statment to return only 2 possible values -
True/False, sometimes (1/0, or Yes/No)
- By flagging each row I can easily find rows which meet a condtion, and when
the flag is 1/0 I can then sum this column.
*/

-- CASE STATEMENT (This creates a flag which displays 1 when an order of mototcycles is more than 40)
with main_cte as
(
select
t1.ordernumber,
orderdate,
quantityordered,
productname,
productline,

case when quantityordered > 40 and productline = 'Motorcycles'
then 1 else 0 end as ordered_over_40_motorcycles

from classicmodels.orders t1
join classicmodels.orderdetails t2 on t1.ordernumber = t2.ordernumber
join classicmodels.products t3 on t2.productcode = t3.productcode
)
select orderdate, sum(ordered_over_40_motorcycles) as over_40_bike_sale
from main_cte
group by orderdate;

-- find if they have negotiate from flag case
select *, case when comments like '%negotiate%' then 1 else 0 end as negotiated
from classicmodels.orders;

select distinct comments
from classicmodels.orders;

select *, case when comments like '%dispute%' then 1 else 0 end as negotiated, case when comments like '%negotiate%' then 1 else 0 end as negotiated
from classicmodels.orders;

select *, case when comments like '%dispute%' then 1 else 0 end as disputed,
case when comments like '%negotiate%' then 'Negotiated Order'
when comments like '%dispute%' then 'dispute Order'
else 'No Dispute or negotiate' end as status_1
from classicmodels.orders;

/*
Quiz 2
Quiz - Case Statement, Sub Query and CTE
1. Which SQL statement is used to define a CTE in a query?
- WITH CTENAME AS

2. What is the primary purpose of the SQL CASE statement?
- To conditionally return values based on specific conditions.alter

3. When is it appropriate to use a subquery in SQL?
- When you need to perform a query that depends on the results of another query.
*/

/*
ROW_NUMBER
- Assigns a sequential number to each row based on a partition of a result set.
- Syntax:

ROW_NUMBER() OVER (PARTITION BY column_name1 0RDER BY column_name2)

- Let's stay we want to see each customers orders in a result set, ordered by date from oldest to newest
- We would use row_number to number each customers' order.
*/

-- ROW_NUMBER
select
customernumber,
t1.ordernumber,

row_number() over (partition by customernumber order by orderdate) as purchase_number

from classicmodels.orders t1

order by customernumber, t1.ordernumber;

select distinct
t3.customername,
t1.customernumber,
t1.ordernumber,
orderdate,
productcode,
row_number() over (partition by t3.customernumber order by orderdate) as purchase_number
from classicmodels.orders t1
join classicmodels.orderdetails t2 on t1.ordernumber = t2.ordernumber
join classicmodels.customers t3 on t1.customernumber = t3.customernumber
order by t3.customername;

with main_cte as
(
select distinct
t3.customername,
t1.customernumber,
t1.ordernumber,
orderdate,
-- productcode,
row_number() over (partition by t3.customernumber order by orderdate) as purchase_number
from classicmodels.orders t1
-- join classicmodels.orderdetails t2 on t1.ordernumber = t2.ordernumber
join classicmodels.customers t3 on t1.customernumber = t3.customernumber
order by t3.customername
)
select *
from main_cte
where purchase_number = 2;

/*
LEAD
- Lead is used to access data in the next row of ordered output.
- The syntax is similar to row_number and looks like this:

LEAD(column_name) OVER (PARTITION BY column_name ORDER BY column_name)
*/
-- Lets look this example:
SELECT customernumber,
paymentdate,
amount,
lead(amount) over (partition by customernumber order by paymentdate) as next_payment
FROM classicmodels.payments;

/*
LAG
- Lag is used to access data in the previous row of ordered output.
- The syntax is similar to row_number and looks like this:

LAG(column_name) OVER (PARTITION BY column_name ORDER BY column_name)
*/
-- Lets look this example:
SELECT customernumber,
paymentdate,
amount,
lag(amount) over (partition by customernumber order by paymentdate) as previous_payment
FROM classicmodels.payments;

with main_cte as
(
SELECT customernumber,
paymentdate,
amount,
lag(amount) over (partition by customernumber order by paymentdate) as previous_payment
FROM classicmodels.payments)
select *, amount - previous_payment as difference
from main_cte;

/*
Quiz 3
Row_Number and Lead/Lag
1. What is the purpose of the ROW_NUMBER() function in SQL?
ANS: To assign a unique sequential integer to each row with a result set.

2. The products table has 100 different products and their prices.
Look at this example query:
SELECT Product, Price,
ROW_NUMBER() OVER (PARTITION BY Proudct ORDER BY Price DESC)
AS RowNum
FROM products
What is the RowNum value assigned to the product with the highest price?
ANS: WITH RankedProducts AS (SELECT Product, Price, ROW_NUMBER() OVER (PARTITION BY Product ORDER BY Price DESC) AS RowNum
FROM products)
SELECT Product, RowNum
    FROM RankedProducts
WHERE RowNum = 1;  -- Selecting the row with the highest price within each partition

3. What is the primary purpose of the LEAD and LAG window functions in SQL?
ANS: To access data from the next to previous row in a result set for comparison or analysis.
*/

-- Exercise
-- 1. Display the orderdate, ordernumber, salesrepemployeenumber for each sales reps second order.
with cte_main as
(
select orderdate, t1.ordernumber,  salesrepemployeeNumber,
row_number() over (partition by salesrepemployeeNumber order by orderdate) as repordernumber
from orders t1
inner join customers t2
on t1.customernumber = t2.customernumber
join employees t3
on t2.salesRepEmployeeNumber = t3.employeeNumber)
select *
from cte_main
where repordernumber =2;

/*
Date Functions
Year Month and Day
Year, Month and Day return the date part in a new column
based on the column you enter inside the brackets:
*/
-- Query
select ordernumber,
orderdate,
year(orderdate) as year,
month(orderdate) as month,
day(orderdate) as day
from classicmodels.orders;

/*
DATEDIFF
- NOW()-Shows today's date
Select DateDiff(column1, column2)

- DateDiff shows the difference between two dates in days
*/

select now();

select a.ordernumber,
datediff(requireddate, orderdate) days_until_required
from classicmodels.orders a;

select a.ordernumber,
requireddate,
orderdate,
datediff(requireddate, orderdate) days_until_required
from classicmodels.orders a;

select a.ordernumber,
requireddate,
orderdate,
datediff(now(), orderdate)/365 days_until_required
from classicmodels.orders a;

/*
DATE_ADD
- You can add days, months or years from any date column uisng this function
Date_Add(date, interval value and unit)
*/

select a.ordernumber,
orderdate,
date_add(requireddate, interval 1 year) as one_year_from_order
from classicmodels.orders a;

select *, date_add(orderDate, interval 1 year) as one_year_after,
date_sub(orderdate, interval 2 month) as two_months_age
from orders;

/*
DATE_SUB
- you can subtract dats, months, years etc from any date column using this function
Dat_Sub(date, iterval value and unit)
- I would often use this function in a where clause to show for example all sales for the year
*/

SELECT *
FROM classicmodels.orders a
WHERE orderdate >= date_sub('20060101', INTERVAL 1 YEAR);

/*
CAST
- Used ro change the datatype of a coulumn.
- Common to have to do this when joining tables together, where one key is an integer or varchar and the other is in data format.alter
*/
 select *,
 cast(paymentDate as datetime) as datetime_type
 From classicmodels.payments;

/*SUBSTRING
- Substring returns a specified length of any string column you input:
SELECT SUBSTRING (columnname, startfrom, length)
*/

SELECT CUSTOMERNUMBER,
PAYMENTDATE,
SUBSTRING(PAYMENTDATE, 1,7) AS MONTH_KEY
FROM CLASSICMODELS.PAYMENTS;

/*
CONCAT
- Used to merge 2 or more columns together:
Slect concat(column1, column2)
-Let's put a employees first and last name together:
*/
-- Example
SELECT EMPLOYEENUMBER
LASTNAME,
FIRSTNAME,
CONCAT(firstName, ' ', LastName) as FULLNAME
From classicmodels.employees;

select customername, concat(city, '-', country) as City_Country
from customers;

/*
QUIZ
1. Which of the following statements calculates the date that is 7 days after the current date in MySQL?
ANS: DATE_ADD(NOW(), INTERVAL 7 DAY)

2. If you have two date columns, start_date and end_date, and you want to calculate the duration between these two dates in days, which function would you use?
ANS: DATEDIFF(start_date, end_date)

3. Which of the following statements is used to change a string column age_str to an integer in MySQL?
ANS: CAST(age_str AS INT)

4. If you have a string column description and you want to extract the first 10 characters from it, which MySQL function would you use?
ANS: SUBSTRING(description, 1, 10)
*/

/*
--- EXCEL Cource
-Trim removes unwanted blank spaces from a cell, without removing spaces between words
=TRIM(A2)
to select all cell (Ctrl+Shift+Down)
=TRIM(selet the cell and close th bracket and hit enter)
so copy everything find the button row, and type on row number and type the last row(B8808) hold (Shift & Enter)
F2 in key board with out doing any thing to bring that back up
CTRL & ENTER to fill the values
Ctrl + Shift + End - to select everything

seperate the comumn(90 min)
go to  text and column, seperate by space

To filter
click on top tap and click filter under data tab

Split the column
- High light the column and click on Text to columns under Data tab
- select Delimited, next,select by comma, next and finish

Tabel select
Ctrl + T = Table(Selected column)

Trinm
=Trim(select row)
copy the value copy whole row and paste as value
Ctrl + minus to remove selected row

Sum, Average, Max, Min
=SUM(A1:A10)
=AVERAGE(A1:A10)
=MAX(A1:A10)
=MIN(A1:A10)
   
Roundup
=Roundup(select row, 0) and enter
copy the value copy whole row and paste as value
Ctrl + minus to remove selected row

Add country coulumn
- go to data tab and select Geography
- and once you see three table sign on rows then go to side and hoover and find plus sign and click region/country

Remove Dublicate
- click on remove dubicates icon under data tab

Add Analysis ToolPak on excel
- go to option
- select Analysis toolpak and go
- slect Analysis toolpak on box, click ok

to add all mean, mode, median and all
- go to data analysis
- select description statstics
- select input rance you want to get value for
- select output range and summary statistics and select the row you want to display

to create box and whisker
- select the value(price) you want to show
- select by all row, you can right click on chart
- click on select data
- edit by horizontal and select all the row you wan to display

to calculate Revenue
=(Quantity column * Price column)

to add PivotTable
- secelt PivotTable under Insert tab
- to select all for table and range

for break down pivottable
- drag down on rows, values, column and filter

SUM, Average, Max, Min

=SUM(A1:A10)

=AVERAGE(A1:A10)

=MAX(A1:A10)

=MIN(A1:A10)

IF, AND, OR, NOT
- Similar to Case When in SQL, If checks wheather a condition has been met before the output
  in a cell is ruturned
=IF(E2>2010,1,0)

- IF AND will check for 2 conditions:
=IF(AND(E2>2010, H@>120),1,0)

- IF OR will check for one of 2 conditions being met:
=IF(OR(F2="TV-PG", F2="PG"),1,0)

- IF NOT will check for a conditions not being met:
=IF(NOT(F2="PG")1,0)

Sumifs
- Single Range
=SUMIFS(Rangetosum, Rangetocheck, Criteriatocheck)

- Multiple Range
=SUMIFS(Rangetosum, Range1tocheck, Criteria1tocheck, Range2tocheck, Criteria2tocheck, etc)

Examples
=SUMIFS(G2:G8808, B2:B8808, "Movie")

=SUMIFS(G2:G8808, B2:B8808, "Movie", E2:E8808, 2021)

Countifs
- Single Range
=COUNTIFS(Rangetocount, Rangetocheck, Criteriatocheck)

- Multiple Range
=COUNTIFS(Rangetocount, Range1tocheck, Criteria1tocheck, Range2tocheck, Criteria2tocheck, etc)

UNIQUE
-Similar to Distinct in SQL, you may want to use this when you receive a new dataset and to view
what a column can contain.
=UNIQUE(H:H)

LEFT/RIGHT
- LEFT will extract a specified number of charachers from the start of text, and
  RIGHT will extract from the end.
 
=LEFT(cell, specified number)

=RIGHT(cell, specified number)

VLOOKIUP
-Vlookup is one of the most commonly used funtions be me.

-It looks for value or string in a table and returns the value of the column you specify

=VLOOKUP(lookup value, table array, column index number, range lookup)

Pivot Table
- go to insert and select pivot table
- drag all the rows you want

5 Exercise
1. Display a count of movies by film duration in a pivot talbe, sorted by count of movies.
2. Sum the duration of movies released between 1990 and 2000 using SUMIFS
3. Count how many TV shows were added each month, regardless of the year.
4. Display a unique list of release years.
5. Show a pivot talbe -
	Rating on columns,
    Realease year on rows Sum of duration as value.
*/

/*
About this Section

Hi Everyone,

In this section we will re-visit SQL and use MySQL to answer example business questions
which could be similar to real life workplace questions from stakeholders.

Topics covered in the SQL section will be used to answer the questions, and multiple
topics will be used in a single query together. Some will seem complicated at first
but with continued practice it will begin to make sense.

As always if you have any questions please reach out.

Thanks!
*/

/*
Real world email from stakeholder
Hi there,
Can you please give me an overview of sales for 2004
I would like to see a breakdown by product, country and city and please include the sales value, cost
of sales and net profit.
Thank you!

Hi there,
Can you give me a breakdown of what products are commonly purchased together, and any products that are
rarely purchased together?
Thank you!

Hi there,
Can you show me a breakdown of sales, but also show their credit limit?
Maybe group the credit limits as I want a high levle view to see if we get higher sales for customers
who have a higher credit limit which we would expect.
Thank you!

Hi there,
Can I have a view showing customers sales and include a column which shows the difference in value from their previous sale?
I want to see if new customers who make their first purchase are likely to spend more.
Thank you!

 
*/