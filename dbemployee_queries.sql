show databases;
use dbemployee;
show tables;

select * from dept;
select * from salgrade;
select * from emp;

-- 2. Select the employees in department 30.
select * from emp where DEPTNO = 30;

-- 3. List the names, numbers and departments of all clerks.
SELECT EMPNO, ENAME, DEPTNO FROM emp where JOB = 'CLERK';

-- 4. Find the department numbers and names of employees of all departments with deptno greater than 20.
SELECT emp.DEPTNO, emp.ENAME, dept.DNAME FROM emp INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO WHERE emp.DEPTNO > 20;

-- 5. Find employees whose commission is greater than their salaries.
select EMPNO, ENAME, COMM, SAL from emp where COMM>SAL ;

-- 6. Find employees whose commission is greater than 60 % of their salaries.
SELECT EMPNO, ENAME, COMM, SAL FROM emp WHERE COMM > 0.6 * SAL;

-- 7. List name, job and salary of all employees in department 20 who earn more than 2000/-.
SELECT ENAME, JOB, SAL FROM emp WHERE SAL > 2000 and DEPTNO = 30;

-- 8. Find all salesmen in department 30 whose salary is greater than 1500/-.
SELECT ENAME, JOB, SAL  FROM emp WHERE JOB= 'SALESMAN' and SAL >1500 and DEPTNO = 30;

-- 9. Find all employees whose designation is either manager or president.
SELECT ENAME, JOB FROM emp WHERE JOB= 'MANAGER' or 'PRESIDENT';

-- 10. Find all managers who are not in department 30.
SELECT ENAME, JOB FROM emp WHERE JOB= 'MANAGER'AND DEPTNO != 30;

-- 11. Find all the details of managers and clerks in dept 10.
SELECT * 
FROM emp 
where DEPTNO= 10 AND JOB IN ('MANAGER' , 'CLERK');

-- 12. Find the details of all the managers (in any dept) and clerks in dept 20.
SELECT * 
FROM emp 
WHERE JOB = 'Manager' 
	  OR (DEPTNO = 20 AND JOB = 'Clerk');

-- 13. Find the details of all the managers in dept. 10 and all clerks in dept 20 and all employees 
-- who are neither managers nor clerks but whose salary is more than or equal to 2000/-

SELECT * 
FROM emp
WHERE (JOB = 'MANAGER' AND DEPTNO = 10)
   OR (JOB = 'CLERK' AND DEPTNO = 20)
   OR (JOB NOT IN ('MANAGER', 'CLERK') AND SAL >= 2000);

-- 14. Find the names of anyone in dept. 20 who is neither manager nor clerk.
select ENAME
from emp
where DEPTNO = 20 AND JOB NOT IN ( 'MANAGER', 'CLERK');

-- 15. Find the names of employees who earn between 1200/- and 1400/-.
select ENAME
from emp
where SAL between 1200 AND 1400;

-- 16. Find the employees who are clerks, analysts or salesmen.
SELECT EMPNO, ENAME, JOB FROM emp WHERE job IN ('CLERK', 'ANALYST', 'SALESMAN');

-- 17. Find the employees who are not clerks, analysts or salesmen.
SELECT EMPNO, ENAME, JOB FROM emp WHERE job NOT IN ('CLERK', 'ANALYST', 'SALESMAN');

-- 18. Find the employees who do not receive commission.
SELECT EMPNO, ENAME, JOB, COMM from emp  where COMM = 0 or COMM is null;

-- 19. Find the different jobs of employees receiving commission.
SELECT DISTINCT JOB FROM emp WHERE COMM IS NOT NULL AND COMM > 0;

-- 20. Find the employees who do not receive commission or whose commission is less than 100/-.
select * from emp  where COMM <=100 or COMM is null;

-- 21. If all the employees not receiving commission is entitles to a bonus of Rs. 250/- show the net earnings of all the employees.
SELECT 
    EMPNO, ENAME, SAL, COMM, 
    CASE 
        WHEN COMM IS NULL THEN SAL + 250 
        ELSE SAL + COMM 
    END AS net_earnings
