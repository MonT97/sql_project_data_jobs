/*
 Q: What are the top paying jobs?
 - Identify the top paying roles for a Data Analyst in the GCC area and specifically in the UAE.
 - Remove irrelevant data.
 */
SELECT *
FROM job_postings
WHERE job_country IN (
        'United Arab Emirates',
        'Qatar',
        'Saudi Arabia',
        'Oman'
    )
ORDER BY salary_year_avg