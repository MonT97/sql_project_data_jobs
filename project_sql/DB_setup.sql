/*
 - Setting up the data base to work on.
 - Creating tables.
 */
CREATE DATABASE database_name;
--? The company_dim (company information) table
CREATE TABLE company_dim (
    company_id SERIAL PRIMARY KEY,
    company_name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);
COPY company_dim
FROM 'D:\S.I\programming\Videos\course\DB\sql_project_data_jobs\csv_files\company_dim.csv' WITH(
        FORMAT csv,
        ENCODING 'UTF8',
        HEADER true,
        DELIMITER ','
    );
--? The skills_dim (skill, skill type information) table
CREATE TABLE skills_dim (
    skill_id SERIAL PRIMARY KEY,
    skills VARCHAR(255),
    type VARCHAR(255)
);
COPY skills_dim
FROM 'D:\S.I\programming\Videos\course\DB\sql_project_data_jobs\csv_files\skills_dim.csv' WITH(
        FORMAT csv,
        HEADER true,
        ENCODING 'UTF8',
        DELIMITER ','
    );
--? The job_postings table (info about the specific job postings)
CREATE TABLE job_postings (
    job_id SERIAL PRIMARY KEY,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES company_dim(company_id),
    job_title_short TEXT,
    job_title TEXT,
    job_location TEXT,
    job_found_via TEXT,
    job_schedule_type TEXT,
    work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC
);
COPY job_postings
FROM 'D:\S.I\programming\Videos\course\DB\sql_project_data_jobs\csv_files\job_postings_fact.csv' WITH (
        FORMAT csv,
        ENCODING 'UTF8',
        HEADER true,
        DELIMITER ','
    );
--? The skills_job_dim (skill id, job id) connection table
CREATE TABLE skills_job_dim (
    job_id INT,
    FOREIGN KEY (job_id) REFERENCES job_postings(job_id),
    skill_id INT,
    FOREIGN KEY (skill_id) REFERENCES skills_dim(skill_id)
);
COPY skills_job_dim
FROM 'D:\S.I\programming\Videos\course\DB\sql_project_data_jobs\csv_files\skills_job_dim.csv' WITH(
        FORMAT csv,
        HEADER True,
        ENCODING 'UTF8',
        DELIMITER ','
    );