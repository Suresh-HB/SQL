'''

@Author: Suresh 
@Date: 2024-08-24
@Last Modified by: Suresh
@Last Modified: 2024-08-24
@Title : CRUD operations in python

'''

import pyodbc
import os
from dotenv import load_dotenv

load_dotenv()

class EmployeeDatabase:

    def __init__(self):
        self.connection = self.get_connection()

    def get_connection(self):
        """
        Description: Establishes a connection to the SQL Server database using pyodbc.
        Parameter:
            self: Instance of the class    
        Return:
            pyodbc.Connection: The connection object to interact with the SQL Server database.
        """
        try:
            conn = pyodbc.connect(
                f'DRIVER={os.getenv("Driver")};'
                f'SERVER={os.getenv("Server")};'
                f'DATABASE={os.getenv("Database")};'
                f'Trusted_Connection={os.getenv("Trusted_Connection")}'
            )
            return conn
        except Exception as e:
            print(f"Error connecting to database: {e}")
            return None

    def create_tables(self):
        """
        Description: Creates the Department and Employee tables in the database if they do not exist.
        Parameter:
            self: Instance of the class
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()

            department_table = """
            IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Department')
            CREATE TABLE Department (
                DepartmentID INT PRIMARY KEY IDENTITY(1,1),
                DepartmentName NVARCHAR(100) NOT NULL
            )
            """
            
            employee_table = """
            IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Employee')
            CREATE TABLE Employee (
                EmployeeID INT PRIMARY KEY IDENTITY(1,1),
                FirstName NVARCHAR(50) NOT NULL,
                LastName NVARCHAR(50) NOT NULL,
                Age INT,
                Email NVARCHAR(100),
                DepartmentID INT,
                FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
            )
            """
           
            cursor.execute(department_table)
            cursor.execute(employee_table)
            self.connection.commit()
            print("Tables created successfully.")
        except Exception as e:
            print(f"Error creating tables: {e}")

    def create_employee(self, first_name, last_name, age, department_id):
        """
        Description: Inserts a new employee into the Employee table.

        Parameter:
            self: Instance of the class
            first_name : str
                The first name of the employee.
            last_name : str
                The last name of the employee.
            age : int
                The age of the employee.
            department_id : int
                The ID of the department the employee belongs to.
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute(
                "INSERT INTO Employee (FirstName, LastName, Age, DepartmentID) VALUES (?, ?, ?, ?)",
                (first_name, last_name, age, department_id)
            )
            self.connection.commit()
            print(f"Employee {first_name} {last_name} added successfully.")
        except Exception as e:
            print(f"Error adding employee: {e}")

    def create_department(self, department_name):
        """
        Description: Inserts a new department into the Department table.

        Parameter:
            self: Instance of the class
            department_name : str
                The name of the department.
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute(
                "INSERT INTO Department (DepartmentName) VALUES (?)",
                (department_name,)
            )
            self.connection.commit()
            print(f"Department '{department_name}' added successfully.")
        except Exception as e:
            print(f"Error adding department: {e}")

    def read_employee(self, employee_id):
        """
        Description: Fetches and displays the details of an employee based on their EmployeeID.
        Parameters:
            self: Instance of the class
            employee_id : int
                The ID of the employee to be retrieved.
        Returns:
            None
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT * FROM Employee WHERE EmployeeID = ?", (employee_id,))
            row = cursor.fetchone()
            if row:
                print(f"Employee ID: {row.EmployeeID}, Name: {row.FirstName} {row.LastName}, Age: {row.Age}, DepartmentID: {row.DepartmentID}, Email: {row.Email}")
            else:
                print("Employee not found.")
        except Exception as e:
            print(f"Error reading employee: {e}")

    def update_employee(self, employee_id, first_name=None, last_name=None, age=None, department_id=None, email=None):
        """
        Description: Updates the details of an employee in the Employee table.
        Parameters:
            self: Instance of the class
            employee_id : int
                The ID of the employee to be updated.
            first_name : str, optional
                The new first name of the employee (default is None).
            last_name : str, optional
                The new last name of the employee (default is None).
            age : int, optional
                The new age of the employee (default is None).
            department_id : int, optional
                The new department ID of the employee (default is None).
            email : str, optional
                The new email address of the employee (default is None).
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()
            update_statement = "UPDATE Employee SET "
            parameters = []
            if first_name:
                update_statement += "FirstName = ?, "
                parameters.append(first_name)
            if last_name:
                update_statement += "LastName = ?, "
                parameters.append(last_name)
            if age:
                update_statement += "Age = ?, "
                parameters.append(age)
            if department_id:
                update_statement += "DepartmentID = ?, "
                parameters.append(department_id)
            if email:
                update_statement += "Email = ?, "
                parameters.append(email)

            update_statement = update_statement.rstrip(", ")
            update_statement += " WHERE EmployeeID = ?"
            parameters.append(employee_id)
            
            cursor.execute(update_statement, parameters)
            self.connection.commit()
            print(f"Employee ID {employee_id} updated successfully.")
        except Exception as e:
            print(f"Error updating employee: {e}")

    def read_department(self, department_id):
        """
        Description: Fetches and displays the details of a department based on its DepartmentID.
        Parameter:
            self: Instance of the class
            department_id : int
                The ID of the department to be retrieved.
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT * FROM Department WHERE DepartmentID = ?", (department_id,))
            row = cursor.fetchone()
            if row:
                print(f"Department ID: {row.DepartmentID}, Name: {row.DepartmentName}")
            else:
                print("Department not found.")
        except Exception as e:
            print(f"Error reading department: {e}")

    def delete_employee(self, employee_id):
        """
        Description: Deletes an employee from the Employee table based on their EmployeeID.
        Parameters:
            self: Instance of the class        
            employee_id : int
                The ID of the employee to be deleted.
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()
            # Check if employee exists
            cursor.execute("SELECT * FROM Employee WHERE EmployeeID = ?", (employee_id,))
            if cursor.fetchone():
                cursor.execute("DELETE FROM Employee WHERE EmployeeID = ?", (employee_id,))
                self.connection.commit()
                print(f"Employee ID {employee_id} deleted successfully.")
            else:
                print(f"Employee ID {employee_id} does not exist.")
        except Exception as e:
            print(f"Error deleting employee: {e}")

    def delete_department(self, department_id):
        """
        Description: Deletes a department from the Department table based on its DepartmentID.
        Parameter:
            self: Instance of the class
            department_id : int
                The ID of the department to be deleted.
        Return:
            None
        """
        try:
            cursor = self.connection.cursor()
            # Check if department exists
            cursor.execute("SELECT * FROM Department WHERE DepartmentID = ?", (department_id,))
            if cursor.fetchone():
                cursor.execute("DELETE FROM Department WHERE DepartmentID = ?", (department_id,))
                self.connection.commit()
                print(f"Department ID {department_id} deleted successfully.")
            else:
                print(f"Department ID {department_id} does not exist.")
        except Exception as e:
            print(f"Error deleting department: {e}")

    def close_connection(self):
        """
        Description: Closes the database connection.
        Parameter:
            self: Instance of the class
        Returns:
            None
        """
        if self.connection:
            self.connection.close()
            print("Database connection closed.")

    def display_all_employees(self):
        """
        Description: Displays all employees from the Employee table.
        Parameter:
            self: Instance of the class
        Returns:
            None
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT * FROM Employee")
            rows = cursor.fetchall()
            if not rows:
                print("Table is empty.")
            for row in rows:
                print(f"Employee ID: {row.EmployeeID}, Name: {row.FirstName} {row.LastName}, Age: {row.Age}, DepartmentID: {row.DepartmentID}, Email: {row.Email}")
        except Exception as e:
            print(f"Error displaying employees: {e}")

    def display_all_departments(self):
        """
        Description: Displays all departments from the Department table.
        Parameter:
            self: Instance of the class
        Returns:
            None
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT * FROM Department")
            rows = cursor.fetchall()
            if not rows:
                print("Table is empty.")
            for row in rows:
                print(f"Department ID: {row.DepartmentID}, Name: {row.DepartmentName}")
        except Exception as e:
            print(f"Error displaying departments: {e}")

def main():
    db = EmployeeDatabase()
    db.create_tables()

    while True:
        try:
            print("\nChoose an operation:")
            print("1. Create Employee")
            print("2. Read Employee")
            print("3. Create Department")
            print("4. Update Employee")
            print("5. Delete Employee")
            print("6. Delete Department")
            print("7. Display All Departments")
            print("8. Display All Employees")
            print("9. Read Department")
            print("10. Exit")
            
            choice = input("Enter your choice (1-10): ")

            match choice:
                case '1':
                    first_name = input("Enter first name: ")
                    last_name = input("Enter last name: ")
                    age = int(input("Enter age: "))
                    department_id = int(input("Enter department ID: "))
                    db.create_employee(first_name, last_name, age, department_id)

                case '2':
                    employee_id = int(input("Enter employee ID: "))
                    db.read_employee(employee_id)

                case '3':
                    department_name = input("Enter department name: ").upper()
                    db.create_department(department_name)

                case '4':
                    employee_id = int(input("Enter employee ID: "))
                    first_name = input("Enter new first name (leave blank to keep current): ") or None
                    last_name = input("Enter new last name (leave blank to keep current): ") or None
                    age = input("Enter new age (leave blank to keep current): ")
                    age = int(age) if age else None
                    department_id = input("Enter new department ID (leave blank to keep current): ")
                    department_id = int(department_id) if department_id else None
                    email = input("Enter new email (leave blank to keep current): ") or None
                    db.update_employee(employee_id, first_name, last_name, age, department_id, email)

                case '5':
                    employee_id = int(input("Enter employee ID: "))
                    db.delete_employee(employee_id)

                case '6':
                    department_id = int(input("Enter department ID: "))
                    db.delete_department(department_id)

                case '7':
                    db.display_all_departments()

                case '8':
                    db.display_all_employees()

                case '9':
                    department_id = int(input("Enter department ID: "))
                    db.read_department(department_id)

                case '10':
                    db.close_connection()
                    break

                case _:
                    print("Invalid choice. Please select a number between 1 and 10.")
        
        except ValueError as e:
            print(f"ValueError: {e}, please enter a valid integer.")
        except Exception as e:
            print(f"Unexpected error: {e}")

if __name__ == "__main__":
    main()
