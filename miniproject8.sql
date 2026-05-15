----------- ONLINE EXAMINATION SYSTEN ----------

-- 📌 Objective - Manage students, exams, and scores.

-- to create database named project
CREATE DATABASE PROJECT;

-- to use database
USE PROJECT;

-- to create students, exams, questions and result table

CREATE TABLE STUD(
STUDENT_ID INT,
STUDENT_NAME VARCHAR(50),
COURSE VARCHAR(50),
CITY VARCHAR(50)
);

CREATE TABLE EXAMS(
EXAM_ID INT,
SUBJECT_NAME VARCHAR(50),
EXAM_DATE DATE,
TOTAL_MARKS INT
);

CREATE TABLE QUESTION(
OUESTION_ID INT,
EXAM_ID INT,
QUESTION_TEXT VARCHAR(100),
MARKS INT
);

CREATE TABLE RESULT(
RESULT_ID INT,
STUDENT_ID INT,
EXAM_ID INT,
OBTAINED_MARKS INT,
PERCENTAGE FLOAT,
STATUS VARCHAR(50)
);

-- to insert values in this tables
INSERT INTo STUD VALUES
(1, 'Amit', 'BCA', 'Mumbai'),
(2, 'Neha', 'BCA', 'Pune'),
(3, 'Raj', 'BSc IT', 'Delhi'),
(4, 'Sneha', 'BSc IT', 'Bangalore'),
(5, 'Arjun', 'BCA', 'Chennai');

INSERT INTO Exams VALUES
(101, 'SQL', '2024-04-10', 100),
(102, 'Python', '2024-04-15', 100),
(103, 'DBMS', '2024-04-20', 100);

INSERT INTO Question VALUES
(1, 101, 'What is SQL?', 10),
(2, 101, 'Explain JOIN types', 15),
(3, 101, 'Difference between WHERE and HAVING', 10),
(4, 102, 'Explain Python Lists', 10),
(5, 102, 'What is Tuple?', 10),
(6, 103, 'What is Normalization?', 15),
(7, 103, 'Explain Primary Key', 10);

INSERT INTO Result VALUES
(1, 1, 101, 85, 85.00, 'Pass'),
(2, 2, 101, 72, 72.00, 'Pass'),
(3, 3, 101, 35, 35.00, 'Fail'),
(4, 4, 101, 91, 91.00, 'Pass'),
(5, 5, 101, 60, 60.00, 'Pass'),

(6, 1, 102, 88, 88.00, 'Pass'),
(7, 2, 102, 45, 45.00, 'Pass'),
(8, 3, 102, 30, 30.00, 'Fail'),
(9, 4, 102, 95, 95.00, 'Pass'),
(10, 5, 102, 55, 55.00, 'Pass'),

(11, 1, 103, 78, 78.00, 'Pass'),
(12, 2, 103, 66, 66.00, 'Pass'),
(13, 3, 103, 40, 40.00, 'Pass'),
(14, 4, 103, 89, 89.00, 'Pass'),
(15, 5, 103, 50, 50.00, 'Pass');

-- to slove important queries

-- 1. top scores
SELECT STUDENT_NAME, SUBJECT_NAME, OBTAINED_MARKS
FROM STUD AS S
INNER JOIN  RESULT AS R
ON S.STUDENT_ID = R.STUDENT_ID
INNER JOIN EXAMS AS E
ON E.EXAM_ID = R.EXAM_ID
ORDER BY OBTAINED_MARKS DESC;

-- 2. suject wise average score
SELECT SUBJECT_NAME, AVG(OBTAINED_MARKS) AS AVG_MARKS
FROM EXAMS AS E
INNER JOIN RESULT AS R
ON E.EXAM_ID = R.EXAM_ID
GROUP BY SUBJECT_NAME
ORDER BY AVG_MARKS;

-- 3. pass/fail analysis
SELECT STATUS, COUNT(*) AS TOTAL_STUDENT
FROM RESULT 
GROUP BY STATUS;

-- 4. average score of all student
SELECT AVG(OBTAINED_MARKS) FROM RESULT;

-- 5. highest marks in each subject
SELECT SUBJECT_NAME, MAX(OBTAINED_MARKS) AS HIGHEST_MARKS
FROM EXAMS AS E
INNER JOIN RESULT AS R
ON E.EXAM_ID = R.EXAM_ID
GROUP BY SUBJECT_NAME
ORDER BY HIGHEST_MARKS;

-- 6. student who failed
SELECT STUDENT_NAME, SUBJECT_NAME, OBTAINED_MARKS
FROM STUD AS S
INNER JOIN RESULT AS R
ON S.STUDENT_ID = R.STUDENT_ID
INNER JOIN EXAMS AS E
ON E.EXAM_ID = R.EXAM_ID
WHERE STATUS = 'FAIL';

-- 7. store procedure for student performance
CREATE PROCEDURE GETSTUDENTPERFORMANCE
AS
BEGIN
    SELECT STUDENT_NAME, SUBJECT_NAME, OBTAINED_MARKS 
    FROM STUD AS S
    INNER JOIN RESULT AS R
    ON S.STUDENT_ID = R.STUDENT_ID
    INNER JOIN EXAMS AS E
    ON E.EXAM_ID = R.EXAM_ID
END;

EXEC GETSTUDENTPERFORMANCE;

-- 8. trigger atuomatically assign pass/fail before inserting
CREATE TRIGGER RESULT_STATUS_TRIGGER
ON RESULT 
INSTEAD OF INSERT
AS
BEGIN 
    INSERT INTO RESULT 
    (STUDENT_ID, EXAM_ID, OBTAINED_MARKS, STATUS)
    SELECT STUDENT_ID, EXAM_ID, OBTAINED_MARKS,
        CASE
            WHEN OBTAINED_MARKS >= 40 THEN 'PASS'
            ELSE 'FAIL'
        END
    FROM INSERTED;

    -- display the inserted record
    SELECT STUDENT_ID, EXAM_ID, OBTAINED_MARKS,
        CASE
            WHEN OBTAINED_MARKS >= 40 THEN 'PASS'
            ELSE 'FAIL'
        END
    FROM INSERTED
END;


INSERT INTO Result(student_id, obtained_marks)
VALUES (20, 30);

INSERT INTO Result(student_id, obtained_marks)
VALUES (18, 30);

SELECT * FROM RESULT