FROM 
    emp;

-- 22. Find all the employees whose total earning is greater than 2000/- 
SELECT 
    EMPNO, ENAME, SAL, COMM, 
    CASE 
        WHEN COMM IS NULL THEN SAL + 250 
        ELSE SAL + COMM 
    END AS net_earnings
FROM 
    emp
WHERE 
    CASE 
        WHEN COMM IS NULL THEN SAL + 250 
        ELSE SAL + COMM 
    END > 2000;

-- find all the employees whose total earnings are greater than Rs. 2000/-,
-- without considering any bonus, you can use the following query. Assuming the employees 
-- table has columns salary (SAL) and commission (COMM):
SELECT 
    EMPNO, ENAME, SAL, COMM, 
    SAL + COALESCE(COMM, 0) AS total_earnings
FROM emp
WHERE SAL + COALESCE(COMM, 0) > 2000;

-- 23. Find all the employees whose name begins or ends with ‘M’
select ENAME
from emp
where ENAME LIKE 'M%' 
    OR ENAME LIKE '%M';

-- 24. Find all the employees whose names contain the letter ‘M’ in any case.
select ENAME from emp where  LOWER(ENAME) LIKE '%m%';
 
 -- 25. Find all the employees whose names are upto 15 character long and have letter ‘R’ as 3rd character of their names.
 SELECT 
    EMPNO, ENAME, SAL, COMM
FROM 
    emp
WHERE 
    LENGTH(ENAME) <= 15 
    AND ENAME LIKE '__R%';

-- 26. Find all the employees who were hired in the month of February (of any year).
select * from emp where MONTH (HIREDATE) = 2;

-- 27. Find all the employees who were hired on last day of the month.
SELECT HIREDATE, LAST_DAY(HIREDATE) AS last_day_of_month FROM emp;

-- 28. Find all the employees who were hired more than 2 years ago.
SELECT * FROM emp WHERE HIREDATE < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 29. Find the managers hired in the year 1981.
SELECT * FROM emp WHERE JOB = 'MANAGER' AND YEAR(HIREDATE) = 1981;

-- 30. Display the names and jobs of all the employees separated by a space.
SELECT ENAME, JOB, CONCAT(ENAME, ' ', JOB) AS name_and_job FROM emp;

-- 31. Display the names of all the employees right aligning them to 15 characters.
SELECT LPAD(ENAME, 15, ' ') AS right_aligned_name
FROM emp;

-- 32. Display the names of all the employees padding them to the right up to 15 characters with ‘*’.
SELECT RPAD(ENAME, 15, '*') AS padded_name
FROM emp;

-- 33. Display the names of all the employees without any leading ‘A’.
SELECT ENAME,
       CASE
           WHEN ENAME LIKE 'A%' THEN SUBSTR(ENAME, 2)
           ELSE ENAME
       END AS modified_name
FROM emp;

-- or 

SELECT ENAME,
       TRIM(LEADING 'A' FROM ENAME) AS modified_name
FROM emp;

-- 34. Display the names of all the employees without any trailing ‘R’.
SELECT ENAME,
       CASE
           WHEN ENAME LIKE '%R' THEN LEFT(ENAME, LENGTH(ENAME) - 1)
           ELSE ENAME
       END AS modified_name
FROM emp;

-- 35. Show the first 3 and last 3 characters of the names of all the employees.
SELECT ENAME,
       CONCAT(LEFT(ENAME, 3), RIGHT(ENAME, 3)) AS first_and_last
FROM emp;

-- 36. Display the names of all the employees replacing ‘A’ with ‘a’.
SELECT ENAME,
       REPLACE(ENAME, 'A', 'a') AS modified_name
FROM emp;

-- 37. Display the names of all the employees and position where the string ‘AR’ occurs in the name.
SELECT ENAME,
       LOCATE('AR', ENAME) AS position_of_AR
FROM emp;

