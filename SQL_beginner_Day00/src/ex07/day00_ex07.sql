SELECT
  id, name,
    case
      when(age BETWEEN 10 AND 20) then
        'interval #1'
      when(age BETWEEN 19 AND 23) then
        'interval #2'
      else
        'interval #3'
    end 
  interval_info
FROM person
  ORDER BY interval_info;
