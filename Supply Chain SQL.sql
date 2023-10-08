SELECT 
* 
FROM chain
;

/*Revenue*/
SELECT 
    CAST(SUM(`Revenue generated`) 
    AS DECIMAL(8,2))Revenue 
FROM chain
;

/*Revenue By Product Type*/ 
SELECT 
      `Product Type`, CAST(SUM(`Revenue generated`) 
      AS DECIMAL(8,2))Revenue 
FROM chain
GROUP BY `Product Type`
ORDER BY Revenue
DESC
;

/*Revenue By Location*/ 
SELECT 
      location, 
      CAST(SUM(`Revenue generated`) 
      AS DECIMAL(8,2))Revenue 
FROM chain
GROUP BY location
ORDER BY Revenue 
DESC
;

/*Revenue Contribution Percentage*/
SELECT 
      location, 
      CAST(SUM(`Revenue generated`) 
      AS DECIMAL (8,2))`Revenue`,
      CAST(SUM(`Revenue generated`)*100/(SELECT SUM(`Revenue generated`) FROM chain) 
      AS DECIMAL(4,2))'%Revenue Contribution'
FROM chain 
GROUP BY location
ORDER BY `Revenue`
DESC
;

/*Stock Levels & lead Times*/
SELECT 
      SUM(`stock levels`)'Stock Levels', 
      SUM(`Lead Times`)'Lead Times'  
FROM chain
;

/*Order Quantities*/ 
SELECT 
      SUM(`Order quantities`)'Order Quantities' 
FROM chain
;

/*Order Quantities By Location*/
SELECT 
      location, 
      SUM(`Order quantities`)`Order Quantities` 
FROM chain
GROUP BY location
ORDER BY `Order Quantities`
DESC
;

/*Most Costly Products to Produce*/
SELECT 
      `product type`,
      CAST(SUM(`Manufacturing costs`) 
      AS DECIMAL(6,2))`Manufacturing costs` 
FROM chain
GROUP BY `product type` 
ORDER BY `product type`
DESC
;

/*Relation of Manufacturating cost to selling price*/ 
SELECT 
      `product type`,
      CAST(SUM(price) AS DECIMAL(6,2))Price,
      CAST(SUM(`Manufacturing costs`) 
      AS DECIMAL(6,2))`Manufacturing costs`,
      CAST((sum(price)-sum(`Manufacturing costs`)) 
      AS DECIMAL(5,2))'Relation of Manufacturating cost to selling price'
FROM chain 
GROUP BY `product type`
ORDER BY `product type`
;

/*->Overall Profitability of Product*/
SELECT
      `product type`, 
      CAST(SUM(`Revenue generated`)
      AS DECIMAL(8,2))Revenue, 
      CAST(SUM(costs) 
      AS DECIMAL(7,2))Cost,
      CAST((SUM(`Revenue generated`)-sum(costs)) 
      AS DECIMAL(8,2))Profit 
FROM  chain
GROUP BY `product type`
ORDER BY `product type`
;

/*->Profit By Product*/
SELECT 
      `Product Type`, 
      CAST(SUM(`Profit`) AS DECIMAL(8,2))`Profit` 
FROM chain
GROUP BY `Product Type`
ORDER BY `Profit` DESC
;

/*Profit by Location*/
SELECT 
      location, 
      CAST(SUM(`Profit`) 
      AS DECIMAL(8,2))`Profit` 
FROM chain
GROUP BY location
ORDER BY `Profit`
DESC
;

/* Profit Contribution % */
SELECT 
      location, 
      CAST(SUM(`Profit`) 
      AS DECIMAL(8,2))`Profit`,
	  CAST(SUM(`Profit`)*100/(SELECT SUM(`Profit`) FROM chain) 
      AS DECIMAL(8,2))'%Profit Contribution'
FROM chain 
GROUP BY location
ORDER BY `Profit`
DESC
;

/* Average Leadtime */ 
SELECT
	  `Product type`,
      CAST((SUM(`Lead times`)/COUNT(`Lead times`)) 
      AS DECIMAL(4,2))'Average Leadtime' 
FROM chain
GROUP BY `Product type`
;

/* How Leadtime Affects Stock Levels and Availability */
 SELECT 
       SUM(`Lead Times`)`Lead Times`, 
       SUM(`Stock Levels`)`Stock Levels`,
	   SUM(`Availability`)`Availability` 
