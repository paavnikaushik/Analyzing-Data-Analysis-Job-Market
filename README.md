# Introduction
Diving deep into the data analysis job market, exploring top paying jobs and in-demand skills and where high demand meets high salary in india and globally.
For queries, click on the file : [project folder](/project/)
# Background
This project was born from a desire to pinpoint top paid and in-demand skills. Data contains information on job titles, locations, salaries, and essential skills.
### Questions I wanted to answer:
1. What are top-paying data analysis jobs?
2. What skills are required for these jobs in India and globally?
3. What skills are in demand and associated with higher salaries in India?
4. What are most optimal skills to learn?
# Tools Used
1. **SQL**: Querying the database and drawing insights
2. **PostgreSQL**: Chosen Database Management System
3. **Visual Studio Code**: The chosen IDE
4. **Git and GitHub**: For sharing the repository
# Analysis
Aim was to know more about the data analysis job market, here's how each question was approached:
### 1. Top Paying Data Analyst Jobs:
Filtered data analyst postions by average yearly salary and location, focusing on India.
```sql

SELECT
        job_id,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
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
LIMIT 20;

```
### Findings:

Sure! Here are **3 concise insights**:

1. **Top-paying role** is at **ServiceNow, Hyderabad** with an average salary of **₹1,77,283/year**.  
2. **Hyderabad and Bengaluru** are the leading cities for high-paying Data Analyst jobs.  
3. Companies like **Bosch Group** and **Eagle Genomics Ltd** have **multiple listings**, suggesting active hiring.


### 2. Top paying job skills
This query retrieves the top 10 highest-paying Data Analyst jobs in India along with the companies and required skills by joining job, company, and skills-related tables.
```sql
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
```
### Findings:
-Top-paying “Data Analyst” roles are actually hybrid roles closer to Data Engineering or Data Platform Engineering.

-Skills like Databricks, Snowflake, Airflow, Scala, Kafka fetch top salaries but require advanced backend/data infra skills.

-Enterprise data tools like SAP and Oracle also command high pay in traditional companies.

-Widely taught skills (e.g. SQL, Excel, Python) are essential but not enough for top-paying analyst roles.

### 3. Top Demanded Skills

This query retrieves the top 10 most in-demand skills for Data Analyst roles by counting how many job postings mention each skill.

```sql
SELECT skills, COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
limit 10
```
### Findings:
Master the high-demand basics (SQL, Excel, Python), but sprinkle in some high-paying niche skills (e.g. Snowflake, Airflow, SAP) to maximize your earning potential.

| Goal                     | Focus Skills                         |
|--------------------------|--------------------------------------|
| ✅ Get hired fast         | SQL, Excel, Tableau, Power BI        |
| 💰 Earn higher salary     | Python, SAP, Snowflake, Airflow, Databricks |
| 🚀 Stand out from crowd   | Cloud tools + Python + BI tools      |
| 🔄 Transition to Data Engineering | Airflow, Kafka, Databricks, Pyspark  |

### 4. Top Skills based on salary

This query identifies the top 30 skills associated with the highest average salaries for Data Analyst roles by calculating the average salary for each skill from relevant job postings.
```sql
SELECT skills, ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary  DESC
limit 30
```
### Findings:
- The intersection of data analytics and machine learning leads to higher pay.
- Cloud and big data tools are associated with top-paying roles.
- Core tools (SQL + Python) are essential at every level.


# What I learned

- Gained hands-on experience with **PostgreSQL** for querying and analyzing data  
- Used **Visual Studio Code (VSCode)** as the primary code editor  
- Learned to manage version control and collaborate using **GitHub**

# Conclusions
1. SQL, Excel, and Python are non-negotiables.

2. Power BI and Tableau stand out for both reporting and salary returns.

3. Cloud & big data tools (like Spark, Azure, AWS) add a significant salary boost, even if fewer roles explicitly ask for them.

