SELECT
    CONCAT(name, ' (age:', age, ',gender:''', gender, ''',address:''', address, ''')') AS person_info FROM person
  ORDER BY person_info;
