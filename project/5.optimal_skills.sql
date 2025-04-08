--skills that are high and demand and also associated with higher salary
WITH skills_demand AS (
SELECT skills_dim.skill_id,skills_dim.skills, COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND 
        job_location LIKE '%India' AND
        salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
), avg_salary AS (
SELECT skills_job_dim.skill_id, ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location LIKE '%India'
GROUP BY skills_job_dim.skill_id
)

SELECT skills_demand.skill_id, demand_count, average_salary,skills_demand.skills
FROM skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id=avg_salary.skill_id
WHERE demand_count > 10
ORDER BY average_salary DESC,demand_count DESC
LIMIT 30;

--rewriting the same query concisely

SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location LIKE '%India'
GROUP BY 
skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id)>10
ORDER BY    
        avg_salary DESC,
        demand_count DESC
LIMIT 25;

/* SQL, Excel, and Python are non-negotiables.

Power BI and Tableau stand out for both reporting and salary returns.

Cloud & big data tools (like Spark, Azure, AWS) add a significant salary boost, even if fewer roles explicitly ask for them.
*/
