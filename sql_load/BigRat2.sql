SELECT CASE
        WHEN salary_year_avg > (
            percentile_cont(0.75) WITHIN GROUP (
                ORDER BY salary_year_avg
            )
        ) THEN 'hight'
        WHEN salary_year_avg > (
            percentile_cont(0.25) WITHIN GROUP (
                ORDER BY salary_year_avg
            )
        ) THEN 'mid'
        ELSE 'low'
    END AS salary_category
FROM job_postings_fact