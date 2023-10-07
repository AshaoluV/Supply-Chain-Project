select * from chain;
->Revenue
select cast(sum(`Revenue generated`) as decimal(8,2))Revenue from chain;
*->Revenue By Product Type 
select `Product Type`, cast(sum(`Revenue generated`) as decimal(8,2))Revenue from chain
group by `Product Type`
order by Revenue desc
*>Revenue By Location 
select location, cast(sum(`Revenue generated`) as decimal(8,2))Revenue from chain
group by location
order by Revenue desc
*->Revenue Contribution Percentage
select location, cast(sum(`Revenue generated`)as decimal(8,2))`Revenue`,
cast(sum(`Revenue generated`)*100/(select sum(`Revenue generated`) from chain)as decimal(4,2))'%Revenue Contribution'
from chain 
group by location
order by `Revenue` desc
->Stock Levels & lead Times
select sum(`stock levels`)'Stock Levels', sum(`Lead Times`)'Lead Times' from chain;
->Order Quantities 
select sum(`Order quantities`)'Order Quantities' from chain;
->Order Quantities By Location
select location, sum(`Order quantities`)`Order Quantities` from chain
group by location
order by `Order Quantities` desc;
*->Most Costly Products to Produce
select `product type`,cast(sum(`Manufacturing costs`) as decimal(6,2))`Manufacturing costs` from chain
group by `product type` 
Order by `product type` desc;
*->Relation of Manufacturating cost to selling price 
select `product type`, cast(sum(price) as decimal(6,2))Price,
cast(sum(`Manufacturing costs`) as decimal(6,2))`Manufacturing costs`,
cast((sum(price)-sum(`Manufacturing costs`))as decimal(5,2))'Relation of Manufacturating cost to selling price'
from chain 
group by `product type`
order by `product type`;
->Overall Profitability of Product
select `product type`, cast(sum(`Revenue generated`) as decimal(8,2))Revenue, 
cast(sum(cost)as decimal(7,2))Cost,
cast((sum(`Revenue generated`)-sum(cost))as decimal(8,2))Profit from chain
group by `product type`
order by `product type`;
*->Profit By Product
select `Product Type`, cast(sum(`Profit`) as decimal(8,2))`Profit` from chain
group by `Product Type`
order by `Profit` desc;
*->Profit by Location
select location, cast(sum(`Profit`) as decimal(8,2))`Profit` from chain
group by location
order by `Profit` desc
->Profit Contribution %
*select location, cast(sum(`Profit`)as decimal(8,2))`Profit`,
cast(sum(`Profit`)*100/(select sum(`Profit`) from chain)as decimal(8,2))'%Profit Contribution'
from chain 
group by location
order by `Profit` desc;
*->Average Leadtime 
select `Product type`, cast((sum(`Lead times`)/count(`Lead times`))as decimal(4,2))'Average Leadtime' from chain
group by `Product type`;
->How Leadtime Affects Stock Levels and Availability
 select sum(`Lead Times`)`Lead Times`, Sum(`Stock Levels`)`Stock Levels`,
 sum(`Availability`)`Availability` from chain;
*->Correlation Between Inspection Result and Defect Rate 
select `inspection results`, cast(sum(`Defect Rates`) as decimal(4,2))`Defect Rates`, 
cast(sum(`Defect Rates`)*100/(select sum(`Defect Rates`) from chain)as decimal(4,2)) '%Of Defect Rate',
cast(sum(`Defect Rates`)/count(`Defect Rates`) as decimal(3,2))'Average Defect Rate'
from chain
group by `inspection results`
order by `Defect Rates` desc;
->Most Common Transport Modes Used
select max(`transportation modes`)'Transportation Modes'from chain;
*->How Transportation Modes Affect Lead Time and Cost
select `Transportation Modes`, sum(`lead times`)'Lead Times', cast(sum(Totalcost) as decimal(9,2))'Cost'
from chain
group by `Transportation Modes`; 
-Most Common Routes Used
select max(`Routes`)'Route' from chain;
**->Impact of Different Routes on Costs and Lead Times 
select `Routes`, sum(`lead times`)'Lead Times', convert(sum(cost),decimal(8,2))'Cost'
from chain
group by `Routes`
order by `lead times`desc; 
*->Average Defect Rate For Each Product
select `product type`, 
cast(sum(`Defect rates`)/count(`Defect rates`) as decimal (3,2))'Average Defect Rate' 
from chain
group by `product type`;
*->Correlation of Inspection Result and Manufacturing Cost 
select `Inspection results`, cast(sum(`Manufacturing costs`) as decimal(6,2))`Manufacturing Costs`, 
cast((sum(`Manufacturing costs`)*100/(select sum(`Manufacturing costs`) from chain))as decimal(4,2))`%Manufacturing Costs` 
from chain 
group by `Inspection results`
order by `Manufacturing costs` desc;
->How Production Volume Relates To Stock Levels and Quantity
select sum(`Production Volumes`)`Production Volumes`,
sum(`Stock levels`)`Stock levels`,sum(`Order Quantities`)`Order Quantities` from chain;
*->Production Volumes Alinged With Market Demands
select `Location`, sum(`Production volumes`)`Production Volume` from chain
group by `Location`
order by `Production Volume` desc;
*->Percentage of Production Volumes Alinged With Market Demands
select `Location`, sum(`Production volumes`)`Production Volume`,
(sum(`Production volumes`)*100/(select sum(`Production volumes`) from chain))'%ProductionVolume'
from chain
group by `Location`
order by `Production Volume` desc;


select SKU, (sum(`Revenue generated`) - sum(Costs))'Profit' from chain
group by SKU;
alter table chain change costs TotalCost int not null ;
Alter Table chain add column Profit int;
Alter Table chain add column `Manufacturing Cost To Price` double;
update chain set Profit = (`Revenue generated`) - (Costs);
update chain set `Manufacturing Cost To Price` = (`Price`) - (`Manufacturing Costs`);
alter table chain modify Totalcost double;
alter table chain modify `Manufacturing Cost To Price` decimal(4,2);
desc chain;
select * from chain;