-- 38. Show the salary of all the employees , rounding it to the nearest Rs. 1000/-
SELECT ENAME, SAL,
       ROUND(SAL, -3) AS rounded_salary
FROM emp;

-- 39. Show the salary of all the employees , ignoring the fraction less than Rs. 1000/-
SELECT ENAME, SAL,
       FLOOR(SAL / 1000) * 1000 AS truncated_salary
FROM emp;

-- 40. Show the names of all the employees and date on which they completed 3 years of service.
SELECT ENAME, HIREDATE,
       HIREDATE + INTERVAL 3 YEAR AS completion_date
FROM emp;

-- 41. For each employee, display the no. of days passed since the employee joined the company.
SELECT ENAME, HIREDATE,
       DATEDIFF(CURDATE(), HIREDATE) AS days_passed
FROM emp;

-- 42. For each employee, display the no. of months passed since the employee joined the company
SELECT ENAME, HIREDATE,
       TIMESTAMPDIFF(MONTH, HIREDATE, CURDATE()) AS months_passed
FROM emp;

-- 43. Display the details of all the employees sorted on the names.
SELECT * FROM emp ORDER BY ENAME;

-- 44. Display the names of the employees, based on the tenure with the oldest employee coming first.
SELECT ENAME FROM emp ORDER BY HIREDATE ASC;

-- 45. Display the names, jobs and salaries of employees, sorting on job and salary.
SELECT ENAME, JOB, SAL
FROM emp
ORDER BY JOB, SAL DESC;

-- 46. Display the names, jobs and salaries of employees, sorting on descending order of job and within job sorted on salary.
SELECT ENAME, JOB, SAL
FROM emp
ORDER BY JOB DESC, SAL;

-- 47. List the employee names, department names and salary for those employees who have completed 1 year of service.
SELECT e.ENAME, d.DNAME, e.SAL
FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO
WHERE e.HIREDATE <= CURDATE() - INTERVAL 1 YEAR;

-- 48. List the employee names, department names and salary for those employees who are earning 0 commission or commission is null. 
-- Sort your output in the order of department name.

SELECT e.ENAME, d.DNAME, e.SAL
FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO
WHERE e.COMM IS NULL OR e.COMM = 0
ORDER BY d.DNAME;

-- 49. List the employee names, department names and hiredate for those employees who have joined in 1981 . Sort your output in the order of joining date.
SELECT e.ENAME, d.DNAME, e.HIREDATE
FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO
WHERE YEAR(e.HIREDATE) = 1981
ORDER BY e.HIREDATE;


select * from dept;
select * from salgrade;
select * from emp;


-- 50. List all the department names along with the names of employees in them , irrespective of the fact whether any employee is there or not.
SELECT dept.DNAME, emp.ENAME
FROM dept
LEFT JOIN emp ON dept.DEPTNO = emp.DEPTNO
ORDER BY dept.DNAME, emp.ENAME;


-- 51. List all the department names along with the names of managers in them, irrespective of the fact whether any manager is there or not.
SELECT dept.DNAME, emp.ENAME AS Manager
FROM dept
LEFT JOIN (
    SELECT ENAME, DEPTNO
    FROM emp
    WHERE JOB = 'MANAGER'
) AS emp ON dept.DEPTNO = emp.DEPTNO
ORDER BY dept.DNAME, emp.ENAME;


-- 52. Find names, job, and salaries of all employees and also their immediate boss.
SELECT emp.ENAME AS Employee, emp.JOB, emp.SAL, boss.ENAME AS Boss
FROM emp
LEFT JOIN emp AS boss ON emp.MGR = boss.EMPNO;


-- 53. Find the names of those employees who earn more than their boss.
SELECT emp.ENAME AS Employee
FROM emp
JOIN emp AS boss ON emp.MGR = boss.EMPNO
WHERE emp.SAL > boss.SAL;


-- 54. Find all the employees who are senior to their bosses.
SELECT emp.ENAME AS Employee
FROM emp
JOIN emp AS boss ON emp.MGR = boss.EMPNO
WHERE emp.HIREDATE < boss.HIREDATE;

