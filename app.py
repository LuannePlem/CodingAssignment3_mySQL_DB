import mysql.connector
import time as t

# ------------------------------
# Connect to MySQL Database
# ------------------------------
def connect_db():
    return mysql.connector.connect(
        host="localhost",       # or your MySQL server IP
        user="root",            # change if you have another user
        password="a1b2SQL04!!",  # <-- replace with your MySQL password
        database="SchoolDB"
    )

# ------------------------------
# Add a new student
# ------------------------------
def add_student():
    conn = connect_db()
    cursor = conn.cursor()
    name = input("Enter student name: ")
    age = int(input("Enter student age: "))
    major = input("Enter student major: ")

    sql = "INSERT INTO Students (name, age, major, student_id) VALUES (%s, %s, %s, NULL)"
    # Better: let MySQL auto-increment IDs if you adjust schema. For now, manually increment.
    cursor.execute("SELECT IFNULL(MAX(student_id), 0) + 1 FROM Students")
    new_id = cursor.fetchone()[0]

    sql = "INSERT INTO Students (student_id, name, age, major) VALUES (%s, %s, %s, %s)"
    values = (new_id, name, age, major)
    cursor.execute(sql, values)

    conn.commit()
    print(f"Student '{name}' added with ID {new_id}")
    cursor.close()
    conn.close()

# ------------------------------
# Add a new course
# ------------------------------
def add_course():
    conn = connect_db()
    cursor = conn.cursor()
    course_name = input("Enter course name: ")
    credits = int(input("Enter course credits: "))

    cursor.execute("SELECT IFNULL(MAX(course_id), 100) + 1 FROM Courses")
    new_id = cursor.fetchone()[0]

    sql = "INSERT INTO Courses (course_id, course_name, credits) VALUES (%s, %s, %s)"
    values = (new_id, course_name, credits)
    cursor.execute(sql, values)

    conn.commit()
    print(f"Course '{course_name}' added with ID {new_id}")
    cursor.close()
    conn.close()

# ------------------------------
# Enroll a student in a course
# ------------------------------
def enroll_student():
    conn = connect_db()
    cursor = conn.cursor()
    student_id = int(input("Enter student ID: "))
    course_id = int(input("Enter course ID: "))
    grade = input("Enter grade (A-F): ")

    sql = "INSERT INTO Enrollments (student_id, course_id, grade) VALUES (%s, %s, %s)"
    values = (student_id, course_id, grade)
    try:
        cursor.execute(sql, values)
        conn.commit()
        print(f"Student {student_id} enrolled in Course {course_id} with grade {grade}")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()
        conn.close()

# ------------------------------
# Show all courses for a student
# ------------------------------
def show_enrollments():
    conn = connect_db()
    cursor = conn.cursor()
    student_id = int(input("Enter student ID: "))

    sql = """
    SELECT s.name, c.course_name, e.grade
    FROM Enrollments e
    JOIN Students s ON e.student_id = s.student_id
    JOIN Courses c ON e.course_id = c.course_id
    WHERE s.student_id = %s
    """
    cursor.execute(sql, (student_id,))
    results = cursor.fetchall()

    if results:
        print("\n--- Enrollments ---")
        for row in results:
            print(f"Student: {row[0]} | Course: {row[1]} | Grade: {row[2]}")
    else:
        print("No enrollments found for this student.")

    cursor.close()
    conn.close()

# ------------------------------
# Main Menu
# ------------------------------
def menu():
    while True:
        print("\n===== Student-Course Management System =====")
        print("1. Add Student")
        print("2. Add Course")
        print("3. Enroll Student in Course")
        print("4. Show Student’s Enrollments")
        print("5. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            add_student()
        elif choice == '2':
            add_course()
        elif choice == '3':
            enroll_student()
        elif choice == '4':
            show_enrollments()
        elif choice == '5':
            print("Exiting...")
            t.sleep(1)
            print("Done!")
            break
        else:
            print("Invalid choice, please try again.")

# ------------------------------
# Run program
# ------------------------------
if __name__ == "__main__":
    menu()
