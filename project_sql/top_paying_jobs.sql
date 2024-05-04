/*
 Q: What are the top paying jobs?
 - Identify the top paying roles for a Data Analyst in the GCC area and specifically in the UAE or remote roles.
 - Remove irrelevant data.
 */
SELECT job_title,
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