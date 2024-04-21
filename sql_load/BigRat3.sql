WITH q1_jobs AS (
    SELECT *
    FROM jan_2023_jobs
    UNION ALL
    SELECT *
    FROM feb_2023_jobs
    UNION ALL
    SELECT *
    FROM mar_2023_jobs
) -- skill_table AS (
--     SELECT skills_job_dim.job_id,
--         skills,
--         type
--     FROM skills_job_dim
--         LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
-- )
-- SELECT q1_jobs.job_title_short,
--     skill_table.skills,
--     skill_table.type
-- FROM q1_jobs
--     LEFT JOIN skill_table ON q1_jobs.job_id = skill_table.job_id
-- WHERE q1_jobs.salary_year_avg > 70000
SELECT job_title_short,
    job_location,
    job_via,
    company_dim.name,
    salary_year_avg,
    job_posted_date::DATE
FROM q1_jobs
    LEFT JOIN company_dim ON q1_jobs.company_id = company_dim.company_id
WHERE salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC