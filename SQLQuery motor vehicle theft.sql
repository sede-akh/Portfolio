USE Motor_Vehicle_Theft;

SELECT * 
		FROM stolen_vehicles;

SELECT * 
		FROM locations;


		SELECT * 
		FROM make_details;

 SELECT COUNT(vehicle_id)
 from stolen_vehicles;
		
		SELECT 
        
        AVG(YEAR(GETDATE() - model_year 
    FROM 
        stolen_vehicles;

				
				
				
				
				------- EXPLORATORY ANALYSIS--------




-----1. Number of cars stolen each year----
SELECT COUNT(vehicle_id) AS Number_cars_stolen,
		YEAR (date_stolen) As Years_stolen
		
		FROM stolen_vehicles
		GROUP BY YEAR (date_stolen);
		;
/*Analysis Overview:
In 2021, 1,668 cars were reported stolen, while in 2022, the number increased to 2,885.


2.  Next, we aim to analyze which day of the week saw the highest and lowest incidences of car theft, 
	providing insights into temporal patterns in vehicle theft occurrences*/


SELECT
	 DATENAME(WEEKDAY, date_stolen) AS DayOfWeekStolen,
	 Count(Vehicle_id) As Theft_Count
FROM
	 Stolen_Vehicles
	 GROUP BY DATENAME(WEEKDAY, date_stolen)

	 ORDER BY Theft_Count DESC;

 /*										Findings:
Analysis reveals that the highest number of cars were stolen on Monday (767 incidents),
followed by Tuesday (711 incidents). Conversely, Saturday recorded the lowest number of thefts, with 577 incidents*/



/*3.	Objective:
		To determine the types of vehicles that are most and least frequently stolen and analyze whether this pattern varies 
across different regions*/


	  SELECT 
		     vehicle_type,
			 COUNT( Vehicle_type) as NumberTimesStolen
	  FROM   
			 stolen_vehicles 
	  GROUP BY 
		     vehicle_type
	  ORDER BY COUNT(Vehicle_type) Desc;
		
/* Findings:
The analysis indicates that Stationwagons are the most frequently stolen vehicles, with a total of 945 thefts. 
They are followed by Saloon cars. In contrast, Articulated Trucks were the least stolen vehicles*/

/*4.		Objective:
	Using an inner join, I will identify the make and vehicle types of cars that are most frequently stolen. 
	The inner join is essential because the "stolen cars" table provides the necessary data on stolen vehicles, while the "make name" table only catalogs 
	vehicle makes without documenting the theft details.*/


   SELECT  
    MKD.make_name,
    COUNT(MKD.make_name) AS VehicleMakeCount
FROM 
    stolen_vehicles AS STV
INNER JOIN
    make_details AS MKD
ON 
    STV.make_id = MKD.make_id
GROUP BY
    MKD.make_name
ORDER BY 
    VehicleMakeCount DESC;


/*Findings:
The analysis reveals that Toyota vehicles are the most frequently stolen, with a total of 716 thefts*/

/*5.	Objective:
	To investigate and identify patterns of vehicle theft across different regions. By analyzing stolen cars by region, 
	we aim to uncover regional variations in theft occurrences, which may help in understanding regional factors influencing
	the frequency of vehicle thefts. This analysis will enable better-targeted preventive measures and provide insights into 
	crime patterns by location*/


SELECT  
    LCT.region,
	MKD.make_name,
    COUNT(MKD.make_name) AS VehicleMakeCount
    
FROM
    locations AS LCT
INNER JOIN 
    stolen_vehicles AS STV
ON
    LCT.location_id = STV.location_id
INNER JOIN 
    make_details AS MKD
ON
    STV.make_id = MKD.make_id
GROUP BY 
    LCT.region,
    MKD.make_name
ORDER BY 
    VehicleMakeCount DESC
	;
/*Findings:
Auckland, New Zealand, has the highest number of stolen vehicles, with Toyota leading the list, accounting for 273 thefts*/

/*6.	Objective:
		To calculate the average age of vehicles that are stolen, providing insights into whether the age of a vehicle influences
		its likelihood of being targeted. This analysis will help identify trends in vehicle theft, such as whether older or newer 
		cars are more susceptible to theft. Understanding the average age of stolen vehicles can inform preventive measures, 
		such as security enhancements for certain vehicle models or age groups, and contribute to broader crime prevention strategies*/



SELECT 
    model_year,
    YEAR(GETDATE()) - model_year AS CurrentAge
FROM 
    stolen_vehicles;


	/*-Findings:
	This query successfully returns the ages of all the vehicles that were stolen, providing a comprehensive
	overview of vehicle ages involved in theft incidents*/

/*6.	Objective:
		Using a Common Table Expression (CTE), I will demonstrate how to calculate the average age of stolen vehicles. 
		By utilizing CTEs, we can streamline the process of data aggregation and analysis. 
		The CTE will allow for a more organized approach to calculate and present the average age of stolen cars, 
		enabling a clearer understanding of trends over time. This analysis will help assess whether certain vehicle
		age groups are more prone to theft, potentially guiding law enforcement and car owners in taking preventative 
		actions based on the age-related vulnerability of vehicles */





	WITH CarAge AS (
    SELECT 
        model_year,
        YEAR(GETDATE()) - model_year AS CurrentCarAge
    FROM 
        stolen_vehicles
)
SELECT AVG(CurrentCarAge) AS AverageCarAge
FROM CarAge;

/*	Findings:
	The analysis indicates that the average age of the vehicles stolen is 18 years, providing insight into the typical age group
	of stolen cars*/

/*7.	Alternate Approach: The object is to group accordiing to vehicle type
		This method aims to display the variation in vehicle age based on vehicle type and the frequency of theft. By examining these 
		factors, we can identify specific vehicle types that are more susceptible to theft, as well as discern any patterns related 
		to the age of the vehicle. This analysis will enhance our understanding of how vehicle characteristics, including age and type, 
		influence theft trends, allowing for more targeted prevention strategies*/


SELECT  vehicle_type,
		AVG(YEAR(GETDATE()) - model_year) AS AverageCarAge,
		COUNT(Vehicle_type) as No_Times_Stolen
		FROM stolen_vehicles
		Group by vehicle_type
		ORDER BY No_Times_Stolen DESC;

		/*Findings:
		The analysis reveals that Stationwagons, with an average age of 21 years, are the most frequently stolen vehicles, with a 
		total of 945 thefts. This suggests that older Stationwagons are particularly vulnerable to theft, possibly due to factors 
		such as wear and tear, lower security features, or high demand for parts. Understanding this trend highlights the need for targeted security measures, such as enhanced anti-theft systems or 
		increased vigilance, especially for older vehicle models.*/

/* 8.	OBJECTIVE: Group the average age of the car by the make_name*/

SELECT  make_name,
		AVG(YEAR(GETDATE()) - model_year) AS AverageCarAge,
		COUNT(Vehicle_type) as No_Times_Stolen
		FROM stolen_vehicles as STV
		INNER JOIN make_details as MKD
		ON stv.make_id= mkd.make_id
		Group by make_name
		ORDER BY No_Times_Stolen DESC;

/*Findings:
The analysis indicates that Toyotas, with an average age of 21 years, are the most frequently stolen vehicles, 
with a total of 716 thefts. This highlights a pattern where older Toyota models are notably susceptible to theft, 
which may be attributed to factors such as high demand for spare parts or less advanced security features*/

/*9.	Objective:
Using a temporary table and an inner join, I will demonstrate which regions experience the highest and lowest numbers of 
vehicle thefts, along with the characteristics of these regions. By joining relevant data tables, the analysis will provide 
insights into regional theft patterns, helping to identify locations with higher theft rates. Furthermore, understanding 
the demographics and characteristics of these regions—such as population density, socio-economic factors, or geographic 
location—will enable more targeted and effective crime prevention strategies. This approach aims to inform law enforcement 
and policy-making efforts to reduce vehicle theft in specific areas*/
	

	
SELECT 
    STV.location_id,
    LT.region,
    LT.population,
    LT.density,
    COUNT(vehicle_id) AS Theft_Count
INTO #Theft_region_count
FROM 
    stolen_vehicles AS STV
INNER JOIN 
    locations AS LT
ON 
    STV.location_id = LT.location_id
GROUP BY 
    STV.location_id,
    LT.region,
    LT.population,
    LT.density
ORDER BY 
    COUNT(vehicle_id) desc ;
	
	SELECT *
FROM #Theft_region_count
ORDER BY Theft_Count DESC;

/*		Findings:
The analysis shows that the Auckland region in New Zealand has the highest number of stolen vehicles, 
totaling 1,638 thefts, while Southland has the fewest, with just 26 stolen cars. This provides insight into 
regional patterns of vehicle theft, with Auckland clearly experiencing a significantly higher rate of theft 
compared to other regions*/

/* 10.		Objective:
I aim to create a dynamic stored procedure that allows the user to retrieve the number of stolen cars in a particular region.
This dynamic approach will enable flexibility, allowing users to input different region names as parameters to view theft data 
for any specified location. By making this procedure dynamic, we can easily adapt to various regions and analyze theft trends 
across different geographic areas, aiding in targeted crime prevention and resource allocation*/




	CREATE PROCEDURE Theft_facts
    @Vehicle_id INT -- Input parameter
AS
BEGIN
    SELECT  
        vehicle_id,
        make_name,
        vehicle_type,
        model_year,
        LT.region AS REGION_STOLEN,
        country,
        date_stolen
    FROM 
        stolen_vehicles STV
    INNER JOIN 
        locations LT ON STV.location_id = LT.location_id
    INNER JOIN 
        make_details MKD ON STV.make_id = MKD.make_id
    WHERE 
        vehicle_id = @Vehicle_id; -- Filter by input parameter
END;

EXEC Theft_facts @Vehicle_id = 10;

/*	11.	Objective:
In this case, I have created a procedure to retrieve the details of a stolen car using the vehicle ID. 
By using the vehicle ID as an input parameter, users can obtain detailed information about the stolen vehicle. 
This approach helps provide controlled access to the database, ensuring that users can perform specific, predefined 
operations without exposing direct access to sensitive tables. By encapsulating database logic within procedures, 
we enhance security and streamline the process, limiting access to only the necessary information while maintaining 
data integrity*/








