use AdventureWorks

select table_schema, table_name
from INFORMATION_SCHEMA.tables
where table_type = 'base table'
order by TABLE_SCHEMA, table_name;


select top 100 * from 
sales.salesorderheader;
--Q1 — Revenue trend
--"Show me total revenue and order count for each month, across all years. I want to see if we're growing."--
select 
year(orderdate) as orderyear,
month(orderdate) as ordermonth,
sum(totaldue) as totalrevanue
from sales.SalesOrderHeader
group  by 
  year(orderdate),
  month(orderdate)
order by 
orderyear,
ordermonth;

--Q2 — Top 10 products by revenue
--"Which products generated the most money? Show me the top 10."--
select top  10* from Sales.SalesOrderDetail
select * from production.product;
   

 select top 10 
 p.name,p.productid,
 sum(s.linetotal) as totalrevenue 
 from sales.salesorderdetail s
 inner join production.product p 
 on s.productid = p.ProductID
 group by 
 p.Name,p.ProductID
 order by totalrevenue desc;

 --Q3 — Top 10 customers by total spend
--"Who are our highest-value customers? Show me their full name and total amount they've spent."--
SELECT * FROM Person.Person;
SELECT  * FROM Sales.Customer;
select * from sales.salesorderheader;


select top 10
p.firstname+ ' ' +p.lastname as full_name ,sum(soh.totaldue) as total_spend
from  sales.customer s
inner join sales.salesorderheader soh 
on s.customerid = soh.customerid
inner join person.person p 
on s.PersonID = p.BusinessEntityID
group by p.BusinessEntityID,
p.firstname,p.lastname
order by total_spend desc;

--— Revenue by territory
--"Which sales regions are bringing in the most money? Break it down by territory."--

select * from sales.SalesTerritory;
select * from sales.SalesOrderHeader;


select  sum(sho.totaldue) as totalrevenue,
st.name as territoryname
from sales.salesorderheader sho 
inner join sales.salesterritory st 
on sho.territoryid = st.territoryid 
group by st.name
order by totalrevenue desc;


--Q5 — Year-on-year revenue comparison
--"Compare total revenue for each year side by side. Are we growing year over year?"--

select * from sales.salesorderheader;

select year(orderdate)as year,
sum(totaldue) as yearlyrevenue from sales.salesorderheader
group by year(orderdate)
order by  year(orderdate) desc;

--Q6 — Revenue by product category
--"Bikes vs accessories vs clothing — which category dominates?--

select * from sales.SalesOrderDetail
select * from Production.Product
select * from Production.ProductSubcategory
select * from Production.ProductCategory

select pc.name,sum(sd.LineTotal) as total_revenue
from production.ProductCategory pc 
inner join  Production.ProductSubcategory psc
on pc.ProductCategoryID = psc.ProductCategoryID
inner join production.Product pp 
on psc.ProductSubcategoryID = pp.ProductSubcategoryID
inner join sales.SalesOrderDetail sd
on pp.ProductID = sd.ProductID
group by pc.name
order by total_revenue desc 



--Q7 — Average order value over time
--"Is the average order getting bigger or smaller each year? Are customers spending more per visit?"--

select year(orderdate)as year_sales ,avg(totaldue) as avg_revenue from sales.SalesOrderHeader
group by year(orderdate)
order by year(orderdate)




