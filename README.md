

```markdown
# Car Theft Analysis Report: New Zealand

This report explores vehicle theft trends using SQL analysis, detailing data definitions, constraints, and methodologies. Insights include theft patterns by region, vehicle type, age, and temporal trends for informed decision-making.

---

## 1. Data Dictionary

The following tables were used for the analysis:

| Table Name       | Column Name    | Data Type | Description                                       |
|-------------------|----------------|-----------|---------------------------------------------------|
| **stolen_vehicles** | vehicle_id     | INT       | Unique identifier for each stolen vehicle         |
|                   | make_id        | INT       | Foreign key referencing vehicle make details      |
|                   | location_id    | INT       | Foreign key referencing the locations table       |
|                   | vehicle_type   | VARCHAR   | Type of the stolen vehicle (e.g., Stationwagon)   |
|                   | model_year     | INT       | Manufacturing year of the stolen vehicle          |
|                   | date_stolen    | DATE      | Date when the vehicle was reported stolen         |
| **make_details**   | make_id        | INT       | Unique identifier for vehicle makes               |
|                   | make_name      | VARCHAR   | Name of the vehicle's manufacturer (e.g., Toyota) |
| **locations**      | location_id    | INT       | Unique identifier for locations                   |
|                   | region         | VARCHAR   | Region where the vehicle was stolen (e.g., Auckland) |
|                   | population     | INT       | Population of the region                          |
|                   | density        | FLOAT     | Population density of the region                 |

---

## 2. Constraints and Their Usage

- **Primary Key Constraints**: Ensures the uniqueness of records.
  - `vehicle_id` in `stolen_vehicles`
  - `make_id` in `make_details`
  - `location_id` in `locations`
  
- **Foreign Key Constraints**: Establishes relationships between tables.
  - `make_id` in `stolen_vehicles` references `make_details`
  - `location_id` in `stolen_vehicles` references `locations`
  
- **NOT NULL Constraints**: Ensures mandatory fields like `make_name`, `region`, and `date_stolen` cannot be null.

These constraints maintain data integrity, ensure accurate relationships, and prevent incomplete records.

---

## 3. Methodology

### Steps:
1. **Data Collection**: 
   - Data was extracted from the `stolen_vehicles`, `make_details`, and `locations` tables.
   
2. **Exploratory Data Analysis**: 
   - Analyzed car theft patterns by year, day of the week, vehicle type, make, region, and vehicle age.
   
3. **SQL Queries**: 
   - Developed queries using `GROUP BY`, `INNER JOIN`, and aggregation functions like `COUNT()` and `AVG()`.

---

## 4. Explanation of Queries and Findings

### 1. Total Number of Stolen Cars Each Year
```sql
SELECT COUNT(vehicle_id) AS Number_cars_stolen,
       YEAR(date_stolen) AS Years_stolen
FROM stolen_vehicles
GROUP BY YEAR(date_stolen);
```
**Findings**:
- **2021**: 1,668 cars stolen
- **2022**: 2,885 cars stolen (73% increase).

---

### 2. Car Theft by Day of the Week
```sql
SELECT DATENAME(WEEKDAY, date_stolen) AS DayOfWeekStolen,
       COUNT(vehicle_id) AS Theft_Count
FROM stolen_vehicles
GROUP BY DATENAME(WEEKDAY, date_stolen)
ORDER BY Theft_Count DESC;
```
**Findings**:
- Highest thefts: **Monday** (767 incidents).
- Lowest thefts: **Saturday** (577 incidents).

---

### 3. Vehicle Types Most Frequently Stolen
```sql
SELECT vehicle_type,
       COUNT(vehicle_type) AS NumberTimesStolen
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(vehicle_type) DESC;
```
**Findings**:
- Most targeted: **Stationwagons** (945 thefts).
- Least targeted: **Convertible** (12 thefts).

---

### 4. Most Frequently Stolen Vehicle Makes
```sql
SELECT MKD.make_name,
       COUNT(MKD.make_name) AS VehicleMakeCount
FROM stolen_vehicles AS STV
INNER JOIN make_details AS MKD ON STV.make_id = MKD.make_id
GROUP BY MKD.make_name
ORDER BY VehicleMakeCount DESC;
```
**Findings**:
- Most stolen: **Toyota** (716 incidents).

---

### 5. Theft Patterns by Region
```sql
SELECT LCT.region,
       COUNT(*) AS VehicleMakeCount
FROM locations AS LCT
INNER JOIN stolen_vehicles AS STV ON LCT.location_id = STV.location_id
GROUP BY LCT.region
ORDER BY VehicleMakeCount DESC;
```
**Findings**:
- Highest thefts: **Auckland** (1,638 incidents).

---

### 6. Average Age of Stolen Vehicles
Using a Common Table Expression (CTE):
```sql
WITH CarAge AS (
    SELECT model_year,
           YEAR(GETDATE()) - model_year AS CurrentCarAge
    FROM stolen_vehicles
)
SELECT AVG(CurrentCarAge) AS AverageCarAge
FROM CarAge;
```
**Findings**:
- Average age of stolen vehicles: **18 years**.

---

### 7. Vehicle Age and Theft Count by Vehicle Type
```sql
SELECT vehicle_type,
       AVG(YEAR(GETDATE()) - model_year) AS AverageCarAge,
       COUNT(vehicle_type) AS No_Times_Stolen
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY No_Times_Stolen DESC;
```
**Findings**:
- **Stationwagons** (21 years old on average) are the most frequently stolen.

---

### 8. Stored Procedure to Fetch Stolen Vehicle Details
```sql
CREATE PROCEDURE Theft_facts
    @Vehicle_id INT
AS
BEGIN
    SELECT vehicle_id,
           make_name,
           vehicle_type,
           model_year,
           LT.region AS REGION_STOLEN,
           country,
           date_stolen
    FROM stolen_vehicles STV
    INNER JOIN locations LT ON STV.location_id = LT.location_id
    INNER JOIN make_details MKD ON STV.make_id = MKD.make_id
    WHERE vehicle_id = @Vehicle_id;
END;

EXEC Theft_facts @Vehicle_id = 10;
```
**Benefits**:
- Controlled access to vehicle details.
- Flexibility and enhanced database security.

---

## 5. Key Insights and Conclusions

1. **Temporal Analysis**: Theft rates peak on Mondays and are lowest on Saturdays.
2. **Vehicle Types**: Stationwagons and Saloons are prime targets.
3. **Vehicle Age**: Older vehicles (average 18-21 years) are more prone to theft.
4. **Regional Patterns**: Auckland experiences the most thefts.
5. **Most Stolen Makes**: Toyota dominates, with older models being the primary focus.

---

## 6. Recommendations

- Implement advanced security measures for older vehicles.
- Increase surveillance and awareness in Auckland.
- Monitor high-risk days like Mondays for preventive action.
```

