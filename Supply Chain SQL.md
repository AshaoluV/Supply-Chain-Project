~~~ SQL
SELECT 
* 
FROM chain
;
~~~ 
	
~~~ SQL	
/* Revenue */
SELECT 
    CAST(SUM(`Revenue generated`) 
    AS DECIMAL(8,2))Revenue 
FROM chain
;
~~~
| **Revenue**   |
|-----------|
| 577604.82 |

~~~ SQL
/* Revenue By Product Type */ 
SELECT 
      `Product Type`, CAST(SUM(`Revenue generated`) 
      AS DECIMAL(8,2))Revenue 
FROM chain
GROUP BY `Product Type`
ORDER BY Revenue
DESC
;
~~~
| **Product Type** | **Revenue**   |
|--------------|-----------|
| skincare     | 241628.16 |
| haircare     | 174455.39 |
| cosmetics    | 161521.27 |

~~~ SQL
/* Revenue By Location */ 
SELECT 
      location, 
      CAST(SUM(`Revenue generated`) 
      AS DECIMAL(8,2))Revenue 
FROM chain
GROUP BY location
ORDER BY Revenue 
DESC
;
~~~
| **Location**  | **Revenue**   |
|-----------|-----------|
| Mumbai    | 137755.03 |
| Kolkata   | 137077.55 |
| Chennai   | 119142.82 |
| Bangalore | 102601.72 |
| Delhi     | 81027.7   |
|           |           |

~~~SQL
/* Revenue Contribution Percentage */
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
~~~
| **Location**  | **Revenue**   | **%Revenue Contribution** |
|-----------|-----------|-----------------------|
| Mumbai    | 137755.03 | 23.85                 |
| Kolkata   | 137077.55 | 23.73                 |
| Chennai   | 119142.82 | 20.63                 |
| Bangalore | 102601.72 | 17.76                 |
| Delhi     | 81027.7   | 14.03                 |
|           |           |                       |

~~~ SQL
/* Stock Levels & lead Times */
SELECT 
      SUM(`stock levels`)'Stock Levels', 
      SUM(`Lead Times`)'Lead Times'  
FROM chain
;
~~~
| **Stock Levels** | **Lead Times** |
|--------------|------------|
| 4777         | 1596       |
|              |            |

~~~ SQL
/* Order Quantities */ 
SELECT 
      SUM(`Order quantities`)'Order Quantities' 
FROM chain
;
~~~
| **Order Quantities** |
|------------------|
| 4922             |
|                  |

~~~ SQL
/* Order Quantities By Location */
SELECT 
      location, 
      SUM(`Order quantities`)`Order Quantities` 
FROM chain
GROUP BY location
ORDER BY `Order Quantities`
DESC
;
~~~

| **Location** | **Order Quantities** |
|-----------|------------------|
| Kolkata   | 1228             |
| Chennai   | 1109             |
| Mumbai    | 1083             |
| Bangalore | 769              |
| Delhi     | 733              |

~~~ SQL
/* Most Costly Products to Produce */
SELECT 
      `product type`,
      CAST(SUM(`Manufacturing costs`) 
      AS DECIMAL(6,2))`Manufacturing costs` 
FROM chain
GROUP BY `product type` 
ORDER BY `product type`
DESC
;
~~~
| **Product type** | **Manufacturing costs** |
|--------------|---------------------|
| skincare     | 1959.73             |
| haircare     | 1647.57             |
| cosmetics    | 1119.37             |
|              |                     |

~~~ SQL
/* Relation of Manufacturating cost to selling price */ 
SELECT 
      `product type`,
      CAST(SUM(price) AS DECIMAL(6,2))Price,
      CAST(SUM(`Manufacturing costs`) 
      AS DECIMAL(6,2))`Manufacturing costs`,
      CAST((SUM(price)-SUM(`Manufacturing costs`)) 
      AS DECIMAL(5,2))'Relation of Manufacturating cost to selling price'
