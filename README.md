### Car Theft Analysis Report: New Zealand 🚗🔍  

This repository delivers an in-depth analysis of vehicle theft patterns in New Zealand, utilizing SQL for data exploration and trend identification. The project investigates relationships between key data attributes and uncovers insights into theft patterns based on vehicle types, regional occurrences, manufacturing years, and time-based factors. Detailed methodologies and queries support findings aimed at improving theft prevention strategies and enhancing public safety efforts.  

---

### Key Features of the Analysis  

#### 1. **Data Overview**  
The analysis incorporates three relational tables—`stolen_vehicles`, `make_details`, and `locations`. Each table's structure and relationships are thoroughly explained to ensure clarity and facilitate replication. The data overview emphasizes critical aspects like stolen vehicle categories, theft locations, and reporting dates to build a solid analytical foundation.  

#### 2. **Data Integrity and Constraints**  
- **Primary Keys**: Guarantee the uniqueness of identifiers such as `vehicle_id`, `make_id`, and `location_id`.  
- **Foreign Keys**: Maintain table relationships, e.g., linking `make_id` in the `stolen_vehicles` table to the `make_details` table.  
- **NOT NULL Constraints**: Ensure key fields like `make_name`, `region`, and `date_stolen` always contain data.  
These constraints protect data integrity, establish reliable relationships, and reduce errors in analysis.  

#### 3. **Approach and Methodology**  
The study adopts a structured process to derive actionable insights:  
- **Data Preparation**: Data was extracted from the three primary tables.  
- **Exploratory Analysis**: Patterns were analyzed across timeframes, locations, vehicle types, manufacturers, and vehicle ages.  
- **SQL Queries**: The analysis uses queries with techniques like `GROUP BY`, `INNER JOIN`, and aggregation functions (`COUNT`, `AVG`). More advanced SQL concepts, including Common Table Expressions (CTEs) and stored procedures, were also employed.  

#### 4. **SQL Query Highlights and Observations**  
SQL queries were crafted to answer specific questions related to vehicle theft trends.  

**1. Annual Stolen Vehicle Totals**  
Query:  
```sql  
SELECT COUNT(vehicle_id) AS Number_cars_stolen,  
       YEAR(date_stolen) AS Year_stolen  
FROM stolen_vehicles  
GROUP BY YEAR(date_stolen);  
```  
Observation:  
- **2021**: 1,668 vehicles reported stolen.  
- **2022**: 2,885 vehicles stolen, a 73% rise.  

---

**2. Theft Trends by Weekday**  
Query:  
```sql  
SELECT DATENAME(WEEKDAY, date_stolen) AS Day_of_Week,  
       COUNT(vehicle_id) AS Theft_Count  
FROM stolen_vehicles  
GROUP BY DATENAME(WEEKDAY, date_stolen)  
ORDER BY Theft_Count DESC;  
```  
Observation:  
- Mondays had the most thefts (767).  
- Saturdays had the fewest (577).  

---

**3. Vehicle Types Most Commonly Stolen**  
Query:  
```sql  
SELECT vehicle_type,  
       COUNT(vehicle_type) AS Count_Stolen  
FROM stolen_vehicles  
GROUP BY vehicle_type  
ORDER BY COUNT(vehicle_type) DESC;  
```  
Observation:  
- Stationwagons were stolen most frequently (945 instances).  
- Convertibles were the least targeted (12 instances).  

---

**4. Popular Vehicle Makes Among Thieves**  
Query:  
```sql  
SELECT MKD.make_name,  
       COUNT(MKD.make_name) AS Theft_Count  
FROM stolen_vehicles AS STV  
INNER JOIN make_details AS MKD ON STV.make_id = MKD.make_id  
GROUP BY MKD.make_name  
ORDER BY Theft_Count DESC;  
```  
Observation:  
- Toyota was the most frequently stolen vehicle make, with 716 reported incidents.  

---

**5. Regional Theft Analysis**  
Query:  
```sql  
SELECT LCT.region,  
       COUNT(*) AS Theft_Count  
FROM locations AS LCT  
INNER JOIN stolen_vehicles AS STV ON LCT.location_id = STV.location_id  
GROUP BY LCT.region  
ORDER BY Theft_Count DESC;  
```  
Observation:  
- Auckland recorded the highest number of thefts (1,638 vehicles).  

---

**6. Average Age of Stolen Vehicles**  
Query:  
```sql  
WITH VehicleAge AS (  
    SELECT model_year,  
           YEAR(GETDATE()) - model_year AS Age  
    FROM stolen_vehicles  
)  
SELECT AVG(Age) AS Average_Age  
FROM VehicleAge;  
```  
Observation:  
- The average age of stolen vehicles was 18 years, suggesting older vehicles are more vulnerable.  

---

### Key Insights  

1. **Time-Based Trends**:  
   - Theft incidents peaked on Mondays and declined on Saturdays.  
2. **Vehicle Susceptibility**:  
   - Stationwagons were the most targeted vehicle type.  
   - Toyota was the leading manufacturer in theft cases, particularly older models.  
3. **Vulnerable Vehicles**:  
   - Older vehicles (average age 18–21 years) are more susceptible to theft due to outdated security measures.  
4. **Regional Analysis**:  
   - Auckland accounted for the majority of vehicle thefts, far surpassing other regions.  

---

### Recommendations  

1. **Security Enhancements for Older Vehicles**:  
   - Promote the use of modern anti-theft systems and immobilizers for vehicles with outdated features.  
2. **Strategic Policing and Surveillance**:  
   - Increase monitoring and enforcement in high-risk areas like Auckland.  
3. **Awareness Campaigns**:  
   - Educate the public about theft patterns and preventive measures, particularly for high-risk vehicle types and regions.  
4. **Policy Interventions**:  
   - Use data insights to guide resource allocation and policy-making efforts for crime prevention.  


This project highlights the value of data-driven strategies in tackling vehicle theft. By leveraging SQL and well-defined methodologies, it offers actionable insights for improving vehicle security and reducing crime. 🚀  
