-  Data is from https://github.com/vrajmohan/pgsql-sample-data/tree/master/employee
-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
  dept_no VARCHAR(4) NOT NULL,
  dept_name VARCHAR(40) NOT NULL,
  PRIMARY KEY (dept_no),
  UNIQUE (dept_name)
);

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

--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
select emp_no,first_name,last_name
from employees;

--Retrieve the title, from_date, and to_date columns from the Titles table.
select title,from_date,to_date
from titles;

--Create a new table using the INTO clause.
--Join both tables on the primary key.
--Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
select e.emp_no,e.first_name,e.last_name,
	t.title, t.from_date,t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

--Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
select emp_no,first_name,last_name,title from retirement_titles;



--Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Use Dictinct with Orderby to remove duplicate rows
--Create a Unique Titles table using the INTO clause.
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO  Unique_Titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

--First, retrieve the number of titles from the Unique Titles table
select * from unique_titles
--Then, create a Retiring Titles table to hold the required information.
--Group the table by title, then sort the count column in descending order.
SELECT
    title,
    COUNT (title)
INTO retiring_titles
FROM
    unique_titles
GROUP BY title
ORDER BY count DESC

--Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
--Before you export your table, confirm that it looks like this image:
--Save your Employee_Database_challenge.sql file in your Queries folder in the Pewlett-Hackard folder
SELECT * FROM retiring_titles