FROM chain 
GROUP BY `product type`
ORDER BY `product type`
;
~~~
| **Product type** | **Price**   | **Manufacturing costs** | **Relation of Manufacturating cost to selling price** |
|--------------|---------|---------------------|---------------------------------------------------|
| cosmetics    | 1491.39 | 1119.37             | 372.02                                            |
| haircare     | 1564.49 | 1647.57             | -83.09                                            |
| skincare     | 1890.37 | 1959.73             | -69.35                                            |
|              |         |                     |                                                   |

~~~ SQL
/* Overall Profitability of Product */
SELECT
      `product type`, 
      CAST(SUM(`Revenue generated`)
      AS DECIMAL(8,2))Revenue, 
      CAST(SUM(costs) 
      AS DECIMAL(7,2))Cost,
      CAST((SUM(`Revenue generated`)-SUM(costs)) 
      AS DECIMAL(8,2))Profit 
FROM  chain
GROUP BY `product type`
ORDER BY `product type`
;
~~~
| **Product type** | **Revenue**   | **Cost**  | **Profit**    |
|--------------|-----------|-------|-----------|
| cosmetics    | 161521.27 | 13365 | 148156.27 |
| haircare     | 174455.39 | 17330 | 157125.39 |
| skincare     | 241628.16 | 22229 | 219399.16 |

~~~ SQL
/* Profit By Product */
SELECT 
      `Product Type`, 
      CAST(SUM(`Profit`) AS DECIMAL(8,2))`Profit` 
FROM chain
GROUP BY `Product Type`
ORDER BY `Profit` DESC
;
~~~
| **Product Type** | **Profit** |
|--------------|--------|
| skincare     | 219400 |
| haircare     | 157125 |
| cosmetics    | 148156 |

~~~ SQL
/* Profit by Location */
SELECT 
      location, 
      CAST(SUM(`Profit`) 
      AS DECIMAL(8,2))`Profit` 
FROM chain
GROUP BY location
ORDER BY `Profit`
DESC
;
~~~
| **Location**  | **Profit** |
|-----------|--------|
| Mumbai    | 128332 |
| Kolkata   | 124794 |
| Chennai   | 106707 |
| Bangalore | 92041  |
| Delhi     | 72807  |
|           |        |

~~~ SQL
/* Profit Contribution% */
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
~~~

| **location**  | **Profit** | **%Profit Contribution** |
|-----------|--------|----------------------|
| Mumbai    | 128332 | 24.46                |
| Kolkata   | 124794 | 23.78                |
| Chennai   | 106707 | 20.34                |
| Bangalore | 92041  | 17.54                |
| Delhi     | 72807  | 13.88                |

~~~ SQL 
/* Average Leadtime */ 
SELECT
	  `Product type`,
      CAST((SUM(`Lead times`)/COUNT(`Lead times`)) 
      AS DECIMAL(4,2))'Average Leadtime' 
FROM chain
GROUP BY `Product type`
;
~~~
| **Product type** | **Average Leadtime** |
|--------------|------------------|
| haircare     | 15.53            |
| skincare     | 16.7             |
| cosmetics    | 15.38            |
|              |                  |

~~~SQL
/* How Leadtime Affects Stock Levels and Availability */
 SELECT 
       SUM(`Lead Times`)`Lead Times`, 
       SUM(`Stock Levels`)`Stock Levels`,
	   SUM(`Availability`)`Availability` 
FROM chain
;
~~~
| **Lead Times** | **Stock Levels** | **Availability** |
|------------|--------------|--------------|
| 1596       | 4777         | 4840         |
|            |              |              |

~~~SQL
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
~~~
| **Inspection results** | **Defect Rates** | **%Of Defect Rate** | **Average Defect Rate** |
|--------------------|--------------|-----------------|---------------------|
| Fail               | 92.49        | 40.62           | 2.57                |
| Pending            | 88.32        | 38.79           | 2.15                |
| Pass               | 46.9         | 20.59           | 2.04                |

~~~ SQL
/* Most Common Transport Modes Used */
SELECT 
      MAX(`transportation modes`)'Transportation Modes'
FROM chain
;
~~~
| **Transportation Modes** |
|----------------------|
| Sea                  |

