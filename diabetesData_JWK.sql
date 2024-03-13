/*______________________________________________________________________________
CODE DESCRIPTION: 

This SQL code (diabetesData_JWK.sql) imports the diabetes data (diabeticData_1999_2008_UCIMLR.csv), 
and calculates the percentage of patients who are of a particular sex (e.g. male 
or female). It then exports the data for the two sexes into distinct .csv output 
files.

Written by: Joshua W. Kern
Date: 03/12/24 									
________________________________________________________________________________*/

/*______________________________________________________________________________
Step 0: Initialize the database
________________________________________________________________________________*/
DROP DATABASE IF EXISTS Healthcare;
CREATE DATABASE Healthcare;
USE Healthcare;



/*______________________________________________________________________________
Step 1: Initialize the data table
________________________________________________________________________________*/
CREATE TABLE diabetic_data ( 
	encounter_id INT, 
	patient_nbr INT,
	race VARCHAR(64), 
	gender VARCHAR(64), 
	age VARCHAR(64), 
	weight VARCHAR(64),
	admission_type_id VARCHAR(64), 
	discharge_disposition_id VARCHAR(64), 
	admission_source_id VARCHAR(64), 
	time_in_hospital VARCHAR(64), 
	payer_code VARCHAR(64), 
	medical_specialty VARCHAR(64), 
	num_lab_prodecures INT, 
	num_procedures INT, 
	num_medications INT,
	number_outpatient INT,
	number_emergency INT,
	number_inpatient INT,
	diag_1 VARCHAR(64),
        diag_2 VARCHAR(64),
        diag_3 VARCHAR(64),
	number_diagnoses INT,
	max_glu_serum VARCHAR(64),
	A1Cresult VARCHAR(64),
	metformin VARCHAR(64),
	repaglinide VARCHAR(64),
	nateglinide VARCHAR(64),
	chlorpropamide VARCHAR(64),
	glimepiride VARCHAR(64),
	acetohexamide VARCHAR(64),
	glipizide VARCHAR(64),
	glyburide VARCHAR(64),
	tolbutamide VARCHAR(64),
	pioglitazone VARCHAR(64),
	rosiglitazone VARCHAR(64),
	acarbose VARCHAR(64),
	miglitol VARCHAR(64),
	troglitazone VARCHAR(64),
	tolazamide VARCHAR(64),
	examide VARCHAR(64),
	citoglipton VARCHAR(64),
	insulin VARCHAR(64),
	glyburide_metformin VARCHAR(64),
	glipizide_metformin VARCHAR(64),
	glimepiride_pioglitazone VARCHAR(64),
	metformin_rosiglitazone VARCHAR(64),
	metformin_pioglitazone VARCHAR(64),
	change_in_medication VARCHAR(64),
	diabetes_medication VARCHAR(64),
	readmitted VARCHAR(3)
);


/*______________________________________________________________________________
Step 2: Load the data from the .csv into the initialized data table
________________________________________________________________________________*/
LOAD DATA LOCAL INFILE '/home/jwkern/SQL/Data/diabetic_data_orig.csv' REPLACE INTO TABLE diabetic_data  FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 rows;




/*______________________________________________________________________________
Step 3: Select subset of data and calculate properties
________________________________________________________________________________*/

/* ------------- What is the distribution of gender among the patients? --------------------*/
SELECT DISTINCT 'What is the distribution of gender among the patients?';

SET @maleCount = (SELECT COUNT(*) FROM diabetic_data WHERE gender = 'Male'),
    @femaleCount = (SELECT COUNT(*) FROM diabetic_data WHERE gender = 'Female');

SET @totalCount = @maleCount + @femaleCount;

SET @malePercent = @maleCount/@totalCount*100.0,
    @femalePercent = @femaleCount/@totalCount*100.0;


SELECT @totalCount AS Total_Number_of_Patients,
        ROUND(@malePercent,2) AS Male_Percent,
        ROUND(@femalePercent,2) AS Female_Percent;






/* ------------- What is the distribution of time spent in the hospital? --------------------*/
SELECT DISTINCT 'What is the distribution of time spent in the hospital?';

SET @numPatientsDuration_1d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 1),                             
    @numPatientsDuration_2d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 2),
    @numPatientsDuration_3d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 3),
    @numPatientsDuration_4d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 4),
    @numPatientsDuration_5d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 5),
    @numPatientsDuration_6d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 6),
    @numPatientsDuration_7d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 7),
    @numPatientsDuration_8d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 8),
    @numPatientsDuration_9d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 9),
    @numPatientsDuration_10d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 10),
    @numPatientsDuration_11d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 11),
    @numPatientsDuration_12d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 12),
    @numPatientsDuration_13d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital = 13),
    @numPatientsDuration_g14d = (SELECT COUNT(*) FROM diabetic_data WHERE time_in_hospital >= 14);

