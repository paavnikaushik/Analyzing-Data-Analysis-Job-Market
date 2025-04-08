--top paying skills

WITH top_paying_jobs AS(
SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        company_dim.name AS company_name
FROM
        job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id=job_postings_fact.company_id
WHERE 
        job_title_short='Data Analyst' AND
        job_location LIKE '%India' AND
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10
)

SELECT top_paying_jobs.*,skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id=top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
ORDER BY salary_year_avg DESC;

/* These skills appeared most frequently in job descriptions:

SQL – 5 listings

Power BI – 5 listings

Oracle, MongoDB, Python, Spark, Azure – 4 each

AWS – 3 listings

Flow, Databricks – 2 each
*/