-- 55. Find the names of those employees whose immediate boss is in a different department.
SELECT emp.ENAME AS Employee
FROM emp
JOIN emp AS boss ON emp.MGR = boss.EMPNO
WHERE emp.DEPTNO <> boss.DEPTNO;

-- 56. List all the employee names along with the names of their bosses, irrespective of the fact whether any employee has a boss or not.
SELECT emp.ENAME AS Employee, boss.ENAME AS Boss
FROM emp
LEFT JOIN emp AS boss ON emp.MGR = boss.EMPNO;

-- 57. List department number and each distinct pair of employees working in that department.
SELECT emp1.DEPTNO, emp1.ENAME AS Employee1, emp2.ENAME AS Employee2
FROM emp emp1
JOIN emp emp2 ON emp1.DEPTNO = emp2.DEPTNO AND emp1.EMPNO < emp2.EMPNO
ORDER BY emp1.DEPTNO, emp1.ENAME, emp2.ENAME;

-- 58. Display the highest, lowest, sum, and average salary of all the employees. Round your result to whole numbers.
SELECT 
    ROUND(MAX(SAL)) AS Highest_Salary,
    ROUND(MIN(SAL)) AS Lowest_Salary,
    ROUND(SUM(SAL)) AS Total_Salary,
    ROUND(AVG(SAL)) AS Average_Salary
FROM emp;

-- 59. Display the highest, lowest, sum, and average salary for each job.
SELECT JOB,
    ROUND(MAX(SAL)) AS Highest_Salary,
    ROUND(MIN(SAL)) AS Lowest_Salary,
    ROUND(SUM(SAL)) AS Total_Salary,
    ROUND(AVG(SAL)) AS Average_Salary
FROM emp
GROUP BY JOB;

-- 60. Count the number of bosses without listing them.
SELECT COUNT(DISTINCT MGR) AS Number_of_Bosses
FROM emp
WHERE MGR IS NOT NULL;

-- 61. Display the difference between the highest and lowest salary.
SELECT MAX(SAL) - MIN(SAL) AS Salary_Difference
FROM emp;

-- 62. Display department name and the difference between the highest and lowest salary for that department.
SELECT dept.DNAME, MAX(emp.SAL) - MIN(emp.SAL) AS Salary_Difference
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
GROUP BY dept.DNAME;


-- 63. Display department name and average salary for that department. Include only those employees who have joined after 1
SELECT dept.DNAME, ROUND(AVG(emp.SAL), 0) AS Average_Salary
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
WHERE emp.HIREDATE > '2001-07-01'
GROUP BY dept.DNAME;

-- 64. Display the boss and the salary of the lowest-paid employee for him. Don’t include minimum salary below Rs. 1000/-.
SELECT boss.ENAME AS Boss, MIN(emp.SAL) AS Lowest_Salary
FROM emp
JOIN emp AS boss ON emp.MGR = boss.EMPNO
WHERE emp.SAL >= 1000
GROUP BY boss.ENAME;


-- 65. Display department name, location name, the number of people working there, and average salary. Round average salary to 2 decimal places.
SELECT dept.DNAME, dept.LOC, COUNT(emp.EMPNO) AS Number_of_People, ROUND(AVG(emp.SAL), 2) AS Average_Salary
FROM dept
LEFT JOIN emp ON dept.DEPTNO = emp.DEPTNO
GROUP BY dept.DNAME, dept.LOC;


-- 66. Count distinct salary figures and the number of employees receiving it.
SELECT SAL, COUNT(EMPNO) AS Number_of_Employees
FROM emp
GROUP BY SAL;

-- 67. Find all the department details in which at least one employee is working.
SELECT DISTINCT dept.*
FROM dept
JOIN emp ON dept.DEPTNO = emp.DEPTNO;


-- 68. Find all who are bosses of at least one employee.
SELECT DISTINCT boss.ENAME AS Boss
FROM emp
JOIN emp AS boss ON emp.MGR = boss.EMPNO;