SET @totalPatients = (@numPatientsDuration_1d +
			@numPatientsDuration_2d +
			@numPatientsDuration_3d +
			@numPatientsDuration_4d +
			@numPatientsDuration_5d +
			@numPatientsDuration_6d +
			@numPatientsDuration_7d +
			@numPatientsDuration_8d +
			@numPatientsDuration_9d +
			@numPatientsDuration_10d +
			@numPatientsDuration_11d +
			@numPatientsDuration_12d +
			@numPatientsDuration_13d +
			@numPatientsDuration_g14d);


SET @percentPatientsDuration_1d = (@numPatientsDuration_1d / @totalPatients * 100.0),
    @percentPatientsDuration_2d = (@numPatientsDuration_2d / @totalPatients * 100.0),
    @percentPatientsDuration_3d = (@numPatientsDuration_3d / @totalPatients * 100.0),
    @percentPatientsDuration_4d = (@numPatientsDuration_4d / @totalPatients * 100.0),
    @percentPatientsDuration_5d = (@numPatientsDuration_5d / @totalPatients * 100.0),
    @percentPatientsDuration_6d = (@numPatientsDuration_6d / @totalPatients * 100.0),
    @percentPatientsDuration_7d = (@numPatientsDuration_7d / @totalPatients * 100.0),
    @percentPatientsDuration_8d = (@numPatientsDuration_8d / @totalPatients * 100.0),
    @percentPatientsDuration_9d = (@numPatientsDuration_9d / @totalPatients * 100.0),
    @percentPatientsDuration_10d = (@numPatientsDuration_10d / @totalPatients * 100.0),
    @percentPatientsDuration_11d = (@numPatientsDuration_11d / @totalPatients * 100.0),
    @percentPatientsDuration_12d = (@numPatientsDuration_12d / @totalPatients * 100.0),
    @percentPatientsDuration_13d = (@numPatientsDuration_13d / @totalPatients * 100.0),
    @percentPatientsDuration_g14d = (@numPatientsDuration_g14d / @totalPatients * 100.0);


SELECT ROUND(@percentPatientsDuration_1d,2) AS 1day,
	ROUND(@percentPatientsDuration_2d,2) AS 2days,
	ROUND(@percentPatientsDuration_3d,2) AS 3days,
	ROUND(@percentPatientsDuration_4d,2) AS 4days,
	ROUND(@percentPatientsDuration_5d,2) AS 5days,
	ROUND(@percentPatientsDuration_6d,2) AS 6days,
	ROUND(@percentPatientsDuration_7d,2) AS 7days,
	ROUND(@percentPatientsDuration_8d,2) AS 8days,
	ROUND(@percentPatientsDuration_9d,2) AS 9days,
	ROUND(@percentPatientsDuration_10d,2) AS 10days,
	ROUND(@percentPatientsDuration_11d,2) AS 11days,
	ROUND(@percentPatientsDuration_12d,2) AS 12days,
	ROUND(@percentPatientsDuration_13d,2) AS 13days,
        ROUND(@percentPatientsDuration_g14d,2) AS g14days;







/* ------------- What is the distribution of age among these lengths of hospital stays? --------------------*/
SELECT DISTINCT 'What is the distribution of age among these lengths of hospital stays?';


SET @duration1d = '1day',
    @numPatients_1d_0010_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[0-10)' AND time_in_hospital = 1),
    @numPatients_1d_1020_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[10-20)' AND time_in_hospital = 1),
    @numPatients_1d_2030_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[20-30)' AND time_in_hospital = 1),
    @numPatients_1d_3040_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[30-40)' AND time_in_hospital = 1),
    @numPatients_1d_4050_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[40-50)' AND time_in_hospital = 1),
    @numPatients_1d_5060_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[50-60)' AND time_in_hospital = 1),
    @numPatients_1d_6070_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[60-70)' AND time_in_hospital = 1),
    @numPatients_1d_7080_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[70-80)' AND time_in_hospital = 1),
    @numPatients_1d_8090_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[80-90)' AND time_in_hospital = 1),
    @numPatients_1d_90up_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[90-100)' AND time_in_hospital = 1);


