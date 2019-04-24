-- Questao 1

SELECT COUNT (*) FROM employee WHERE (sex='F');

-- Questao 2

SELECT avg(salary) FROM employee WHERE (sex = 'M' AND (address LIKE '%TX%'));

-- Questao 3

SELECT superssn AS ssn_supervisor, COUNT(*) 
AS qtd_supervisionados 
FROM employee 
GROUP BY superssn 
ORDER BY qtd_supervisionados ASC;

-- Questao 4

SELECT sup.fname AS nome_supervisor, COUNT(emp.ssn) AS qtd
FROM (employee AS sup
JOIN employee AS emp
ON emp.superssn = sup.ssn)
GROUP BY nome_supervisor
ORDER BY qtd ASC;

-- Questao 5

SELECT sup.fname AS nome_supervisor, COUNT(emp.ssn) AS qtd
FROM (employee AS sup
RIGHT OUTER JOIN employee AS emp
ON emp.superssn = sup.ssn)
GROUP BY nome_supervisor
ORDER BY qtd ASC;

-- Questao 6

SELECT MIN(quant.num) AS qtd
FROM (SELECT pno, COUNT(*) AS num
FROM works_on 
GROUP BY pno) AS quant;

-- Questao 7

SELECT pno AS num_projeto, MIN(num) AS qtd
FROM JOIN (((SELECT pno, COUNT(*) AS num
FROM works_on 
GROUP BY pno) AS quant)
 
((SELECT pno
FROM works_on 
GROUP BY pno) AS pnum)
)
ON pnum.pno = quant.pno;