-- 69. Find the average annual salary of all the employees except analysts.
SELECT ROUND(AVG(SAL), 0) AS Average_Annual_Salary
FROM emp
WHERE JOB <> 'ANALYST';

-- 70. Create a unique listing of all the jobs that are in dept. 30. Include the location of the dept. in the output.
SELECT DISTINCT emp.JOB, dept.LOC
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
WHERE emp.DEPTNO = 30;


-- 71. List employee name, dept. name, job, and location of all employees who work in DALLAS.
SELECT emp.ENAME, dept.DNAME, emp.JOB, dept.LOC
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
WHERE dept.LOC = 'DALLAS';


-- 72. List employee name and hire date of all employees who are hired after BLAKE.
SELECT emp.ENAME, emp.HIREDATE
FROM emp
WHERE emp.HIREDATE > (SELECT HIREDATE FROM emp WHERE ENAME = 'BLAKE');


-- 73. List employee name, hire date, manager name, and manager’s hire date of all employees who are hired before their managers.
SELECT emp.ENAME AS Employee, emp.HIREDATE AS Employee_Hiredate, mgr.ENAME AS Manager, mgr.HIREDATE AS Manager_Hiredate
FROM emp emp
JOIN emp mgr ON emp.MGR = mgr.EMPNO
WHERE emp.HIREDATE < mgr.HIREDATE;

-- 74. Display the job and the difference between the highest and the lowest salary for each job.
SELECT JOB, MAX(SAL) - MIN(SAL) AS Salary_Difference
FROM emp
GROUP BY JOB;

-- 75. Display manager and the salary of the lowest-paid employee of the manager.
SELECT mgr.ENAME AS Manager, MIN(emp.SAL) AS Lowest_Salary
FROM emp emp
JOIN emp mgr ON emp.MGR = mgr.EMPNO
GROUP BY mgr.ENAME;


-- 76. Display dept. name, location, number of employees in the dept., and average salary of the dept. rounded to 2 decimal places.
SELECT dept.DNAME, dept.LOC, COUNT(emp.EMPNO) AS Number_of_Employees, ROUND(AVG(emp.SAL), 2) AS Average_Salary
FROM dept
LEFT JOIN emp ON dept.DEPTNO = emp.DEPTNO
GROUP BY dept.DNAME, dept.LOC;


-- 77. List employee name and hire date of all employees who are in the same dept. as BLAKE. Exclude BLAKE.
SELECT emp.ENAME, emp.HIREDATE
FROM emp
WHERE emp.DEPTNO = (SELECT DEPTNO FROM emp WHERE ENAME = 'BLAKE')
AND emp.ENAME <> 'BLAKE';


-- 78. Display names and salary of all the employees who report to KING.
SELECT emp.ENAME, emp.SAL
FROM emp emp
JOIN emp mgr ON emp.MGR = mgr.EMPNO
WHERE mgr.ENAME = 'KING';


-- 79. Write a query to display name, dept. no, and salary of any employee who is not located in DALLAS but whose salary and commission match with the salary and commission of at least one employee located in DALLAS.
SELECT emp1.ENAME, emp1.DEPTNO, emp1.SAL
FROM emp emp1
JOIN emp emp2 ON emp1.SAL = emp2.SAL AND emp1.COMM = emp2.COMM
JOIN dept ON emp2.DEPTNO = dept.DEPTNO
WHERE dept.LOC = 'DALLAS' AND emp1.DEPTNO <> emp2.DEPTNO;


-- 80. Display name, hire date, and salary of all the employees who have both salary and commission the same as SCOTT. Do not include Scott in the list.
SELECT emp.ENAME, emp.HIREDATE, emp.SAL
FROM emp
WHERE emp.SAL = (SELECT SAL FROM emp WHERE ENAME = 'SCOTT')
AND emp.COMM = (SELECT COMM FROM emp WHERE ENAME = 'SCOTT')
AND emp.ENAME <> 'SCOTT';