SET @percentPatientsAge_1d_0010 = (@numPatients_1d_0010_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_1020 = (@numPatients_1d_1020_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_2030 = (@numPatients_1d_2030_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_3040 = (@numPatients_1d_3040_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_4050 = (@numPatients_1d_4050_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_5060 = (@numPatients_1d_5060_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_6070 = (@numPatients_1d_6070_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_7080 = (@numPatients_1d_7080_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_8090 = (@numPatients_1d_8090_age / @numPatientsDuration_1d * 100.0),
    @percentPatientsAge_1d_90up = (@numPatients_1d_90up_age / @numPatientsDuration_1d * 100.0);


SELECT 	@duration1d AS Len,
	ROUND(@percentPatientsAge_1d_0010, 2) AS 00_10,
        ROUND(@percentPatientsAge_1d_1020, 2) AS 10_20,
        ROUND(@percentPatientsAge_1d_2030, 2) AS 20_30,
        ROUND(@percentPatientsAge_1d_3040, 2) AS 30_40,
        ROUND(@percentPatientsAge_1d_4050, 2) AS 40_50,
        ROUND(@percentPatientsAge_1d_5060, 2) AS 50_60,
        ROUND(@percentPatientsAge_1d_6070, 2) AS 60_70,
        ROUND(@percentPatientsAge_1d_7080, 2) AS 70_80,
        ROUND(@percentPatientsAge_1d_8090, 2) AS 80_90,
        ROUND(@percentPatientsAge_1d_90up, 2) AS 90_100;






SET @duration2d = '2days',
    @numPatients_2d_0010_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[0-10)' AND time_in_hospital = 2),
    @numPatients_2d_1020_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[10-20)' AND time_in_hospital = 2),
    @numPatients_2d_2030_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[20-30)' AND time_in_hospital = 2),
    @numPatients_2d_3040_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[30-40)' AND time_in_hospital = 2),
    @numPatients_2d_4050_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[40-50)' AND time_in_hospital = 2),
    @numPatients_2d_5060_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[50-60)' AND time_in_hospital = 2),
    @numPatients_2d_6070_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[60-70)' AND time_in_hospital = 2),
    @numPatients_2d_7080_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[70-80)' AND time_in_hospital = 2),
    @numPatients_2d_8090_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[80-90)' AND time_in_hospital = 2),
    @numPatients_2d_90up_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[90-100)' AND time_in_hospital = 2);


SET @percentPatientsAge_2d_0010 = (@numPatients_2d_0010_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_1020 = (@numPatients_2d_1020_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_2030 = (@numPatients_2d_2030_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_3040 = (@numPatients_2d_3040_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_4050 = (@numPatients_2d_4050_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_5060 = (@numPatients_2d_5060_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_6070 = (@numPatients_2d_6070_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_7080 = (@numPatients_2d_7080_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_8090 = (@numPatients_2d_8090_age / @numPatientsDuration_2d * 100.0),
    @percentPatientsAge_2d_90up = (@numPatients_2d_90up_age / @numPatientsDuration_2d * 100.0);


SELECT  @duration2d AS Len,
        ROUND(@percentPatientsAge_2d_0010, 2) AS 00_10,
        ROUND(@percentPatientsAge_2d_1020, 2) AS 10_20,
        ROUND(@percentPatientsAge_2d_2030, 2) AS 20_30,
        ROUND(@percentPatientsAge_2d_3040, 2) AS 30_40,
        ROUND(@percentPatientsAge_2d_4050, 2) AS 40_50,
        ROUND(@percentPatientsAge_2d_5060, 2) AS 50_60,
        ROUND(@percentPatientsAge_2d_6070, 2) AS 60_70,
        ROUND(@percentPatientsAge_2d_7080, 2) AS 70_80,
        ROUND(@percentPatientsAge_2d_8090, 2) AS 80_90,
        ROUND(@percentPatientsAge_2d_90up, 2) AS 90_100;






SET @duration3d = '3days',
    @numPatients_3d_0010_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[0-10)' AND time_in_hospital = 3),
    @numPatients_3d_1020_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[10-20)' AND time_in_hospital = 3),
    @numPatients_3d_2030_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[20-30)' AND time_in_hospital = 3),
    @numPatients_3d_3040_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[30-40)' AND time_in_hospital = 3),
    @numPatients_3d_4050_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[40-50)' AND time_in_hospital = 3),
    @numPatients_3d_5060_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[50-60)' AND time_in_hospital = 3),
    @numPatients_3d_6070_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[60-70)' AND time_in_hospital = 3),
    @numPatients_3d_7080_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[70-80)' AND time_in_hospital = 3),
    @numPatients_3d_8090_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[80-90)' AND time_in_hospital = 3),
    @numPatients_3d_90up_age = (SELECT COUNT(*) FROM diabetic_data WHERE age = '[90-100)' AND time_in_hospital = 3);


SET @percentPatientsAge_3d_0010 = (@numPatients_3d_0010_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_1020 = (@numPatients_3d_1020_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_2030 = (@numPatients_3d_2030_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_3040 = (@numPatients_3d_3040_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_4050 = (@numPatients_3d_4050_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_5060 = (@numPatients_3d_5060_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_6070 = (@numPatients_3d_6070_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_7080 = (@numPatients_3d_7080_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_8090 = (@numPatients_3d_8090_age / @numPatientsDuration_3d * 100.0),
    @percentPatientsAge_3d_90up = (@numPatients_3d_90up_age / @numPatientsDuration_3d * 100.0);


SELECT  @duration3d AS Len,
        ROUND(@percentPatientsAge_3d_0010, 2) AS 00_10,
        ROUND(@percentPatientsAge_3d_1020, 2) AS 10_20,
        ROUND(@percentPatientsAge_3d_2030, 2) AS 20_30,
        ROUND(@percentPatientsAge_3d_3040, 2) AS 30_40,
        ROUND(@percentPatientsAge_3d_4050, 2) AS 40_50,
        ROUND(@percentPatientsAge_3d_5060, 2) AS 50_60,
        ROUND(@percentPatientsAge_3d_6070, 2) AS 60_70,
        ROUND(@percentPatientsAge_3d_7080, 2) AS 70_80,
        ROUND(@percentPatientsAge_3d_8090, 2) AS 80_90,
        ROUND(@percentPatientsAge_3d_90up, 2) AS 90_100;











/*
SET @numPatientsReadmitted_1d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_2d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_3d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_4d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_5d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_6d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_7d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_8d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_9d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_10d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_11d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_12d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_13d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO'),
    @numPatientsReadmitted_g14d = (SELECT COUNT(*) FROM diabetic_data WHERE readmitted = 'NO');


SET @percentPatientsReadmitted_1d = (@numPatientsReadmitted_1d / @numPatientsDuration_1d * 100.0),
    @percentPatientsReadmitted_2d = (@numPatientsReadmitted_2d / @numPatientsDuration_2d * 100.0),
    @percentPatientsReadmitted_3d = (@numPatientsReadmitted_3d / @numPatientsDuration_3d * 100.0),
    @percentPatientsReadmitted_4d = (@numPatientsReadmitted_4d / @numPatientsDuration_4d * 100.0),
    @percentPatientsReadmitted_5d = (@numPatientsReadmitted_5d / @numPatientsDuration_5d * 100.0),
    @percentPatientsReadmitted_6d = (@numPatientsReadmitted_6d / @numPatientsDuration_6d * 100.0),
    @percentPatientsReadmitted_7d = (@numPatientsReadmitted_7d / @numPatientsDuration_7d * 100.0),
    @percentPatientsReadmitted_8d = (@numPatientsReadmitted_8d / @numPatientsDuration_8d * 100.0),
    @percentPatientsReadmitted_9d = (@numPatientsReadmitted_9d / @numPatientsDuration_9d * 100.0),
    @percentPatientsReadmitted_10d = (@numPatientsReadmitted_10d / @numPatientsDuration_10d * 100.0),
    @percentPatientsReadmitted_11d = (@numPatientsReadmitted_11d / @numPatientsDuration_11d * 100.0),
    @percentPatientsReadmitted_12d = (@numPatientsReadmitted_12d / @numPatientsDuration_12d * 100.0),
    @percentPatientsReadmitted_13d = (@numPatientsReadmitted_13d / @numPatientsDuration_13d * 100.0),
    @percentPatientsReadmitted_g14d = (@numPatientsReadmitted_g14d / @numPatientsDuration_g14d * 100.0);


SELECT ROUND(@percentPatientsReadmitted_1d,2) AS 1day,
        ROUND(@percentPatientsReadmitted_2d,2) AS 2days,
        ROUND(@percentPatientsReadmitted_3d,2) AS 3days,
        ROUND(@percentPatientsReadmitted_4d,2) AS 4days,
        ROUND(@percentPatientsReadmitted_5d,2) AS 5days,
        ROUND(@percentPatientsReadmitted_6d,2) AS 6days,
        ROUND(@percentPatientsReadmitted_7d,2) AS 7days,
        ROUND(@percentPatientsReadmitted_8d,2) AS 8days,
        ROUND(@percentPatientsReadmitted_9d,2) AS 9days,
        ROUND(@percentPatientsReadmitted_10d,2) AS 10days,
        ROUND(@percentPatientsReadmitted_11d,2) AS 11days,
        ROUND(@percentPatientsReadmitted_12d,2) AS 12days,
        ROUND(@percentPatientsReadmitted_13d,2) AS 13days,
        ROUND(@percentPatientsReadmitted_g14d,2) AS g14days;
*/


/*______________________________________________________________________________
________________________________________________________________________________

--------------------------------------------------------------------------------	
-----------------------------------THE END--------------------------------------
--------------------------------------------------------------------------------
________________________________________________________________________________
________________________________________________________________________________*/
