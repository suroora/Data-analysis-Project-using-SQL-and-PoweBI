create database HR;
USE HR;

# changing the column name ï»¿id to id
ALTER TABLE hr CHANGE COLUMN ï»¿id emp_id VARCHAR(20)NULL;
SELECT * FROM hr;
SET sql_safe_updates=0;
# DISPLAY THE DATA TYPES OF THE TABLE COLUMN 
DESCRIBE HR;
# WE NEED TO CHANGE THE DATE COLUMN DATATYPE HERE USE TEXT DATATYPE
UPDATE HR
 SET birthdate = CASE
	WHEN birthdate LIKE '%/%'THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
	WHEN birthdate LIKE  '%-%'THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;
alter table hr 
modify column birthdate DATE;
select birthdate from hr;

# CHANGE HIRE_DATE COLUMN DATATYPE LIKE ALL OTHER DATE DATATYPE
UPDATE HR
SET hire_date= CASE
	WHEN hire_date LIKE '%/%'THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
	WHEN hire_date LIKE  '%-%'THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;
alter table hr 
modify column hire_date DATE;
select termdate from hr;
# changing the termdate datatype 
update hr
set termdate= date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate !=" ";

alter table hr modify column termdate DATE;
Update hr set termdate = null where termdate is null;
SHOW VARIABLES LIKE 'sql_mode';
set global sql_mode= "";
SET sql_mode = '';
describe hr;
select hire_date from hr;
select * from hr;

# going to change age datatype text to int
alter table hr add column Age int;
# counting the age using birthdate and current date
update hr
set ge=timestampdiff(year,birthdate,curdate());
select birthdate,age from hr;

# displya the minimum and Maximum age of employees
select first_name,birthdate,department,jobtitle,min(age) from hr;

# we get -ve value so its wrong , that why we are ging looking any age come less thatn 0
select count(*) from hr where age <18;










