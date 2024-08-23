SELECT DISTINCT person_id FROM person_visits
  WHERE (visit_date >= '2022-01-05' AND visit_date <= '2022-01-10') OR (pizzeria_id = 2)
  ORDER BY person_id DESC;
