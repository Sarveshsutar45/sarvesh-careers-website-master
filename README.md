# Flask App README

This README provides an overview of the Flask application and its functionality.

## Description

The Flask application is designed to handle job applications and display a list of available jobs. It utilizes a MySQL database to store job details and accept job applications from users. Users can submit their name, email, and resume file in PDF format for a specific job. The application also provides API endpoints to retrieve job information in JSON format.

## Requirements

To run the Flask application, make sure you have the following components installed:

- Python (version 3.6 or higher)
- Flask framework
- Flask-MySQLdb extension

Install the required packages by running the following command:

```bash
pip install Flask Flask-MySQLdb
```

## Configuration

In the Flask application code, you can configure the following settings:

- MySQL database connection settings:
  - `MYSQL_HOST`: The hostname or IP address of the MySQL server.
  - `MYSQL_USER`: The MySQL database username.
  - `MYSQL_PASSWORD`: The MySQL database password.
  - `MYSQL_DB`: The name of the MySQL database.

- File upload settings:
  - `UPLOAD_FOLDER`: The folder where uploaded PDF files will be stored. Update this path to your desired folder location.

## Running the Application

To run the Flask application, execute the following command in the application's directory:

```bash
python <filename>.py
```

Replace `<filename>` with the name of the Python file containing the Flask application code.

The application will be accessible at `http://localhost:5000/`.

## Routes

The Flask application provides the following routes:

- `/apply` (GET, POST): Accepts job applications. Renders an application form for a specific job (GET) and processes the submitted application (POST).

- `/` (GET): Displays the homepage with a list of available jobs.

- `/apis/jobs` (GET): Retrieves a list of jobs in JSON format.

## Database Schema

The application utilizes a MySQL database with the following schema:

```sql
CREATE TABLE jobs (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  salary INT NOT NULL,
  currency VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE job_applications (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  resume_file VARCHAR(255) NOT NULL,
  job_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (job_id) REFERENCES jobs(id)
);
```

The `jobs` table stores information about available jobs, while the `job_applications` table stores submitted job applications.

## Templates

The Flask application uses HTML templates to render the user interface. The following templates are included:

- `apply.html`: Renders the job application form.
- `home.html`: Renders the homepage with a list of jobs.

Feel free to customize the templates according to your specific requirements.

## Conclusion

This Flask application provides a simple job application system with file upload functionality. You can extend and modify the code to fit your specific needs. Happy coding!
