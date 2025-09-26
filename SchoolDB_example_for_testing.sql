/*
This database is for use with the demo portion of this assignment. 
Running this DB in mysql will output the instructions in the 
"Queries" portion of this code.
*/

DROP DATABASE IF EXISTS SchoolDB;
-- Create database
CREATE DATABASE SchoolDB;

-- Switch to the database
USE SchoolDB;

-- Drop table if they exist to ensure proper ID numbering
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

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

-- Insert sample students
INSERT INTO Students (student_id, name, age, major) VALUES
(1, 'Luanne Plemmons', 21, 'Computer Engineering'),
(2, 'Lizzie Long', 21, 'Computer Engineering'),
(3, 'Michael Dye', 21, 'Computer Engineering'),
(4, 'Mikayla Hubbard', 21, 'Coding and App Development'),
(5, 'Jane Doe', 20, 'Electrical Engineering'),
(6, 'John Doe', 18, 'Forensics Engineering');

-- Insert sample courses
INSERT INTO Courses (course_id, course_name, credits) VALUES
(101, 'ENCE 410 VLSI Design', 3),
(102, 'Calculus II', 4),
(103, 'ENCE 420 Software Engineering', 3);

-- Insert sample enrollments
INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 101, 'A'),
(2, 101, 'A'),
(3, 102, 'A'),
(4, 103, 'A'),
(5, 102, 'B'),
(6, 102, 'D');


-- Queries

-- 1. Retrieve all students (& courses)
SELECT * FROM Students;
SELECT * FROM Courses;

-- 2. Retrieve students older than 20.
SELECT * FROM Students
WHERE age > 20;

-- 3. Retrieve all courses with credits greater than 3.
SELECT * FROM Courses
WHERE credits > 3;

-- Enrollment QUERIES
-- 1. List all students with the courses they are enrolled in.
SELECT s.name AS student_name, c.course_name, e.grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 2. Show all students who got grade 'A' in any course
SELECT s.name AS student_name, c.course_name
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.grade = 'A';
-- So John Doe and Jane Doe will not show up in this table because
-- they did not get 'A's

-- 3. Count how many students are enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