~~~ SQL
/*How Transportation Modes Affect Lead Time and Cost*/
SELECT 
      `Transportation Modes`,
      SUM(`lead times`)'Lead Times',
      CAST(SUM(costs) AS DECIMAL(9,2))'Cost'
FROM chain
GROUP BY `Transportation Modes`
; 
~~~
| **Transportation Modes** | **Lead Times** | **Cost**  |
|----------------------|------------|-------|
| Road                 | 497        | 16047 |
| Air                  | 475        | 14606 |
| Rail                 | 417        | 15169 |
| Sea                  | 207        | 7102  |

~~~ SQL
/* Most Common Routes Used */
SELECT 
      MAX(`Routes`)'Route' 
FROM chain
;
~~~
| **Route**   |
|---------|
| Route C |

~~~ SQL
/* Impact of Different Routes on Costs and Lead Times */ 
SELECT 
      `Routes`, 
      SUM(`lead times`)'Lead Times', 
      CONVERT(SUM(costs), 
      DECIMAL(8,2))'Cost'
FROM chain
GROUP BY `Routes`
ORDER BY `lead times`
DESC
; 
~~~
| **Routes**  | **Lead Times** | **Cost**  |
|---------|------------|-------|
| Route B | 637        | 22040 |
| Route A | 632        | 20875 |
| Route C | 327        | 10009 |

~~~ SQL
/* Average Defect Rate For Each Product */
SELECT 
      `product type`, 
      CAST(SUM(`Defect rates`)/COUNT(`Defect rates`) 
      AS DECIMAL (3,2))'Average Defect Rate' 
FROM chain
GROUP BY `product type`
;
~~~
| **Product type** | **Average Defect Rate** |
|--------------|---------------------|
| haircare     | 2.48                |
| skincare     | 2.33                |
| cosmetics    | 1.92                |
|              |                     |

~~~ SQL
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
~~~
| **Inspection results** | **Manufacturing Costs** | **%Manufacturing Costs** |
|--------------------|---------------------|----------------------|
| Fail               | 1880.3              | 39.78                |
| Pending            | 1785.07             | 37.77                |
| Pass               | 1061.3              | 22.45                |

~~~ SQL
/*How Production Volume Relates To Stock Levels and Quantity*/
SELECT
      SUM(`Production Volumes`)`Production Volumes`,
      SUM(`Stock levels`)`Stock levels`,
      SUM(`Order Quantities`)`Order Quantities` 
FROM chain
;
~~~
| **Production Volumes** | **Stock levels** | **Order Quantities** |
|--------------------|--------------|------------------|
| 56784              | 4777         | 4922             |

~~~ SQL
/* Production Volumes Alinged With Market Demands */
SELECT 
      `Location`, 
      SUM(`Production volumes`)`Production Volume`
FROM chain
GROUP BY `Location`
ORDER BY `Production Volume` 
DESC
;
~~~
| **Location**  | **Production Volume** |
|-----------|-------------------|
| Kolkata   | 15451             |
| Mumbai    | 13160             |
| Chennai   | 11984             |
| Delhi     | 8362              |
| Bangalore | 7827              |

~~~ SQL
/* Percentage of Production Volumes Alinged With Market Demands */
SELECT 
      `Location`, 
      SUM(`Production volumes`)`Production Volume`,
	  (SUM(`Production volumes`)*100/(SELECT SUM(`Production volumes`) FROM chain))'%ProductionVolume'
FROM chain
GROUP BY `Location`
ORDER BY `Production Volume`
DESC 
;
~~~
| **Location**  | **Production Volume** | **%ProductionVolume** |
|-----------|-------------------|-------------------|
| Kolkata   | 15451             | 27.2101           |
| Mumbai    | 13160             | 23.1755           |
| Chennai   | 11984             | 21.1045           |
| Delhi     | 8362              | 14.726            |
| Bangalore | 7827              | 13.7838           |

~~~ SQL
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

~~~
~~~ SQL
SELECT 
* 
FROM chain
;
~~~
~~
