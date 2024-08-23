SELECT D.DATE AS missing_date
FROM generate_series('2022-01-01', '2022-01-10', INTERVAL '1 DAY') AS D
LEFT JOIN 
  (SELECT V1.visit_date FROM
  (SELECT visit_date FROM person_visits WHERE person_id = 2) AS V1
FULL OUTER JOIN
  (SELECT visit_date FROM person_visits WHERE person_id = 1) AS V2
   ON V2.visit_date = V1.visit_date) AS V ON D.DATE = V.visit_date
WHERE V.visit_date is NULL;
