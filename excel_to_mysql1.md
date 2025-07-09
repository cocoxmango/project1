# 📊 Data Cleaning and Upload Process (Excel to MySQL)

This document explains how I cleaned and imported two COVID-19 datasets — one for deaths and one for vaccinations — from Excel to MySQL. 
These were used for SQL analysis and Tableau visualization.


---

## 1. 🗂️ Source of the Data

- **File:** Raw_CovidDeaths.xlsx, Raw_Covid_Vaccinations.xlsx
- **Source:** https://ourworldindata.org/covid-deaths
- **Description:** Daily COVID-19 statistics by country (cases, deaths, etc.)

---

## 🧼 2. Excel Cleaning Steps

### ✅ Converted Excel to CSV
- Opened raw data and saved it as CSV for compatibility with MySQL import.

### ✅ Highlighted and Removed Duplicate Rows
- Used Excel's **Conditional Formatting → Highlight Duplicate Values** on `location` and `date` columns.
- Manually reviewed and deleted duplicate rows to ensure clean, unique records.

### ✅ Handled Missing Values
- Instead of replacing millions of blank cells manually in Excel, I used the `NULLIF()` function in the SQL import script to convert empty strings to `NULL` during the `LOAD DATA` process.
- This ensured that missing numeric data (e.g., `new_cases`, `new_deaths`, etc.) was properly represented as `NULL` in the MySQL database, preserving data integrity and avoiding analysis errors.

### ✅ Standardized Date Format
- Converted all dates with previous format of `MM-DD-YYYY` to `YYYY-MM-DD` using the `TEXT()` formula: TEXT(A2, "yyyy-mm-dd")


### ✅ Removed Extra Spaces
- Used the `TRIM()` function in Excel to remove extra spaces from text fields like `location` and `continent` to prevent mismatches in MySQL or Tableau.

---

## 💾 3. Exported Cleaned File

- Final cleaned file saved as: `cleaned_covid_deaths.csv` and `cleaned_covid_vaccinations.csv` 
- Ensured UTF-8 encoding and comma delimiters were preserved before importing to MySQL

---

## 🐬 4. MySQL Import Process

- Created 2 Table Schemas + Ran Import Code

### 📋 MySQL Table Schema Code (Covid_Deaths)

```sql
CREATE TABLE covid_deaths (
    id INT AUTO_INCREMENT PRIMARY KEY,
    iso_code VARCHAR(10) NOT NULL,
    continent VARCHAR(50),
    location VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    
    total_cases INT,
    new_cases INT,
    new_cases_smoothed DECIMAL(10, 2),
    total_deaths INT,
    new_deaths INT,
    new_deaths_smoothed DECIMAL(10, 2),

    total_cases_per_million DECIMAL(12, 2),
    new_cases_per_million DECIMAL(12, 2),
    new_cases_smoothed_per_million DECIMAL(12, 2),
    
    total_deaths_per_million DECIMAL(12, 2),
    new_deaths_per_million DECIMAL(12, 2),
    new_deaths_smoothed_per_million DECIMAL(12, 2),
    reproduction_rate DECIMAL(5, 3),

    icu_patients INT,
    icu_patients_per_million DECIMAL(10, 2),
    hosp_patients INT,
    hosp_patients_per_million DECIMAL(10, 2),
    
    weekly_icu_admissions INT,
    weekly_icu_admissions_per_million DECIMAL(10, 2),
    weekly_hosp_admissions INT,
    weekly_hosp_admissions_per_million DECIMAL(10, 2),

    new_tests INT,
    total_tests INT,
    total_tests_per_thousand DECIMAL(10, 2),
    new_tests_per_thousand DECIMAL(10, 2),
    new_tests_smoothed DECIMAL(10, 2),
    new_tests_smoothed_per_thousand DECIMAL(10, 2),

    positive_rate DECIMAL(6, 4),
    tests_per_case DECIMAL(6, 2),
    tests_units VARCHAR(50),

    total_vaccinations INT,
    people_vaccinated INT,
    people_fully_vaccinated INT,
    new_vaccinations INT,
    new_vaccinations_smoothed DECIMAL(10, 2),

    total_vaccinations_per_hundred DECIMAL(6, 2),
    people_vaccinated_per_hundred DECIMAL(6, 2),
    people_fully_vaccinated_per_hundred DECIMAL(6, 2),
    new_vaccinations_smoothed_per_million DECIMAL(12, 2),
    stringency_index DECIMAL(6, 2),

    population BIGINT,
    population_density DECIMAL(10, 2),
    median_age DECIMAL(4, 1),
    aged_65_older DECIMAL(5, 2),
    aged_70_older DECIMAL(5, 2),
    gdp_per_capita DECIMAL(12, 2),
    extreme_poverty DECIMAL(5, 2),
    cardiovasc_death_rate DECIMAL(10, 2),
    diabetes_prevalence DECIMAL(5, 2),
    female_smokers DECIMAL(5, 2),
    male_smokers DECIMAL(5, 2),
    handwashing_facilities DECIMAL(5, 2),
    hospital_beds_per_thousand DECIMAL(5, 2),
    life_expectancy DECIMAL(5, 2),
    human_development_index DECIMAL(5, 3)
);
```

