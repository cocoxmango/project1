excel_to_mysql.md

# 📊 Data Cleaning and Upload Process (Excel to MySQL)

This document describes how I prepared a COVID-19 dataset using Excel, and imported it into MySQL for analysis.

---

## 1. 🗂️ Source of the Data

- **File:** covid_data.csv
- **Source:** [example-source.com]
- **Description:** Daily COVID-19 statistics by country (cases, deaths, etc.)

---

## 2. 🧼 Excel Cleaning Steps

### ✅ Renamed Columns
- Changed column names for consistency:
  - `Total Cases` → `total_cases`
  - `Date Reported` → `report_date`
  - `New Deaths` → `new_deaths`

### ✅ Standardized Date Format
- Used Excel formula to convert date to `YYYY-MM-DD` format:



### ✅ Handled Missing Values
- Blank cells in numeric columns (`new_cases`, `new_deaths`) were replaced with `NULL` before export.

### ✅ Removed Duplicates
- Removed duplicate rows based on `country` + `report_date`.

---

## 3. 💾 Exported Cleaned File

- Saved final clean file as: `cleaned_covid.csv`
- Ensured it uses comma-separated format, UTF-8 encoding

---

## 4. 🐬 Imported into MySQL

### ✅ MySQL Table Structure
```sql
CREATE TABLE covid_data (
report_date DATE,
country VARCHAR(100),
total_cases INT,
new_cases INT,
total_deaths INT,
new_deaths INT
);

LOAD DATA INFILE '/path/to/cleaned_covid.csv'
INTO TABLE covid_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(report_date, country, total_cases, new_cases, total_deaths, new_deaths);
