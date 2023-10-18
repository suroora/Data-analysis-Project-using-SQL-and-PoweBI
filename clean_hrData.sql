-- QUESTION

-- 1.WHAT IS THE GENDER BREACKDOWN OF EMPLOYEES IN THE COMPANY
select gender,count(*) as count from hr
WHERE age >= 18 and termdate ='0000-00-00'
group by gender;

-- 2.what is the race/ethnicity breackdown of employees inthe company
select race,count(*)as count
 from hr
 where age >=18 and termdate='0000-00-00' 
 group by race 
 order by count(*) desc;
 
-- 3.what is the age distrubation of employees in the company
select 
 min(age)as youngest,
 max(age) as oldest
 from hr where age >=18 and termdate='0000-00-00';
-- Distribution of age
select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '45-54'
        when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,
    count(*)as count
from hr where age >= 18 and termdate='0000-00-00'
group by age_group
order by age_group;

# gender distribution
select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '45-54'
        when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,gender,
    count(*)as count
from hr where age >= 18 and termdate='0000-00-00'
group by age_group,gender
order by age_group,gender;


-- 4. how many employees work at headquart verses remote location
select location,count(*) as count
from hr
where age>=18 and termdate='0000-00-00'
group by location;

-- 5.what is the average length of employment from employee who have been terminated
select 
	round(avg(datediff(termdate,hire_date))/365,0) as avg_lengthof_employment
from hr
where termdate <= curdate() and termdate <>'0000-00-00' and age >= 18;

-- 6. how does the gender distribution vary across department nd job titles
select department,gender, count(*)as count 
from hr
where age >=18 and termdate='0000-00-00'
group by gender, department
order by department;

-- 7.what is the distrbution of job titles across the company
select jobtitle,count(*)
 from hr
 where age >=18 and termdate='0000-00-00'
group by jobtitle
order by jobtitle desc;

-- 8. which department has the heighest turnover rate
select department,
	total_count,
	terminated_count,
    terminated_count/total_count as termination_rate
from (
select department,
count(*)as total_count,
sum(case when termdate <> '0000-00-00' and 
termdate <= curdate()then 1 else 0 end) as terminated_count
from hr
where age >= 18
group by department
)as subquery
order by termination_rate desc;

-- 9.what is the distribution of the empoyees across by city and state
select location_state,count(*)as count
from hr 
 where age >=18 and termdate='0000-00-00'
 group by location_state
 order by count desc;

-- 10.how has the company's employee count changed over time based on hire and term_date 
select 
year,
hires,
termination,
hires - termination as net_change,
round((hires - termination)/hires * 100,2) as net_change_percesnt
from (
	select year(hire_date) as year,
    count(*)as hires,
    sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end)as termination
    from hr where age >= 18
    group by year(hire_date)
    )as subquery
order by year asc;

-- 11.What is the tensure distribution for each department
select department,round(avg(datediff(termdate,hire_date)/365),0) as avg_tensure
from hr
where termdate <=curdate() and termdate <> '0000-00-00' and age >=18
group by department;


