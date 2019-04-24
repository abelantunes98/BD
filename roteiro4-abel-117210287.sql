-- Questao 1
SELECT * FROM department;

-- Questao 2
SELECT * FROM dependent;

-- Questao 3
SELECT * FROM dept_locations;

-- Questao 4
SELECT * FROM employee;

-- Questao 5
SELECT * FROM project;

-- Questao 6
SELECT * FROM works_on;

-- Questao 7
SELECT fname, lname FROM employee WHERE (sex = 'M');

-- Questao 8
SELECT fname FROM employee WHERE (sex = 'M' AND superssn is NULL); 

-- Questao 9
SELECT e.fname AS nameEmp, s.fname AS nameSup FROM employee AS e, employee AS s WHERE (e.superssn = s.ssn AND e.superssn is NOT NULL);

-- Questao 10
SELECT emp.fname FROM employee AS emp, employee AS sup WHERE (emp.superssn = sup.ssn AND sup.fname = 'Franklin');

-- Questao 11
SELECT dname, dlocation FROM department AS dp, dept_locations AS dpl WHERE (dp.dnumber = dpl.dnumber);

-- Questao 12
SELECT dname FROM department AS dp, dept_locations AS dpL WHERE (dp.dnumber = dpl.dnumber AND dpl.dlocation LIKE 'S%');

