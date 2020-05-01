CREATE DATABASE IF NOT EXISTS zoo;
USE zoo;

CREATE TABLE IF NOT EXISTS cities
(
	cityID								INT						PRIMARY KEY				DEFAULT NULL,
    city								VARCHAR(20)				DEFAULT NULL,
    `Temperature - (Celsius)`			FLOAT					DEFAULT NULL,
    `Temperature - (Fahrenheit)`		FLOAT					DEFAULT NULL,
    `Rainfall - (MM)`					FLOAT					DEFAULT NULL,
    `Year`								INT						DEFAULT NULL,
    `Month`								VARCHAR(9)				DEFAULT NULL,
    Longitude							FLOAT					DEFAULT NULL,
    Latitude							FLOAT					DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS disasters
(
    `Serial`							INT						PRIMARY KEY,
	`Year_date`							DATE					DEFAULT NULL,
    `Event`								VARCHAR(20)				DEFAULT NULL,
    `Code Region`						INT						DEFAULT NULL,
    Region								VARCHAR(20)				DEFAULT NULL,
    `Code District`						VARCHAR(30)				DEFAULT NULL,
    `Date (YMD)`						DATE					DEFAULT NULL,
	`Source`							VARCHAR(70)				DEFAULT NULL,
    DataCards							INT						DEFAULT NULL,
    Deaths								INT						DEFAULT NULL,
    Injured								INT						DEFAULT NULL,
	Missing								INT						DEFAULT NULL,
    `Houses Destroyed`					INT						DEFAULT NULL,
    `Houses Damaged`					INT						DEFAULT NULL,
    Victims								INT						DEFAULT NULL,
    Affected							INT						DEFAULT NULL,
	Relocated							INT						DEFAULT NULL,
    `Losses $USD`						FLOAT					DEFAULT NULL,
    `Losses $Local`						FLOAT					DEFAULT NULL,
    `Education centers`					INT						DEFAULT NULL,
    Hospitals							INT						DEFAULT NULL,
    `Damages in crops Ha.`				INT						DEFAULT NULL,
    `Lost Cattle`						INT						DEFAULT NULL,
    `Damages in roads Mts`				INT						DEFAULT NULL,
    Year_int							INT						DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `Demographics` (
  DemoID								INT						PRIMARY KEY 			auto_increment,
  `Year` 								INT						DEFAULT NULL,
  `Life_Expectancy`  					FLOAT 					DEFAULT NULL,
  `AidPerCapitaUSD` 					FLOAT 					DEFAULT NULL,
  `Urban_Pop%` 							FLOAT 					DEFAULT NULL,
  `Urban_Pop` 							INT 					DEFAULT NULL,
  `Total_Unemployment%` 				FLOAT 					DEFAULT NULL,
  `Female_Unemployment%` 				FLOAT 					DEFAULT NULL,
  `Male_Unemployment%` 					FLOAT 					DEFAULT NULL,
  `Rural_Pop%` 							FLOAT 					DEFAULT NULL,	
  `Rural_Pop` 							INT 					DEFAULT NULL,
  `Primary_Total_Enroll%` 				FLOAT 					DEFAULT NULL, 
  `Primary_Female_Enroll%` 				FLOAT 					DEFAULT NULL,
  `Primary_Male_Enroll%` 				FLOAT 					DEFAULT NULL,
  `Secondary_Total_Enroll%` 			FLOAT 					DEFAULT NULL,
  `Secondary_Female_Enroll%` 			FLOAT 					DEFAULT NULL,
  `Secondary_Male_Enroll%` 				FLOAT 					DEFAULT NULL,
  `Tertiary_Total_Enroll%` 				FLOAT 					DEFAULT NULL,
  `Tertiary_Male_Enroll%` 				FLOAT 					DEFAULT NULL,
  `Tertiary_Female_Enroll%` 			FLOAT 					DEFAULT NULL,
  `Pop_Over_64%` 						FLOAT 					DEFAULT NULL,
  `Pop_15to64%` 						FLOAT 					DEFAULT NULL,
  `Pop_Under_15%` 						FLOAT 					DEFAULT NULL,
  `Literacy_Youth_Total%` 				FLOAT 					DEFAULT NULL,
  `Literacy_Youth_Female%` 				FLOAT 					DEFAULT NULL,
  `Literacy_Youth_Male%` 				FLOAT 					DEFAULT NULL,
  `Literacy_Adult_Total%`				FLOAT 					DEFAULT NULL,
  `Literacy_Adult_Male%` 				FLOAT 					DEFAULT NULL,
  `Literacy_Adult_Female%` 				FLOAT					DEFAULT NULL,
  `Life_Expectancy_at_Birth_Male` 		FLOAT 					DEFAULT NULL,
  `Life_Expectancy_at_Birth_Female` 	FLOAT 					DEFAULT NULL,
  `Laborforce_Total%` 					FLOAT 					DEFAULT NULL,
  `Laborforce_Male%` 					FLOAT 					DEFAULT NULL,
  `Laborforce_Female%` 					FLOAT 					DEFAULT NULL,
  `GINI` 								FLOAT 					DEFAULT NULL,
  `Employ_Service%` 					FLOAT 					DEFAULT NULL,
  `Employ_Industry%` 					FLOAT 					DEFAULT NULL,
  `Employ_Agri%` 						FLOAT 					DEFAULT NULL,
  `Electricity_Access%` 				FLOAT 					DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `years`
(
	`Year`								INT						PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS `lemurs` (
  ID								INT						PRIMARY KEY 			auto_increment,
  DLC_ID 							INT						DEFAULT NULL,
  UpdateDate  						DATE 					DEFAULT NULL,
  UpdateYear 						DATE					DEFAULT NULL,
  Taxon 							VARCHAR(90)				DEFAULT NULL,
  Hybrid 							VARCHAR(3)				DEFAULT NULL,
  Sex 								VARCHAR(6) 				DEFAULT NULL,
  DOB 								DATE 					DEFAULT NULL,
  BirthMonth 						DATE 					DEFAULT NULL,
  BirthType							VARCHAR(45) 			DEFAULT NULL,	
  EstimatedConcep 					DATE 					DEFAULT NULL,
  ConcepMonth 						DATE 					DEFAULT NULL, 
  DeadOrAlive 						INT 					DEFAULT NULL,
  AgeAtDeath 						FLOAT 					DEFAULT NULL,
  AgeOfLiving 						FLOAT 					DEFAULT NULL,
  AgeMax_LiveOrDead 				FLOAT 					DEFAULT NULL,
  NumKnownOffspring 				INT 					DEFAULT NULL,
  DamID 							INT						DEFAULT NULL,
  DamTaxon 							VARCHAR(90) 			DEFAULT NULL,
  SireID 							INT 					DEFAULT NULL,
  SireTaxon 						VARCHAR(90) 			DEFAULT NULL
);