FROM chain
;

/* Correlation Between Inspection Result and Defect Rate */ 
SELECT 
      `inspection results`,
      CAST(SUM(`Defect Rates`) 
      AS DECIMAL(4,2))`Defect Rates`, 
      CAST(SUM(`Defect Rates`)*100/(SELECT SUM(`Defect Rates`) FROM chain) 
      AS DECIMAL(4,2)) '%Of Defect Rate',
      CAST(SUM(`Defect Rates`)/count(`Defect Rates`) 
      AS DECIMAL(3,2))'Average Defect Rate'
FROM chain
GROUP BY `inspection results`
ORDER BY `Defect Rates` 
DESC
;

/* Most Common Transport Modes Used */
SELECT 
      MAX(`transportation modes`)'Transportation Modes'
FROM chain
;

/*How Transportation Modes Affect Lead Time and Cost*/
SELECT 
      `Transportation Modes`,
      SUM(`lead times`)'Lead Times',
      CAST(SUM(cost) AS DECIMAL(9,2))'Cost'
FROM chain
GROUP BY `Transportation Modes`
; 

/* Most Common Routes Used */
SELECT 
      max(`Routes`)'Route' 
FROM chain
;

/* Impact of Different Routes on Costs and Lead Times */ 
SELECT 
      `Routes`, 
      SUM(`lead times`)'Lead Times', 
      CONVERT(sum(cost), 
      DECIMAL(8,2))'Cost'
FROM chain
GROUP BY `Routes`
ORDER BY `lead times`
DESC
; 

/* Average Defect Rate For Each Product */
SELECT 
      `product type`, 
      CAST(SUM(`Defect rates`)/COUNT(`Defect rates`) 
      AS DECIMAL (3,2))'Average Defect Rate' 
FROM chain
GROUP BY `product type`
;

/* Correlation of Inspection Result and Manufacturing Cost */ 
SELECT 
      `Inspection results`, 
      CAST(SUM(`Manufacturing costs`) 
      AS DECIMAL(6,2))`Manufacturing Costs`, 
      CAST((SUM(`Manufacturing costs`)*100/(SELECT SUM(`Manufacturing costs`) FROM chain))
      AS DECIMAL(4,2))`%Manufacturing Costs` 
FROM chain 
GROUP BY `Inspection results`
ORDER BY `Manufacturing costs` 
DESC
;

/*How Production Volume Relates To Stock Levels and Quantity*/
SELECT
      SUM(`Production Volumes`)`Production Volumes`,
      SUM(`Stock levels`)`Stock levels`,
      SUM(`Order Quantities`)`Order Quantities` 
FROM chain
;

/* Production Volumes Alinged With Market Demands */
SELECT 
      `Location`, 
      SUM(`Production volumes`)`Production Volume`
FROM chain
GROUP BY `Location`
ORDER BY `Production Volume` 
DESC
;

/* Percentage of Production Volumes Alinged With Market Demands */
SELECT 
      `Location`, 
      SUM(`Production volumes`)`Production Volume`,
	  (sum(`Production volumes`)*100/(select sum(`Production volumes`) from chain))'%ProductionVolume'
FROM chain
GROUP BY `Location`
ORDER BY `Production Volume`
DESC 
;

/* Profit and Manufacturing Cost To Price Columns Were Added  
with certain Data Definition & Manipulation */ 

SELECT 
      SKU, 
      (SUM(`Revenue generated`) - SUM(Costs))'Profit'
FROM chain
GROUP BY SKU;

ALTER TABLE chain 
CHANGE costs 
	   TotalCost INT NOT NULL
;

ALTER TABLE chain 
ADD COLUMN Profit INT
;

ALTER TABLE chain 
ADD COLUMN `Manufacturing Cost To Price` DOUBLE
;

UPDATE chain 
SET Profit = (`Revenue generated`) - (Costs)
;

UPDATE CHAIN 
SET `Manufacturing Cost To Price` = (`Price`) - (`Manufacturing Costs`)
;

ALTER TABLE chain 
MODIFY Totalcost DOUBLE
;

ALTER TABLE chain 
MODIFY `Manufacturing Cost To Price` decimal(4,2)
;
 
DESC chain
;

SELECT 
* 
FROM chain
;