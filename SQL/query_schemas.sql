--Data engeneering
--Drop tables if existing
drop table if exists departments;
drop table if exists dept_emp;
drop table if exists dept_manager;
drop table if exists employees;
drop table if exists salaries;
drop table if exists titles;

-- Import CSV Files Into Corresponding SQL Tabl
--Create departments table
create table departments(
	dept_no varchar(4) primary key not null,
	dept_name varchar(30) not null
);	
--Create employees table
create table employees(
	emp_no int primary key not null,
	birth_date varchar not null,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	gender varchar(1) not null,
	hire_date date not null
);
--Create department employees table
create table dept_emp(
	emp_no int not null,
	foreign key (emp_no) references employees (emp_no),
	dept_no varchar(4) not null,
	foreign key (dept_no) references departments (dept_no),
	from_date date not null,
	to_date date not null
);

--Create department manager table
create table dept_manager(
	dept_no varchar(4) not null,
	foreign key (dept_no) references departments (dept_no),
	emp_no int not null,
	foreign key (emp_no) references employees (emp_no),
	from_date date not null,
	to_date date not null
);

--Create salaries table 
create table salaries(
	emp_no int not null,
	foreign key (emp_no) references employees (emp_no),
	salary int not null,
	from_date date not null,
	to_date date not null
);

--Create titles table
create table titles(
	emp_no int not null,
	foreign key (emp_no) references employees(emp_no),
	title varchar(30) not null,
	from_date date not null,
	to_date date not null
);

---Data Analysis
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

--1.List the following details of each employee: employee number, last name, first name, gender, and salary.	
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from salaries as s
inner join employees as e on
e.emp_no = s.emp_no;
	
--2.List employees who were hired in 1986.
select first_name,last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1987-01-01';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
from departments
join dept_manager
on departments.dept_no = dept_manager.dept_no
join employees
on dept_manager.emp_no = employees.emp_no;

--4.List the department of each employee with the following information: employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no;

--5.List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees
where first_name like 'Hercules'
and last_name like 'B%';

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, dp.dept_name
from employees as e
inner join dept_emp as d on
e.emp_no = d.emp_no
inner join departments as dp on
dp.dept_no = d.dept_no
where dp.dept_name like 'Sales';

--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, dp.dept_name
from employees as e
inner join dept_emp as d on
e.emp_no = d.emp_no
inner join departments as dp on
dp.dept_no = d.dept_no
where dp.dept_name like 'Development'
or dp.dept_name like 'Sales';
	
--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(*) as frequency
from employees
group by last_name
order by frequency desc;
