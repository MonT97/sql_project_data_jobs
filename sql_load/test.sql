-- SELECT 
--     job_title_short AS title,
--     job_location AS location,
--     job_posted_date::DATE AS date,
--     EXTRACT(MONTH FROM job_posted_date) AS month
-- FROM job_postings_fact
-- LIMIT 25
-- SELECT COUNT(job_id) AS number_of_jobs_posted,
--     EXTRACT(
--         MONTH
--         FROM job_posted_date
--     ) AS month_of_posting
-- FROM job_postings_fact
-- GROUP BY month_of_posting
-- ORDER BY number_of_jobs_posted DESC
-- LIMIT 15
SELECT COUNT(job_id) AS num_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'local'
        ELSE 'On-site'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY num_of_jobs DESC