-- 81. List employees who earn a salary higher than the highest salary of clerks.
SELECT emp.ENAME
FROM emp
WHERE emp.SAL > (SELECT MAX(SAL) FROM emp WHERE JOB = 'CLERK');


-- 82. List employees whose salary is higher than the average salary of employees in department no. 10.
SELECT emp.ENAME
FROM emp
WHERE emp.SAL > (SELECT AVG(SAL) FROM emp WHERE DEPTNO = 10);


-- 83. Display the names of employees who are earning the minimum and maximum salary in one line.
SELECT 
    (SELECT ENAME FROM emp WHERE SAL = (SELECT MIN(SAL) FROM emp)) AS Min_Salary_Employee,
    (SELECT ENAME FROM emp WHERE SAL = (SELECT MAX(SAL) FROM emp)) AS Max_Salary_Employee;


-- 86. Print employee name, salary, and average salary of his department.
SELECT emp.ENAME, emp.SAL, dept_avg.Avg_Salary AS Dept_Avg_Salary
FROM emp
JOIN (
    SELECT DEPTNO, AVG(SAL) AS Avg_Salary
    FROM emp
    GROUP BY DEPTNO
) AS dept_avg ON emp.DEPTNO = dept_avg.DEPTNO;


-- 87. Display ename, department name, and grade of each employee who joined the organization before their boss.
SELECT emp.ENAME, dept.DNAME, salgrade.GRADE
FROM emp emp
JOIN emp mgr ON emp.MGR = mgr.EMPNO
JOIN dept ON emp.DEPTNO = dept.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE emp.HIREDATE < mgr.HIREDATE;


-- 88. * Display each department name and the first employee who joined that department.
SELECT dept.DNAME, emp.ENAME
FROM dept
JOIN emp ON dept.DEPTNO = emp.DEPTNO
WHERE emp.HIREDATE = (
    SELECT MIN(HIREDATE)
    FROM emp
    WHERE DEPTNO = dept.DEPTNO
);

-- 89. * How much more salary does Miller need to earn to be in King’s grade?
SELECT 
    salgrade.HISAL - miller.SAL AS Additional_Salary_Required
FROM emp miller
JOIN emp king ON king.ENAME = 'KING'
JOIN salgrade ON king.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE miller.ENAME = 'MILLER';

-- 90. * Display employees who joined in the last month (1st day of last month – Last day of last month). Do not hardcode the month name.
SELECT ENAME, HIREDATE
FROM emp
WHERE HIREDATE BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND LAST_DAY(CURDATE() - INTERVAL 1 MONTH);

-- 91. How much more salary does each person need to earn to go to the next grade?
SELECT emp.ENAME, salgrade_next.LOSAL - emp.SAL AS Additional_Salary_Required
FROM emp
JOIN salgrade salgrade_current ON emp.SAL BETWEEN salgrade_current.LOSAL AND salgrade_current.HISAL
JOIN salgrade salgrade_next ON salgrade_current.GRADE + 1 = salgrade_next.GRADE;

-- 92. * List different locations from where employees are reporting to King.
SELECT DISTINCT dept.LOC
FROM emp
JOIN emp king ON emp.MGR = king.EMPNO
JOIN dept ON emp.DEPTNO = dept.DEPTNO
WHERE king.ENAME = 'KING';

-- 93. * List different grades of employees working in ‘DALLAS’.
SELECT DISTINCT salgrade.GRADE
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE dept.LOC = 'DALLAS';

-- 94. Display grade 2 employees in the Finance department who will complete 3 years in March this year.
SELECT emp.ENAME, emp.HIREDATE
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE salgrade.GRADE = 2 AND dept.DNAME = 'FINANCE' AND MONTH(emp.HIREDATE) = 3 AND YEAR(emp.HIREDATE) = YEAR(CURDATE()) - 3;

-- 95. Display employees who are earning salaries more than the average salary of employees in the same grade.
SELECT emp.ENAME
FROM emp
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE emp.SAL > (SELECT AVG(SAL) FROM emp WHERE SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL);