### 📋 MySQL File Import Code
```sql
LOAD DATA LOCAL INFILE '/Users/cocoxmango/Desktop/Portfolio_Project/Cleaned_Covid_Deaths.csv'
INTO TABLE covid_deaths
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  iso_code,
  continent,
  location,
  date,
  total_cases,
  new_cases,
  new_cases_smoothed,
  total_deaths,
  new_deaths,
  new_deaths_smoothed,
  total_cases_per_million,
  new_cases_per_million,
  new_cases_smoothed_per_million,
  total_deaths_per_million,
  new_deaths_per_million,
  new_deaths_smoothed_per_million,
  reproduction_rate,
  icu_patients,
  icu_patients_per_million,
  hosp_patients,
  hosp_patients_per_million,
  weekly_icu_admissions,
  weekly_icu_admissions_per_million,
  weekly_hosp_admissions,
  weekly_hosp_admissions_per_million,
  new_tests,
  total_tests,
  total_tests_per_thousand,
  new_tests_per_thousand,
  new_tests_smoothed,
  new_tests_smoothed_per_thousand,
  positive_rate,
  tests_per_case,
  tests_units,
  total_vaccinations,
  people_vaccinated,
  people_fully_vaccinated,
  new_vaccinations,
  new_vaccinations_smoothed,
  total_vaccinations_per_hundred,
  people_vaccinated_per_hundred,
  people_fully_vaccinated_per_hundred,
  new_vaccinations_smoothed_per_million,
  stringency_index,
  population,
  population_density,
  median_age,
  aged_65_older,
  aged_70_older,
  gdp_per_capita,
  extreme_poverty,
  cardiovasc_death_rate,
  diabetes_prevalence,
  female_smokers,
  male_smokers,
  handwashing_facilities,
  hospital_beds_per_thousand,
  life_expectancy,
  human_development_index
)
SET
  total_cases = NULLIF(total_cases, ''),
  new_cases = NULLIF(new_cases, ''),
  new_cases_smoothed = NULLIF(new_cases_smoothed, ''),
  total_deaths = NULLIF(total_deaths, ''),
  new_deaths = NULLIF(new_deaths, ''),
  new_deaths_smoothed = NULLIF(new_deaths_smoothed, ''),
  total_cases_per_million = NULLIF(total_cases_per_million, ''),
  new_cases_per_million = NULLIF(new_cases_per_million, ''),
  new_cases_smoothed_per_million = NULLIF(new_cases_smoothed_per_million, ''),
  total_deaths_per_million = NULLIF(total_deaths_per_million, ''),
  new_deaths_per_million = NULLIF(new_deaths_per_million, ''),
  new_deaths_smoothed_per_million = NULLIF(new_deaths_smoothed_per_million, ''),
  reproduction_rate = NULLIF(reproduction_rate, ''),
  icu_patients = NULLIF(icu_patients, ''),
  icu_patients_per_million = NULLIF(icu_patients_per_million, ''),
  hosp_patients = NULLIF(hosp_patients, ''),
  hosp_patients_per_million = NULLIF(hosp_patients_per_million, ''),
  weekly_icu_admissions = NULLIF(weekly_icu_admissions, ''),
  weekly_icu_admissions_per_million = NULLIF(weekly_icu_admissions_per_million, ''),
  weekly_hosp_admissions = NULLIF(weekly_hosp_admissions, ''),
  weekly_hosp_admissions_per_million = NULLIF(weekly_hosp_admissions_per_million, ''),
  new_tests = NULLIF(new_tests, ''),
  total_tests = NULLIF(total_tests, ''),
  total_tests_per_thousand = NULLIF(total_tests_per_thousand, ''),
  new_tests_per_thousand = NULLIF(new_tests_per_thousand, ''),
  new_tests_smoothed = NULLIF(new_tests_smoothed, ''),
  new_tests_smoothed_per_thousand = NULLIF(new_tests_smoothed_per_thousand, ''),
  positive_rate = NULLIF(positive_rate, ''),
  tests_per_case = NULLIF(tests_per_case, ''),
  total_vaccinations = NULLIF(total_vaccinations, ''),
  people_vaccinated = NULLIF(people_vaccinated, ''),
  people_fully_vaccinated = NULLIF(people_fully_vaccinated, ''),
  new_vaccinations = NULLIF(new_vaccinations, ''),
  new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, ''),
  total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, ''),
  people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, ''),
  people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, ''),
  new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, '')

```

<!-- <details> -->
<!-- <summary>📦 View `covid_vaccinations` MySQL File Import Code</summary> -->





### 📋 Covid_Vaccinations Table Creation + Import

<details> 
<summary>🧱 View `covid_vaccinations` Table Schema</summary>

