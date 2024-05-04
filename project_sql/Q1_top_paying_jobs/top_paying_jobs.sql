/*
 Q: What are the top paying jobs?
 - Identify the top paying roles for a Data Analyst in the GCC area or remote roles.
 - Remove irrelevant data.
 */
--! This is all jobs (remote+GCC):
WITH all_top_paying_jobs AS(
    SELECT job_id,
        job_title,
        job_location,
        company_dim.company_name,
        salary_year_avg
    FROM job_postings
        JOIN company_dim ON job_postings.company_id = company_dim.company_id
    WHERE(
            job_country IN (
                'United Arab Emirates',
                'Qatar',
                'Saudi Arabia',
                'Oman'
            )
            OR (
                job_location = 'Anywhere'
                AND salary_year_avg IS NOT Null
            )
        )
        AND job_title_short = 'Data Analyst'
    ORDER BY salary_year_avg
),
--! how about outputting the top 50 in each category (remote, GCC):
/* The COPY statment doesn't support CTE's so i have to use sub-query:
 uncomment to create/update "all_top_paying_jobs.csv"
 */
-- COPY(
--     SELECT job_id,
--         job_title,
--         job_location,
--         company_dim.company_name,
--         salary_year_avg
--     FROM job_postings
--         JOIN company_dim ON job_postings.company_id = company_dim.company_id
--     WHERE(
--             job_country IN (
--                 'United Arab Emirates',
--                 'Qatar',
--                 'Saudi Arabia',
--                 'Oman'
--             )
--             OR (
--                 job_location = 'Anywhere'
--                 AND salary_year_avg IS NOT Null
--             )
--         )
--         AND job_title_short = 'Data Analyst'
--     ORDER BY salary_year_avg
-- ) TO 'D:\S.I\programming\Videos\course\DB\sql_project_data_jobs\project_sql\Q1_top_paying_jobs\all_top_paying_jobs.csv' WITH (
--     FORMAT 'csv',
--     HEADER True,
--     DELIMITER ',',
--     ENCODING 'UTF8'
-- );
--! It seems to be somewhat reasonable to get the top 50 companies from booth categories:
--? Top 50 jobs -> remotes roles:
top50_remote AS (
    SELECT *
    FROM all_top_paying_jobs
    WHERE job_location = 'Anywhere'
    LIMIT 50
), --? Jobs -> from the top 50 gcc companies:
top50_gcc AS (
    SELECT company_name
    FROM all_top_paying_jobs
    WHERE job_location <> 'Anywhere'
    GROUP BY company_name
    ORDER BY COUNT(*) DESC
    LIMIT 50
), --? The combined 100 roles:
--! The output file top_100_jobs.csv is from (final) CTE created via PgAdmin4 the query tool
final AS (
    SELECT all_top_paying_jobs.job_id,
        all_top_paying_jobs.job_title,
        all_top_paying_jobs.job_location,
        all_top_paying_jobs.company_name,
        all_top_paying_jobs.salary_year_avg
    FROM all_top_paying_jobs
        JOIN top50_gcc ON all_top_paying_jobs.company_name = top50_gcc.company_name
    UNION
    SELECT *
    FROM top50_remote
)
SELECT *
FROM final
ORDER BY salary_year_avg