/*
 Q: What are the skills associated with high paying roles?
 - Filter like in Q1.
 - Unfortunately almost all the roles in the GCC area doesn't specify any salary we have to        discard them!.
 */
SELECT sd.skill_id,
    sd.skills,
    TO_CHAR(
        ROUND(AVG(jp.salary_year_avg), 2),
        '999,999,999.00$'
    ) avg_annual_salary
FROM job_postings jp
    JOIN company_dim cd USING (company_id)
    JOIN skills_job_dim sjd USING (job_id)
    JOIN skills_dim sd USING (skill_id)
WHERE jp.job_title_short = 'Data Analyst'
    AND (jp.job_location = 'Anywhere')
    AND (
        jp.salary_year_avg >= (
            SELECT MIN(salary_year_avg)
            FROM (
                    SELECT jp_1.salary_year_avg
                    FROM job_postings jp_1
                    ORDER BY jp_1.salary_year_avg
                    LIMIT 50
                )
        )
    )
GROUP BY sd.skill_id
ORDER BY avg_annual_salary DESC