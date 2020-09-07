--DELIVERABLE #1:
--STEPS 1-7:
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   ti.title,
	   ti.from_date,
	   ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no;

--STEPS 8-14:
SELECT DISTINCT ON (emp_no)
	emp_no, first_name, last_name, title 
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--STEPS 15-21:
SELECT title, COUNT(emp_no) as ct_emp
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY ct_emp DESC;

--DELIVERABLE #2:

SELECT DISTINCT ON (e.emp_no)
	   e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title
INTO mentorship_eligibility
from employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC;

--DELIVERABLE # 3 
SELECT AVG (EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM from_date)), title
FROM retirement_titles
GROUP BY title;

SELECT u.title, count(u.last_name) as retirees, EXTRACT(YEAR FROM birth_date)as b_year
INTO retirees_by_year
FROM unique_titles as u
INNER JOIN employees as e
on u.emp_no = e.emp_no
GROUP BY title,b_year;

select title, count(emp_no)
INTO mentors_by_title
FROM mentorship_eligibility
GROUP BY title;

-- ASSIGNMENT OVER

