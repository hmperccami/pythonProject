import requests
import os

# Current working directory
cwd = os.getcwd()

file1 = cwd + r'\input\departments.csv'
file2 = cwd + r'\input\jobs.csv'
file3 = cwd + r'\input\hired_employees.csv'

# Define the URL of your local API
url = 'http://127.0.0.1:5000/upload'

file_paths = [
    (file1, 'departments', ["id", "department"]),
    (file2, 'jobs', ["id", "job"]),
    (file3, 'hired_employees', ["id", "name", "datetime", "department_id", "job_id"])
]

# Create a list of files, associated table names, and additional data
files = [(file_path, table_name, data) for file_path, table_name, data in file_paths]

# Send a single POST request to upload the CSV files with table names and additional data
data = {
    'files': files
}

response = requests.post(url, json=data)

# Print the response
print(response.status_code)
print(response.json())