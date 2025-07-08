### 📋 COVID Vaccinations Table Setup

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
<summary>📦 View `covid_vaccinations` Data Import SQL</summary>

```sql
LOAD DATA LOCAL INFILE '/path/to/CovidVaccinationsC.csv'
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