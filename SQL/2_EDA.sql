use project;
-- Frist 10 candidates
SELECT 
    *
FROM
    stagging2
LIMIT 10;

-- Total Candidates
SELECT 
    COUNT(*) AS total_rows
FROM
    stagging2;
    
-- Gender Distribution
select Gender,count(Gender) as Candidates,round((count(Gender)*100)/sum(count(*)) over(),2) as Percentage
from stagging2 group by Gender order by Candidates desc;

-- Age Distribution
SELECT 
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 30 THEN '25-29'
        WHEN age < 35 THEN '30-34'
        WHEN age < 40 THEN '35-39'
        ELSE '40+'
    END AS Age_Group,
    COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Age_Group
ORDER BY Age_Group;

-- Experience Distribution
SELECT 
    CASE
        WHEN Experience_Years < 2 THEN '0-1 Years'
        WHEN Experience_Years < 5 THEN '2-4 Years'
        WHEN Experience_Years < 8 THEN '5-7 Years'
        ELSE '8+ Years'
    END AS Experience_Group,
    COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Experience_Group
ORDER BY Experience_Group;

-- Education analysis
-- Education wise distribution of each candidates and there percentage
SELECT 
    *
FROM
    stagging2;
select Education,count(*) as Candidates,
round((count(*)*100)/sum(count(*)) over(),2) as Percentage
from stagging2 group by Education order by 2 desc;


-- Education wise distribution of hired candidates and hiring rate
SELECT 
    Education,
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Hiring_status = 'Hired' THEN 1
        ELSE 0
    END) AS Hired,
    SUM(CASE
        WHEN Hiring_status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Hiring_status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Hiring_status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Hiring_rate
FROM
    stagging2
GROUP BY Education
ORDER BY Hiring_rate DESC;

-- Department Analysis
SELECT 
    Department,
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Hiring_status = 'Hired' THEN 1
        ELSE 0
    END) AS Hired,
    SUM(CASE
        WHEN Hiring_status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Hiring_status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Hiring_status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Hiring_rate
FROM
    stagging2
GROUP BY Department
ORDER BY Hiring_rate DESC;

-- Job Role Analysis
SELECT 
    Job_Role,
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Hiring_status = 'Hired' THEN 1
        ELSE 0
    END) AS Hired,
    SUM(CASE
        WHEN Hiring_status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Hiring_status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Hiring_status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Hiring_rate
FROM
    stagging2
GROUP BY Job_Role
ORDER BY Hiring_rate DESC;

-- Source Analysis
SELECT 
    `Source`,
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Hiring_status = 'Hired' THEN 1
        ELSE 0
    END) AS Hired,
    SUM(CASE
        WHEN Hiring_status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Hiring_status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Hiring_status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Hiring_rate
FROM
    stagging2
GROUP BY `Source`
ORDER BY Hiring_rate DESC;

SELECT 
    *
FROM
    stagging2
LIMIT 4;

-- Screening status
SELECT 
    Screening_status, COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Screening_status
ORDER BY Candidates DESC;

-- Interview Status
SELECT 
    Interview_Status, COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Interview_Status
ORDER BY Candidates DESC;

-- Hiring Status
SELECT 
    Hiring_Status, COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Hiring_Status
ORDER BY Candidates DESC;

-- Overall Hiring Status
SELECT 
    COUNT(*) AS Total_Candidates,
    SUM(CASE
        WHEN Hiring_status = 'Hired' THEN 1
        ELSE 0
    END) AS Hired,
    SUM(CASE
        WHEN Hiring_status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Hiring_status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Hiring_status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*),
            2) AS OverAllHiringRate
FROM
    stagging2;

-- Screening Status Analysis
SELECT DISTINCT
    Screening_Status
FROM
    stagging2;
