create database project;
use project;

-- Raw data table 
select * from Recruitment_Hiring_Analytics_Dataset;

-- Data Cleaning

-- Creating Stagging workflow
create table stagging like Recruitment_Hiring_Analytics_Dataset;
insert into stagging
select * from Recruitment_Hiring_Analytics_Dataset;
select * from stagging;

-- Removing Duplicates

with duplicates as(
select *,row_number() over(partition by Candidate_ID,Age,Gender,Department, Job_Role,Education, Experience_Years,Application_Date, `Source`,Screening_Status,Interview_Status, Hiring_Status, Interview_Score, Expected_Salary, Time_to_Hire)
as rnum from stagging
)select * from duplicates where rnum>1;

-- Checking Duplicates
select * from stagging where Candidate_ID="C1062";

-- Creating Another staging area for removal of duplicates
CREATE TABLE `stagging2` (
  `Candidate_ID` text,
  `Age` int DEFAULT NULL,
  `Gender` text,
  `Department` text,
  `Job_Role` text,
  `Education` text,
  `Experience_Years` double DEFAULT NULL,
  `Application_Date` text,
  `Source` text,
  `Screening_Status` text,
  `Interview_Status` text,
  `Hiring_Status` text,
  `Interview_Score` double DEFAULT NULL,
  `Expected_Salary` double DEFAULT NULL,
  `Time_to_Hire` double DEFAULT NULL,
  `rnum` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into stagging2
select *,row_number() over(partition by Candidate_ID,Age,Gender,Department, Job_Role,Education, Experience_Years,Application_Date, `Source`,Screening_Status,Interview_Status, Hiring_Status, Interview_Score, Expected_Salary, Time_to_Hire)
as rnum from stagging;

select * from stagging2;

-- Deleting duplicates
set sql_safe_updates=0;

delete from stagging2
where rnum>1;

select * from stagging2 where rnum>1; -- No record found

-- Deleteting Unwanted Row
alter table stagging2
drop column rnum;

select * from stagging2;


select count(*) from stagging2;


-- Standardizing the data
select distinct age from stagging2;   -- Age is ok

select Gender from stagging2;
update stagging2
set Gender=case
when Gender="male" then "Male"
else "Female"
end;    
update  stagging2
set Gender=lower(trim(Gender)); -- Standardized the gender

select distinct Department from stagging2;
update  stagging2
set Department=trim(Department); 
update stagging2
set Department="Hr" where Department="hr"; -- Standardized the Department

Select distinct Job_Role from stagging2;
select distinct length(Job_Role),trim(length(Job_Role)) from stagging2; -- Job_Role is ok


Select distinct Education from stagging2;
select distinct length(Education),length(trim(Education)) from stagging2; -- Education is ok

select distinct `Source` from stagging2;
update stagging2
set `Source`=case
when lower(trim(`Source`))="campus hiring" then "Campus Hiring"
when lower(trim(`Source`))="linkedin" then "LinkedIn"
when lower(trim(`Source`))="company website" then "Company Website"
when lower(trim(`Source`))="indeed" then "Indeed"
when lower(trim(`Source`))="naukri" then "Naukri"
when lower(trim(`Source`))="referral" then "Referral"
else trim(`Source`)
end;  -- Standardized the Source

select distinct Screening_Status from stagging2; -- Screening_status is ok

select distinct Interview_Status from stagging2; -- Interview_status is ok

select distinct Hiring_Status from stagging2; -- Hiring_status is ok

select distinct Interview_Score from stagging2; -- Interview_Score is ok

select Application_Date,str_to_date(Application_Date,'%Y-%m-%d') from stagging2;
update stagging2
set Application_date=str_to_date(Application_Date,'%Y-%m-%d');
alter table stagging2
modify column Application_date date;  -- Standardized the date
describe stagging2;


-- Handling Null/Missing values

set sql_safe_updates=0;
select Education from stagging2 group by Education;
select count(Education) from stagging2 where Education="";
update stagging2
set Education="Unknown" where Education="";

SELECT
    COUNT(*) AS total_records,

    SUM(CASE
        WHEN Candidate_ID IS NULL OR TRIM(Candidate_ID) = ''
        THEN 1 ELSE 0 END) AS missing_candidate_id,

    SUM(CASE
        WHEN Education IS NULL OR TRIM(Education) = ''
        THEN 1 ELSE 0 END) AS missing_education,

    SUM(CASE
        WHEN Department IS NULL OR TRIM(Department) = ''
        THEN 1 ELSE 0 END) AS missing_department,

    SUM(CASE
        WHEN Job_Role IS NULL OR TRIM(Job_Role) = ''
        THEN 1 ELSE 0 END) AS missing_job_role,

    SUM(CASE
        WHEN Expected_Salary IS NULL
        THEN 1 ELSE 0 END) AS missing_salary
FROM stagging2;
describe stagging2;