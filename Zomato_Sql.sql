
-- Q2 
wITH CTE AS (
select Datekey,
 year(datekey) Year1,month(datekey) as Month,
monthname(datekey) as Monthname,
quarter(datekey) QT
 from dt)
 Select * ,
 concat("FQ - ",
 case 
when QT = 1 then  month(datekey) + 10
when QT < 5 then month(datekey)  - 3
end ) as Fisical_year from CTE;


-- Q3
select RestaurantName,Average_Cost_for_two*Usd_rate as Dollar  from zomato
join bridge1 using(Currency)
order by 2 desc;

-- Q4

select C.countryname,Z.city,count(RestaurantName) from zomato Z
join Country C on C.CountryID = Z.CountryCode
group by 1,2;

-- Q5

select
 year(datekey) Year1,month(datekey) as Month,
quarter(datekey) QT,count(RestaurantName) as Openings
 from dt
 join zomato on zomato.Datekey_Opening = dt.datekey
 group by 1,2,3
 order by 1 ;
 
-- Q6

select round(rating),count(*) from zomato
group by 1
order by 1;

-- Q7

with X as (select *,Average_Cost_for_two*Usd_rate as Dollar  from zomato
join bridge1 using(Currency))
select 
case 
when Dollar < 5 and Dollar > 0  then 'Inexpensive'
when Dollar < 10 and Dollar > 5  then 'Affordable'
when Dollar < 70 and Dollar > 10  then 'Expensive'
else 'Luxery'
end as Bins, count(*) as Resturants
from X
group by 1;

-- Q8

select Has_Table_booking,CONCAT(ROUND(count(*)/(select count(*) from zomato) * 100),'%') AS Percentage from Zomato
group by 1;

-- Q9

select Has_Online_delivery,CONCAT(ROUND(count(*)/(select count(*) from zomato) * 100),'%') AS Percentage from Zomato
group by 1;