```sql
CREATE TABLE covid_vaccinations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    iso_code VARCHAR(10) NULL,
    continent VARCHAR(50) NULL,
    location VARCHAR(100) NULL,
    date DATE NULL,

    new_tests INT NULL,
    total_tests INT NULL,
    total_tests_per_thousand DECIMAL(10,2) NULL,
    new_tests_per_thousand DECIMAL(10,2) NULL,
    new_tests_smoothed DECIMAL(10,2) NULL,
    new_tests_smoothed_per_thousand DECIMAL(10,2) NULL,

    positive_rate DECIMAL(10,4) NULL,
    tests_per_case DECIMAL(10,2) NULL,
    tests_units VARCHAR(50) NULL,

    total_vaccinations INT NULL,
    people_vaccinated INT NULL,
    people_fully_vaccinated INT NULL,
    new_vaccinations INT NULL,
    new_vaccinations_smoothed DECIMAL(10,2) NULL,

    total_vaccinations_per_hundred DECIMAL(10,2) NULL,
    people_vaccinated_per_hundred DECIMAL(10,2) NULL,
    people_fully_vaccinated_per_hundred DECIMAL(10,2) NULL,
    new_vaccinations_smoothed_per_million DECIMAL(12,2) NULL,

    stringency_index DECIMAL(10,2) NULL,
    population_density DECIMAL(10,2) NULL,
    median_age DECIMAL(5,2) NULL,
    aged_65_older DECIMAL(5,2) NULL,
    aged_70_older DECIMAL(5,2) NULL,
    gdp_per_capita DECIMAL(12,2) NULL,
    extreme_poverty DECIMAL(5,2) NULL,
    cardiovasc_death_rate DECIMAL(10,2) NULL,
    diabetes_prevalence DECIMAL(5,2) NULL,
    female_smokers DECIMAL(5,2) NULL,
    male_smokers DECIMAL(5,2) NULL,
    handwashing_facilities DECIMAL(10,2) NULL,
    hospital_beds_per_thousand DECIMAL(5,2) NULL,
    life_expectancy DECIMAL(5,2) NULL,
    human_development_index DECIMAL(5,3) NULL
);
```

</details>

<details>
<summary>📦 View `covid_vaccinations` MySQL File Import Code</summary>

```sql
LOAD DATA LOCAL INFILE '/path/to/Cleaned_Covid_Vaccinations.csv'
INTO TABLE covid_vaccinations
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    iso_code,
    continent,
    location,
    date,
    new_tests,
    total_tests,
    total_tests_per_thousand,
    new_tests_per_thousand,
    new_tests_smoothed,
    new_tests_smoothed_per_thousand,
    positive_rate,
    tests_per_case,
    tests_units,
    total_vaccinations,
    people_vaccinated,
    people_fully_vaccinated,
    new_vaccinations,
    new_vaccinations_smoothed,
    total_vaccinations_per_hundred,
    people_vaccinated_per_hundred,
    people_fully_vaccinated_per_hundred,
    new_vaccinations_smoothed_per_million,
    stringency_index,
    population_density,
    median_age,
    aged_65_older,
    aged_70_older,
    gdp_per_capita,
    extreme_poverty,
    cardiovasc_death_rate,
    diabetes_prevalence,
    female_smokers,
    male_smokers,
    handwashing_facilities,
    hospital_beds_per_thousand,
    life_expectancy,
    human_development_index
)
SET
    new_tests = NULLIF(new_tests, ''),
    total_tests = NULLIF(total_tests, ''),
    total_tests_per_thousand = NULLIF(total_tests_per_thousand, ''),
    new_tests_per_thousand = NULLIF(new_tests_per_thousand, ''),
    new_tests_smoothed = NULLIF(new_tests_smoothed, ''),
    new_tests_smoothed_per_thousand = NULLIF(new_tests_smoothed_per_thousand, ''),
    positive_rate = NULLIF(positive_rate, ''),
    tests_per_case = NULLIF(tests_per_case, ''),
    total_vaccinations = NULLIF(total_vaccinations, ''),
    people_vaccinated = NULLIF(people_vaccinated, ''),
    people_fully_vaccinated = NULLIF(people_fully_vaccinated, ''),
    new_vaccinations = NULLIF(new_vaccinations, ''),
    new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, ''),
    total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, ''),
    people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, ''),
    people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, ''),
    new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, ''),
    stringency_index = NULLIF(stringency_index, ''),
    population_density = NULLIF(population_density, ''),
    median_age = NULLIF(median_age, ''),
    aged_65_older = NULLIF(aged_65_older, ''),
    aged_70_older = NULLIF(aged_70_older, ''),
    gdp_per_capita = NULLIF(gdp_per_capita, ''),
    extreme_poverty = NULLIF(extreme_poverty, ''),
    cardiovasc_death_rate = NULLIF(cardiovasc_death_rate, ''),
    diabetes_prevalence = NULLIF(diabetes_prevalence, ''),
    female_smokers = NULLIF(female_smokers, ''),
    male_smokers = NULLIF(male_smokers, ''),
    handwashing_facilities = NULLIF(handwashing_facilities, ''),
    hospital_beds_per_thousand = NULLIF(hospital_beds_per_thousand, ''),
    life_expectancy = NULLIF(life_expectancy, ''),
    human_development_index = NULLIF(human_development_index, '');
```

</details>