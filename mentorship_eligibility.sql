CREATE TABLE employees (
  emp_no INT NOT NULL,
  birth_date DATE NOT NULL,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  gender VARCHAR NOT NULL,
  hire_date DATE NOT NULL,
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(50) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, from_date)
);

select * from employees

--Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table..
select emp_no,first_name,last_name,birth_date
FROM employees;

--Retrieve the from_date and to_date columns from the Department Employee table.
select from_date,to_date
FROM dept_emp;

--Retrieve the title column from the Titles table.
select title
FROM titles;


--Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.

-- Select distinct on Employees file
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	birth_date
INTO Discount_employees
FROM employees
ORDER BY emp_no ASC;

select * from Discount_employees

-- Select distinct on dept_emp file
SELECT DISTINCT ON (emp_no) emp_no,
	from_date,
	to_date
INTO  Discount_dept_emp
FROM dept_emp
ORDER BY emp_no ASC;

-- Select distinct on title file
SELECT DISTINCT ON (emp_no) emp_no,
	title,
	from_date,
	to_date
INTO  Discount_titles
FROM titles
ORDER BY emp_no ASC;


--Create a new table using the INTO clause.
--Join the Employees and the Department Employee tables on the primary key.
--Join the Employees and the Titles tables on the primary key.
select e.emp_no,e.first_name,e.last_name,e.birth_date,
	 	d.from_date,d.to_date,
	  t.title
INTO mentorship_eligibilty
FROM discount_employees as e
JOIN discount_dept_emp as d
ON (e.emp_no = d.emp_no)
JOIN discount_titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

select * from mentorship_eligibilty
