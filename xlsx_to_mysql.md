# 📊 Data Cleaning and Upload Process (Excel to MySQL)

This document describes how I prepared a COVID-19 dataset using Excel, and imported it into MySQL for analysis.

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
- Replaced blank cells in important numeric columns (`new_cases`, `new_deaths`) with `NULL` to avoid data integrity issues when importing into MySQL.

### ✅ Standardized Date Format
- Converted all dates to the format `YYYY-MM-DD` using the `TEXT()` formula: TEXT(A2, "yyyy-mm-dd")


### ✅ Removed Extra Spaces
- Used the `TRIM()` function in Excel to remove extra spaces from text fields like `country` and `continent` to prevent mismatches in MySQL or Tableau.

---

## 💾 3. Exported Cleaned File

- Final cleaned file saved as: `cleaned_covid.csv`
- Ensured UTF-8 encoding and comma delimiters were preserved before importing to MySQL

---

## 🐬 4. MySQL Import Process

### 📋 MySQL Table Schema

```sql
CREATE TABLE covid_data (
report_date DATE,
country VARCHAR(100),
total_cases INT,
new_cases INT,
total_deaths INT,
new_deaths INT
);
