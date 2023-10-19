-- 1
WITH HiredEmployees AS (
    SELECT
        d.department AS department,
        j.job AS job,
        e.id AS employee_id,
        e.datetime AS hire_datetime
    FROM
        hired_employees e
    JOIN
        departments d ON e.department_id = d.id
    JOIN
        jobs j ON e.job_id = j.id
)
SELECT
    department,
    job,
    SUM(CASE WHEN strftime('%m', hire_datetime) BETWEEN '01' AND '03' THEN 1 ELSE 0 END) AS Q1,
    SUM(CASE WHEN strftime('%m', hire_datetime) BETWEEN '04' AND '06' THEN 1 ELSE 0 END) AS Q2,
    SUM(CASE WHEN strftime('%m', hire_datetime) BETWEEN '07' AND '09' THEN 1 ELSE 0 END) AS Q3,
    SUM(CASE WHEN strftime('%m', hire_datetime) BETWEEN '10' AND '12' THEN 1 ELSE 0 END) AS Q4
FROM
    HiredEmployees
GROUP BY
    department, job
ORDER BY
    department, job;


--2
WITH DepartmentStats AS (
    SELECT
        d.id AS department_id,
        d.department AS department_name,
        COUNT(e.id) AS employees_hired
    FROM
        departments d
    LEFT JOIN
        hired_employees e ON d.id = e.department_id
    GROUP BY
        department_id, department_name
),
AverageEmployees AS (
    SELECT
        AVG(employees_hired) AS average_employees_hired
    FROM
        DepartmentStats
)
SELECT
    ds.department_id AS id,
    ds.department_name AS department,
    ds.employees_hired AS hired
FROM
    DepartmentStats ds
JOIN
    AverageEmployees ae ON ds.employees_hired > ae.average_employees_hired
ORDER BY
    ds.employees_hired DESC;