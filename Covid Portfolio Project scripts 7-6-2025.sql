/*

-- Inspect covid_deaths table

describe covid_deaths;

select * from covid_deaths;



-- Looking at Total Cases vs Total Deaths
-- Find percentage of Total Deaths divided by Total Cases for each country

Select location, date, total_cases, total_deaths, (total_deaths / total_cases) *100 as Total_Death_percentage
FROM covid_deaths
Order by 1,2 ;

-- Find infection rate for the united states

Select location, date, population, total_cases, (total_cases/population) *100 as Infection_Rate
FROM covid_deaths
Where location = 'united states'
AND continent is not null
order by 1,2 ;


-- Find Countries with highest infecection rate compared to population

Select location, population, max(total_cases) as Highest_Infection,  max((total_cases/population)) *100 as Infection_Rate
FROM covid_deaths
WHERE continent is not null
Group by 1,2
Order by 4 desc;


-- Find countries with Higest Death Count per Population

Select location, max(total_deaths) as Total_Deaths_Count
FROM covid_deaths
WHERE continent is not null
Group by 1
Order by 2 desc ;

-- Find Continent with Highest Death Count Per Population

Select continent, max(total_deaths) as Total_Deaths_Count
FROM covid_deaths
WHERE continent is not null
Group by 1
Order by 2 desc ;


-- Find Global total for new cases, new deaths, and death percentage

Select sum(new_cases), sum(new_deaths), sum(new_deaths)/sum(new_cases) * 100 as Death_Percentage
FROM covid_deaths
Order by 1,2;



-- Inspect covid vaccinations data

describe covid_vaccinations;

Select * from covid_vaccinations;

-- Join tables covid_deaths and covid_vaccinations

Select *
From covid_deaths dea
JOIN covid_vaccinations vac
	ON dea.date = vac.date
    AND dea.location = vac.location
    

-- Find Total Population that received Vaccination vs Total Population in the USA

Select dea.location, dea.date, dea.population, max(vac.total_vaccinations), max(vac.total_vaccinations)/dea.population *100 as Total_Vacc_Percent
from covid_deaths dea
JOIN covid_vaccinations vac
	ON dea.date = vac.date
    AND dea.location = vac.location

WHERE dea.location = 'United States'
Group by 1,2,3
Order by 1,2;

-- Find running sum for vaccination in the United States


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as Rolling_sum_vaccination
From covid_deaths dea
JOIN covid_vaccinations vac
	ON dea.date = vac.date
    AND	dea.location =vac.location
where dea.location = 'United States'
order by 2,3;


-- Create another Column to display running sum of vaccinated percentage of total population
-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Rolling_sum_vaccination) 
as
(
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as Rolling_sum_vaccination
	From covid_deaths dea
	JOIN covid_vaccinations vac
		ON dea.date = vac.date
		AND	dea.location =vac.location
	where dea.location = 'United States'
)
	Select *, (Rolling_sum_vaccination/Population) *100 as Rolling_Sum_Vacc_Percentage
	FROM PopvsVac;


-- USE TEMP Table instead of CTE

DROP Table if exists Percent_Population_Vaccinated

Create Table Percent_Population_Vaccinated
(
	Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population int,
    New_vaccinations int,
    Rolling_sum_vaccination int
)

Insert into Percent_Population_Vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as Rolling_sum_vaccination
	From covid_deaths dea
	JOIN covid_vaccinations vac
		ON dea.date = vac.date
		AND	dea.location =vac.location
	where dea.location = 'United States'

Select *, (Rolling_sum_vaccination/Population) *100 as Rolling_Sum_Vacc_Percentage
	FROM Percent_Population_Vaccinated;



-- Create View to store data for later visualizations

Create View Rolling_Sum_Vacc_Percentage as
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Rolling_sum_vaccination) 
as
(
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as Rolling_sum_vaccination
	From covid_deaths dea
	JOIN covid_vaccinations vac
		ON dea.date = vac.date
		AND	dea.location =vac.location
	where dea.location = 'United States'
)
	Select *, (Rolling_sum_vaccination/Population) *100 as Rolling_Sum_Vacc_Percentage
	FROM PopvsVac;
    
    */
