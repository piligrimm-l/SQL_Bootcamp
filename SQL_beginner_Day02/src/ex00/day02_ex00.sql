SELECT name, rating FROM pizzeria P
FULL OUTER JOIN person_visits PV
ON PV.pizzeria_id = p.id
WHERE PV.pizzeria_id IS NULL;
