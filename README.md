# Excel Cleaning Steps\
\
## 1. Opened raw CSV data in Excel\
\
- File name: `raw_covid.csv`\
- Columns: Date, Country, Total Cases, New Cases, Total Deaths, New Deaths\
\
## 2. Cleaned the data\
\
- Renamed columns (e.g., "Total Cases" 
\f1 \uc0\u8594 
\f0  "total_cases")\
- Converted date column to standard format (YYYY-MM-DD)\
- Filled missing values with 0 in new_cases and new_deaths\
- Removed duplicate rows\
- Saved final clean file as `cleaned_covid.xlsx`\
\
## 3. Loaded to MySQL\
\
- Exported to CSV\
- Used this command in MySQL:\
  ```sql\
  LOAD DATA INFILE 'cleaned_covid.csv'\
  INTO TABLE covid_data\
  FIELDS TERMINATED BY ','\
  ENCLOSED BY '"'\
  LINES TERMINATED BY '\\n'\
  IGNORE 1 ROWS;\
}
