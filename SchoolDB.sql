/* Created by Luanne Plemmons @ 2:22pm on September 26, 2025


This database is for use with the app.py python file. 
The only things to initialize are the tables. This way, there
are no people in the DB during the start of the .py file. 
Otherwise, there would have been people with student IDs from
1-6. 
*/

DROP DATABASE IF EXISTS SchoolDB;
-- Create database
CREATE DATABASE SchoolDB;

-- Switch to the database
USE SchoolDB;

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    major VARCHAR(100)
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
