-- ? Creat the JAN table
-- CREATE TABLE jan_2023_jobs AS
--     SELECT * FROM job_postings_fact WHERE EXTRACT(MONTH FROM job_posted_date) = 1 AND EXTRACT(YEAR FROM job_posted_date) = 2023;
-- CREATE TABLE feb_2023_jobs AS
--     SELECT * FROM job_postings_fact WHERE EXTRACT(MONTH FROM job_posted_date) = 2 AND EXTRACT(YEAR FROM job_posted_date) = 2023;
CREATE TABLE mar_2023_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 3
    AND EXTRACT(
        YEAR
        FROM job_posted_date
    ) = 2023