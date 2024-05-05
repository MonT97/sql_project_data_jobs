/*
 Q: What are the most in demand skills within the top100 jobs?
 - Clean the data like in Q1.
 - Display the data meaningfully.
 - Order and group the result in terms of skills and frequancy of said skills.
 */
--! Using the table resulting from Q1 answer
SELECT sd.skill_id,
    sd.skills,
    COUNT(*)
FROM job_postings jp
    JOIN company_dim cd USING (company_id)
    JOIN skills_job_dim skd USING (job_id)
    JOIN skills_dim sd USING (skill_id)
WHERE jp.job_title_short = 'Data Analyst'
    AND (
        (jp.job_location = 'Anywhere')
        AND jp.salary_year_avg >= (
            SELECT MIN(salary_year_avg)
            FROM (
                    SELECT jp_1.salary_year_avg
                    FROM job_postings jp_1
                    ORDER BY jp_1.salary_year_avg
                    LIMIT 50
                )
        )
    )
    OR (
        cd.company_name IN (
            SELECT cd_2.company_name
            FROM job_postings jp_2
                JOIN company_dim cd_2 USING (company_id)
            WHERE jp_2.job_location IN (
                    'United Arab Emirates',
                    'Qatar',
                    'Saudi Arabia',
                    'Oman'
                )
            GROUP BY cd_2.company_name
            ORDER BY COUNT(*) DESC
            LIMIT 50
        )
    )
GROUP BY sd.skill_id
HAVING count(*) >= 250
ORDER BY count DESC