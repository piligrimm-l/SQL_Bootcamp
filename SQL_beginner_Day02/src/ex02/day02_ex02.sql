SELECT
  COALESCE(P.name, '-') AS person_name,
  V.visit_date AS visit_date,
  COALESCE(PZ.name, '-') AS pizzeria_name
FROM
  (SELECT * FROM person_visits
   WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03') AS V
FULL JOIN
  person P ON V.person_id = P.id 
FULL JOIN
  pizzeria PZ ON PZ.id = V.pizzeria_id
ORDER BY
  person_name, visit_date, pizzeria_name;
