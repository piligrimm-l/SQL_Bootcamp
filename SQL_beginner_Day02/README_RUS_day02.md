# Day 02 — SQL Bootcamp

## _Deep diving into JOINs in SQL_

Resume: Today you will see how to get needed data based on different structures JOINs.

💡 [Tap here](https://new.oprosso.net/p/4cb31ec3f47a4596bc758ea1861fb624) **to leave your feedback on the project**. It's anonymous and will help our team make your educational experience better. We recommend completing the survey immediately after the project.

## Contents

1. [Chapter I](#chapter-i) \
    1.1. [Preamble](#preamble)
2. [Chapter II](#chapter-ii) \
    2.1. [General Rules](#general-rules)
3. [Chapter III](#chapter-iii) \
    3.1. [Rules of the day](#rules-of-the-day)  
4. [Chapter IV](#chapter-iv) \
    4.1. [Exercise 00 — Move to the LEFT, move to the RIGHT](#exercise-00-move-to-the-left-move-to-the-right)  
5. [Chapter V](#chapter-v) \
    5.1. [Exercise 01 — Find data gaps](#exercise-01-find-data-gaps)  
6. [Chapter VI](#chapter-vi) \
    6.1. [Exercise 02 — FULL means ‘completely filled’](#exercise-02-full-means-completely-filled)  
7. [Chapter VII](#chapter-vii) \
    7.1. [Exercise 03 — Reformat to CTE](#exercise-03-reformat-to-cte)  
8. [Chapter VIII](#chapter-viii) \
    8.1. [Exercise 04 — Find favourite pizzas](#exercise-04-find-favourite-pizzas)
9. [Chapter IX](#chapter-ix) \
    9.1. [Exercise 05 — Investigate Person Data](#exercise-05-investigate-person-data)
10. [Chapter X](#chapter-x) \
    10.1. [Exercise 06 — favourite pizzas for Denis and Anna](#exercise-06-favourite-pizzas-for-denis-and-anna)
11. [Chapter XI](#chapter-xi) \
    11.1. [Exercise 07 — Cheapest pizzeria for Dmitriy](#exercise-07-cheapest-pizzeria-for-dmitriy)
12. [Chapter XII](#chapter-xii) \
    12.1. [Exercise 08 — Continuing to research data](#exercise-08-continuing-to-research-data)
13. [Chapter XIII](#chapter-xiii) \
    13.1. [Exercise 09 — Who loves cheese and pepperoni?](#exercise-09-who-loves-cheese-and-pepperoni)
14. [Chapter XIV](#chapter-xiv) \
    14.1. [Exercise 10 — Find persons from one city](#exercise-10-find-persons-from-one-city)


## Chapter I
## Preamble

![D02_01](misc/images/D02_01.png)

На изображении показано реляционное выражение в древовидном представлении.
Это выражение соответствует следующему SQL-запросу:

    SELECT *
        FROM R CROSS JOIN S
    WHERE clause

Другими словами, мы можем описать любой SQL на математическом языке
реляционной алгебры.

Главный вопрос (который мы слышим от наших студентов): зачем нам изучать курс
реляционной алгебры, если мы можем написать SQL с первой попытки? Мой ответ: и
да, и нет одновременно. «Да» означает, что вы можете написать SQL с первой
попытки, это верно, «Нет» означает, что вам необходимо знать основные аспекты
реляционной алгебры, потому что эти знания используются для планов оптимизации
и для семантических запросов.
Какие соединения существуют в реляционной алгебре?
На самом деле «Перекрестное соединение» ("Cross Join") — это примитивный
оператор и предок других типов соединений.

- Natural Join,
- Theta Join,
- Semi Join,
- Anti Join,
- Left/Right/Full Joins. 

Но что такое операция соединения между двумя таблицами? Позвольте мне
представить часть псевдокода, как работает операция соединения без индексации.

    FOR r in R LOOP
        FOR s in S LOOP
        if r.id = s.r_id then add(r,s)
        …
        END;
    END;

Это всего лишь набор циклов... Никакой магии.


## Chapter II
## General Rules

- Use this page as your only reference. Do not listen to rumors and speculations about how to prepare your solution.
- Make sure you are using the latest version of PostgreSQL.
- It is perfectly fine if you use the IDE to write source code (aka SQL script).
- To be evaluated, your solution must be in your GIT repository.
- Your solutions will be evaluated by your peers.
- You should not leave any files in your directory other than those explicitly specified by the exercise instructions. It is recommended that you modify your `.gitignore` to avoid accidents.
- Got a question? Ask your neighbor to the right. Otherwise, try your neighbor on the left.
- Your reference manual: mates / Internet / Google. 
- Read the examples carefully. You may need things not specified in the topic.
- And may the SQL-Force be with you!
Absolutely anything can be represented in SQL! Let's get started and have fun!


## Chapter III
## Rules of the day

- Please make sure you have an own database and access for it on your PostgreSQL cluster. 
- Please download a [script](materials/model.sql) with Database Model here and apply the script to your database (you can use command line with psql or just run it through any IDE, for example DataGrip from JetBrains or pgAdmin from PostgreSQL community). 
- All tasks contain a list of Allowed and Denied sections with listed database options, database types, SQL constructions etc. Please have a look at that section before you start.
- Please take a look at the Logical View of our Database Model. 

![schema](misc/images/schema.png)


1. **pizzeria** table (Dictionary Table with available pizzerias)
- field id — primary key
- field name — name of pizzeria
- field rating — average rating of pizzeria (from 0 to 5 points)
2. **person** table (Dictionary Table with persons who loves pizza)
- field id — primary key
- field name — name of person
- field age — age of person
- field gender — gender of person
- field address — address of person
3. **menu** table (Dictionary Table with available menu and price for concrete pizza)
- field id — primary key
- field pizzeria_id — foreign key to pizzeria
- field pizza_name — name of pizza in pizzeria
- field price — price of concrete pizza
4. **person_visits** table (Operational Table with information about visits of pizzeria)
- field id — primary key
- field person_id — foreign key to person
- field pizzeria_id — foreign key to pizzeria
- field visit_date — date (for example 2022-01-01) of person visit 
5. **person_order** table (Operational Table with information about persons orders)
- field id — primary key
- field person_id — foreign key to person
- field menu_id — foreign key to menu
- field order_date — date (for example 2022-01-01) of person order 

People's visit and people's order are different entities and don't contain any correlation between data. For example, a customer can be in a restaurant (just looking at the menu) and in that time place an order in another restaurant by phone or mobile application. Or another case, just be at home and again make a call with order without any visits.


## Chapter IV
## Exercise 00 — Move to the LEFT, move to the RIGHT

| Exercise 00: Move to the LEFT, move to the RIGHT |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day02_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Напишите оператор SQL, который возвращает список пиццерий с соответствующим
значением рейтинга, которые еще не посещали люди.


## Chapter V
## Exercise 01 — Find data gaps

| Exercise 01: Find data gaps|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day02_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| SQL Syntax Construction                        | `generate_series(...)`                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Напишите оператор SQL, который возвращает пропущенные дни с 1 по 10 января
2022 г. (включая все дни) для посещений людьми с идентификаторами 1 или 2
(т.е. дни, пропущенные обоими). Пожалуйста, заказывайте по дням посещения в
порядке возрастания. Пример данных с именами столбцов показан ниже.

| missing_date |
| ------ |
| 2022-01-03 |
| 2022-01-04 |
| 2022-01-05 |
| ... |


## Chapter VI
## Exercise 02 — FULL means ‘completely filled’

| Exercise 02: FULL means ‘completely filled’|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day02_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Напишите, пожалуйста, оператор SQL, который будет возвращать весь список имен
людей, которые посещали (или не посещали) пиццерии в период с 1 по 3 января
2022 года с одной стороны и весь список названий посещенных пиццерий ( или не
посетил) на другой стороне. Ниже показан образец данных с необходимыми именами
столбцов. Обратите внимание на заменяющее значение «-» для значений NULL в
столбцах person_name и pizzeria_name. Пожалуйста, также добавьте порядок для
всех трех столбцов.

| person_name | visit_date | pizzeria_name |
| ------ | ------ | ------ |
| - | null | DinoPizza |
| - | null | DoDo Pizza |
| Andrey | 2022-01-01 | Dominos |
| Andrey | 2022-01-02 | Pizza Hut |
| Anna | 2022-01-01 | Pizza Hut |
| Denis | null | - |
| Dmitriy | null | - |
| ... | ... | ... |


## Chapter VII
## Exercise 03 — Reformat to CTE

| Exercise 03: Reformat to CTE |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day02_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| SQL Syntax Construction                        | `generate_series(...)`                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Давайте вернемся к упражнению № 01. Перепишите свой SQL, используя шаблон CTE
(Common Table Expression). Пожалуйста, перейдите в раздел CTE вашего
«генератора дней». Результат должен выглядеть аналогично упражнению № 01.

| missing_date | 
| ------ | 
| 2022-01-03 | 
| 2022-01-04 | 
| 2022-01-05 | 
| ... |


## Chapter VIII
## Exercise 04 — Find favourite pizzas

| Exercise 04: Find favourite pizzas |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day02_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Найдите полную информацию обо всех возможных названиях и ценах пиццерий, чтобы
получить пиццу с грибами или пепперони. Затем отсортируйте результат по
названию пиццы и названию пиццерии. Результат примера данных показан ниже
(пожалуйста, используйте те же имена столбцов в своем операторе SQL).

| pizza_name | pizzeria_name | price |
| ------ | ------ | ------ |
| mushroom pizza | Dominos | 1100 |
| mushroom pizza | Papa Johns | 950 |
| pepperoni pizza | Best Pizza | 800 |
| ... | ... | ... |


## Chapter IX
## Exercise 05 — Investigate Person Data

| Exercise 05: Investigate Person Data |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day02_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Найдите имена всех женщин старше 25 лет и отсортируйте результат по имени.
Пример вывода показан ниже.

| name | 
| ------ | 
| Elvira | 
| ... |


## Chapter X
## Exercise 06 — favourite pizzas for Denis and Anna

| Exercise 06: favourite pizzas for Denis and Anna |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day02_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Найдите все названия пицц (и соответствующие названия пиццерий с помощью
таблицы меню), заказанные Денисом или Анной. Отсортируйте результат по обоим
столбцам. Пример вывода показан ниже.

| pizza_name | pizzeria_name |
| ------ | ------ |
| cheese pizza | Best Pizza |
| cheese pizza | Pizza Hut |
| ... | ... |


## Chapter XI
## Exercise 07 — Cheapest pizzeria for Dmitriy

| Exercise 07: Cheapest pizzeria for Dmitriy |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex07                                                                                                                     |
| Files to turn-in                      | `day02_ex07.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Найдите название пиццерии, которую Дмитрий посетил 8 января 2022 года и где
мог съесть пиццу менее чем за 800 рублей.


## Chapter XII
## Exercise 08 — Continuing to research data

| Exercise 08: Continuing to research data |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex08                                                                                                                     |
| Files to turn-in                      | `day02_ex08.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |           

Пожалуйста, найдите имена всех мужчин из Москвы или Самары, которые заказывают
либо пепперони, либо пиццу с грибами (или и то, и другое). Пожалуйста,
отсортируйте результат по именам людей в порядке убывания. Пример вывода
показан ниже.

| name | 
| ------ | 
| Dmitriy | 
| ... |


## Chapter XIII
## Exercise 09 — Who loves cheese and pepperoni?

| Exercise 09: Who loves cheese and pepperoni? |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex09                                                                                                                     |
| Files to turn-in                      | `day02_ex09.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Найдите имена всех женщин, которые заказывали и пепперони, и сырную пиццу (в
любое время и в любых пиццериях). Убедитесь, что результаты упорядочены по
имени человека. Пример данных показан ниже.

| name | 
| ------ | 
| Anna | 
| ... |


## Chapter XIV
## Exercise 10 — Find persons from one city

| Exercise 10: Find persons from one city |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex10                                                                                                                     |
| Files to turn-in                      | `day02_ex10.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Найдите имена людей, живущих по тому же адресу. Убедитесь, что результат
отсортирован по имени 1-го человека, имени 2-го человека и общему адресу.
Пример данных показан ниже. Убедитесь, что имена ваших столбцов соответствуют
именам столбцов ниже.

| person_name1 | person_name2 | common_address | 
| ------ | ------ | ------ |
| Andrey | Anna | Moscow |
| Denis | Kate | Kazan |
| Elvira | Denis | Kazan |
| ... | ... | ... |

