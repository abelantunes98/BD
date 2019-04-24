SELECT emp.fname, emp.lname
FROM employee AS emp
WHERE (emp.ssn NOT IN (SELECT essn FROM works_on));