-- 96. Display employees who are in the same grade as Miller and do not belong to the place Miller belongs to.
SELECT emp.ENAME
FROM emp
JOIN emp miller ON miller.ENAME = 'MILLER'
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
JOIN dept emp_dept ON emp.DEPTNO = emp_dept.DEPTNO
JOIN dept miller_dept ON miller.DEPTNO = miller_dept.DEPTNO
WHERE emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL AND emp.DEPTNO <> miller.DEPTNO;

-- 97. How many employees are there between the highest grade of a clerk and the lowest grade of a manager?
SELECT COUNT(*)
FROM emp
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE salgrade.GRADE BETWEEN 
    (SELECT MAX(salgrade_clerk.GRADE) FROM emp emp_clerk JOIN salgrade salgrade_clerk ON emp_clerk.SAL BETWEEN salgrade_clerk.LOSAL AND salgrade_clerk.HISAL WHERE emp_clerk.JOB = 'CLERK')
    AND 
    (SELECT MIN(salgrade_manager.GRADE) FROM emp emp_manager JOIN salgrade salgrade_manager ON emp_manager.SAL BETWEEN salgrade_manager.LOSAL AND salgrade_manager.HISAL WHERE emp_manager.JOB = 'MANAGER');

-- 98. List analysts and clerks who are either staying in Chicago or Boston and in grade 3 and above.
SELECT emp.ENAME, emp.JOB, dept.LOC, salgrade.GRADE
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE emp.JOB IN ('ANALYST', 'CLERK') AND dept.LOC IN ('CHICAGO', 'BOSTON') AND salgrade.GRADE >= 3;

-- 99. Display department name, grade, and max salary offered to each grade at each department.
SELECT dept.DNAME, salgrade.GRADE, MAX(emp.SAL) AS Max_Salary
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
GROUP BY dept.DNAME, salgrade.GRADE;

-- 100. Who’s earning the best salary in each grade and where do they live?
SELECT emp.ENAME, salgrade.GRADE, emp.SAL, dept.LOC
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
WHERE emp.SAL = (SELECT MAX(emp2.SAL) FROM emp emp2 JOIN salgrade salgrade2 ON emp2.SAL BETWEEN salgrade2.LOSAL AND salgrade2.HISAL WHERE salgrade2.GRADE = salgrade.GRADE);

-- 101. Display the locations where the total salary of grade 3 employees is greater than the total salary of grade 4 employees.
SELECT dept.LOC
FROM dept
JOIN emp ON dept.DEPTNO = emp.DEPTNO
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
GROUP BY dept.LOC
HAVING SUM(CASE WHEN salgrade.GRADE = 3 THEN emp.SAL ELSE 0 END) > SUM(CASE WHEN salgrade.GRADE = 4 THEN emp.SAL ELSE 0 END);

-- 102. * Display grade, highest salary in that grade, and lowest salary in that grade.
SELECT salgrade.GRADE, MAX(emp.SAL) AS Highest_Salary, MIN(emp.SAL) AS Lowest_Salary
FROM emp
JOIN salgrade ON emp.SAL BETWEEN salgrade.LOSAL AND salgrade.HISAL
GROUP BY salgrade.GRADE;

-- 103. * Display location, highest salary in that location, and lowest salary in that location.
SELECT dept.LOC, MAX(emp.SAL) AS Highest_Salary, MIN(emp.SAL) AS Lowest_Salary
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
GROUP BY dept.LOC;

-- 104. Display the department names where every employee is earning more than 2000.
SELECT dept.DNAME
FROM dept
JOIN emp ON dept.DEPTNO = emp.DEPTNO
GROUP BY dept.DNAME
HAVING MIN(emp.SAL) > 2000;

-- 105. Display the dept name, difference between hisal of the highest-earning employee in that dept and the average salary for every department.
SELECT dept.DNAME, MAX(emp.SAL) - AVG(emp.SAL) AS Salary_Difference
FROM dept
JOIN emp ON dept.DEPTNO = emp.DEPTNO
GROUP BY dept.DNAME;