SELECT 
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Screening_Status = 'Passed' THEN 1
        ELSE 0
    END) AS Passed,
    SUM(CASE
        WHEN Screening_status = 'Failed' THEN 1
        ELSE 0
    END) AS Failed,
    ROUND((SUM(CASE
                WHEN Screening_Status = 'Passed' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Screening_rate
FROM
    stagging2;

-- Interview Status Analysis
SELECT DISTINCT
    Interview_Status
FROM
    stagging2;
SELECT 
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Interview_Status = 'Selected' THEN 1
        ELSE 0
    END) AS Selected,
    SUM(CASE
        WHEN Interview_Status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Interview_Status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Interview_status = 'Selected' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Interview_Selected_rate
FROM
    stagging2;

-- Hiring Status Analysis
SELECT 
    COUNT(*) AS Candidates,
    SUM(CASE
        WHEN Hiring_status = 'Hired' THEN 1
        ELSE 0
    END) AS Hired,
    SUM(CASE
        WHEN Hiring_status = 'Rejected' THEN 1
        ELSE 0
    END) AS Rejected,
    SUM(CASE
        WHEN Hiring_status = 'Pending' THEN 1
        ELSE 0
    END) AS Pending,
    ROUND((SUM(CASE
                WHEN Hiring_status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*)) AS Hiring_rate
FROM
    stagging2;
    
-- Interview Score Analysis
SELECT 
    Hiring_Status,
    MIN(Interview_Score) AS Minimum_Interview_Score,
    MAX(Interview_Score) AS Maximum_Interview_Score,
    ROUND(AVG(Interview_Score), 2) AS Avg_Interview_Score
FROM
    stagging2
GROUP BY Hiring_Status
ORDER BY Avg_Interview_Score DESC;

-- Interview Score Group Analysis
SELECT 
    CASE
        WHEN Interview_Score < 50 THEN 'Below 50'
        WHEN Interview_Score < 60 THEN '50-59'
        WHEN Interview_Score < 70 THEN '60-69'
        WHEN Interview_Score < 80 THEN '70-79'
        WHEN Interview_Score < 90 THEN '80-89'
        ELSE '90+'
    END AS Score_Group,
    COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Score_Group
ORDER BY Score_Group;

-- Experience vs Hiring
SELECT 
    Hiring_Status,
    COUNT(*) AS Candidates,
    ROUND(AVG(Interview_Score), 2) AS Avg_Interview_Score,
    ROUND(AVG(Expected_Salary), 2) AS Avg_Expected_Salary,
    ROUND(AVG(Experience_Years), 2) AS Avg_Experience_Year
FROM
    stagging2
GROUP BY Hiring_Status
ORDER BY Candidates DESC;

-- Salary Analysis 
SELECT 
    MIN(Expected_Salary) AS Min_Salary,
    MAX(Expected_Salary) AS Max_Salary,
    ROUND(AVG(Expected_Salary), 2) AS Avg_Salary,
    ROUND(STDDEV(Expected_Salary), 2) AS Salary_Std_Dev
FROM
    stagging2;

-- Salary Analysis by Department
SELECT 
    *
FROM
    stagging2 limit2;
SELECT 
    Department,
    COUNT(*) AS Candidates,
    MIN(Expected_Salary) AS Min_Salary,
    MAX(Expected_Salary) AS Max_Salary,
    ROUND(AVG(Expected_Salary), 2) AS Avg_Salary
FROM
    stagging2
GROUP BY Department
ORDER BY Candidates;
    
-- Time to hire analysis
SELECT 
    ROUND(AVG(Time_to_Hire), 2) AS Avg_Time_to_Hire,
    ROUND(MIN(Time_to_Hire), 2) AS Min_Time_to_Hire,
    ROUND(MAX(Time_to_Hire), 2) AS Max_Time_to_Hire
FROM
    stagging2;

-- Time to hire by department
SELECT 
    Department,
    COUNT(*) AS Candidates,
    ROUND(AVG(Time_to_Hire), 2) AS Avg_Time_to_Hire
FROM
    stagging2
GROUP BY Department
ORDER BY Avg_Time_to_Hire DESC;

-- Time to hire by Source
SELECT 
    Source,
    COUNT(*) AS Candidates,
    ROUND(AVG(Time_to_Hire), 2) AS Avg_Time_to_Hire
FROM
    stagging2
GROUP BY Source
ORDER BY Avg_Time_to_Hire;

-- Application by month
SELECT 
    DATE_FORMAT(Application_Date, '%m') AS `Month`,
    COUNT(*) AS Applications
FROM
    stagging2
GROUP BY `Month`
ORDER BY `Month`;

SELECT 
    *
FROM
    stagging2;

-- Trends of Hiring by Month
SELECT 
    MONTH(Application_Date) AS `Month`,
    COUNT(*) AS Applications,
    SUM(CASE
        WHEN Hiring_Status = 'Hired' THEN 1
        ELSE 0
    END) AS Tot_Hired,
    ROUND((SUM(CASE
                WHEN Hiring_Status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*),
            2) AS Hiring_Rate
FROM
    stagging2
GROUP BY `Month`
ORDER BY `Month`;
 
 -- Hiring by year
SELECT 
    YEAR(Application_Date) AS `Year`, COUNT(*) AS Applications
FROM
    stagging2
GROUP BY `Year`
ORDER BY `Year`;
 
 -- Hiring trend by year
SELECT 
    YEAR(Application_Date) AS `Year`,
    COUNT(*) AS Applications,
    SUM(CASE
        WHEN Hiring_Status = 'Hired' THEN 1
        ELSE 0
    END) AS Tot_Hired,
    ROUND((SUM(CASE
                WHEN Hiring_Status = 'Hired' THEN 1
                ELSE 0
            END) * 100) / COUNT(*),
            2) AS Hiring_Rate
FROM
    stagging2
GROUP BY `Year`
ORDER BY `Year`;
 
 -- Salary vs Experience
SELECT 
    ROUND(Experience_Years, 0) AS Experience,
    ROUND(AVG(Expected_Salary), 2) AS Avg_Salary
FROM
    stagging2
GROUP BY 1
ORDER BY Experience;

-- Interview Score vs Expected Salary
SELECT 
    ROUND(Interview_Score, - 1) AS Score_Range,
    ROUND(AVG(Expected_Salary), 2) AS Avg_Salary
FROM
    stagging2
GROUP BY ROUND(Interview_Score, - 1)
ORDER BY Score_Range;

-- Department + Hiring Status
SELECT 
    Department, Hiring_Status, COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Department , Hiring_Status
ORDER BY Department , Candidates DESC;

-- Source + Department
SELECT 
    Department, `Source`, COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Department , `Source`
ORDER BY Department , `Source` DESC;

-- Education + hiring
SELECT 
    Hiring_Status, Education, COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Education , Hiring_Status;

-- Experience + hiring
SELECT 
    *
FROM
    stagging2;
SELECT 
    CASE
        WHEN Experience_Years < 2 THEN '0-1'
        WHEN Experience_Years < 5 THEN '2-4'
        WHEN Experience_years < 8 THEN '5-7'
        ELSE '8+'
    END AS Experience_Group,
    Hiring_Status,
    COUNT(*) AS Candidates
FROM
    stagging2
GROUP BY Experience_Group , Hiring_Status
ORDER BY Experience_Group;