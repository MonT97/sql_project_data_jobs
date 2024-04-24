/*
 Q: What are the top paying jobs?
 - Identify the top paying roles for a Data Analyst in the GCC area and specifically in the UAE.
 - Remove irrelevant data.
 */
COPY job_postings_fact
FROM 'D:\S.I\programming\Videos\course\DB\sql_project_data_jobs\csv_files\job_postings_fact.csv' WITH(
        FORMAT csv,
        HEADER Ture,
        ENCODING 'UTF8',
        DELIMITER ','
    )