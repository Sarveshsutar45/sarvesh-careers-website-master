from datetime import datetime
import uuid
import os
from flask import Flask, render_template, request, redirect, url_for, flash, jsonify, session,send_from_directory
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['UPLOAD_FOLDER'] = 'pdf'
app.config['ALLOWED_EXTENSIONS'] = {'pdf', 'jpg', 'png'}
app.config['MYSQL_DB'] = 'sarvesh_career_website'
mysql = MySQL(app)
app.secret_key = 'sarveshsutarhatesthelove'
def allowed_file(filename):
        return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']    



@app.route('/')
def hello_sarvesh():
    admin = False
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM jobs")
    result = cursor.fetchall()
    cursor.close()
    jobs = []
    for row in result:
        jobs.append({
            'id': row[0],
            'title': row[1],
            'location': row[2],
            'salary': row[3],
            'currency': row[4]
        })
    return render_template('home.html', jobs=jobs, company_name='SARVESH', admin=admin)


@app.route('/apply', methods=['GET', 'POST'])
def apply():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        resume_file = request.files['resume']
        job_id = request.form['job_id']
        cursor = mysql.connection.cursor()

        # Check if the applicant has already applied for this job
        sql_check_duplicate = "SELECT * FROM job_applications WHERE name = %s AND email = %s AND job_id = %s"
        cursor.execute(sql_check_duplicate, (name, email, job_id))
        result = cursor.fetchone()
        if result:
            flash("You have already applied for this job.")
            cursor.close()
            return redirect(url_for('apply'))

        if resume_file and allowed_file(resume_file.filename):
            resume_filename = secure_filename(resume_file.filename)
            # Generate a unique filename if the file already exists in the database
            while True:
                unique_filename = str(uuid.uuid4()) + resume_filename
                sql_check_filename = "SELECT * FROM job_applications WHERE resume_file = %s"
                cursor.execute(sql_check_filename, (unique_filename,))
                result = cursor.fetchone()
                if not result:
                    break
            
            resume_file.save(os.path.join(app.config['UPLOAD_FOLDER'], unique_filename))
            try:
                sql = "INSERT INTO job_applications (name, email, resume_file, job_id, applied_date) VALUES (%s, %s, %s, %s, %s)"
                applied_date = datetime.now()
                cursor.execute(sql, (name, email, unique_filename, job_id, applied_date))
                mysql.connection.commit()
                flash("Application submitted successfully!")
                cursor.close()
                return redirect(url_for('apply'))
            except:
                flash("Failed to submit the application!")
                cursor.close()
                return redirect(url_for('apply'))
        else:
            flash("Invalid resume file format!")
            return redirect(url_for('apply'))
    else:
        job_id = request.args.get('job_id')
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM jobs WHERE id = %s", (job_id,))
        result = cursor.fetchone()
        cursor.close()
        if result is not None:
            job = {
                'id': result[0],
                'title': result[1],
                'location': result[2],
                'salary': result[3],
                'currency': result[4],
                'responsibilities': result[5],
                'requirements': result[6],
            }
            return render_template('apply.html', job=job)
        else:
            return 'Job not found!'





@app.route('/apis/jobs')
def list_jobs():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM jobs")
    result = cursor.fetchall()
    cursor.close()
    jobs = []
    for row in result:
        jobs.append({
            'id': row[0],
            'title': row[1],
            'location': row[2],
            'salary': row[3],
            'currency': row[4]
        })
    return jsonify({'jobs': jobs})


@app.route('/admin/dashboard')
def admin_dashboard():
    if 'admin_logged_in' in session:
        admin = True
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM jobs")
        result = cursor.fetchall()
        cursor.close()
        jobs = []
        for row in result:
            jobs.append({
                'id': row[0],
                'title': row[1],
                'location': row[2],
                'salary': row[3],
                'currency': row[4]
            })

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT job_applications.id, job_applications.name, job_applications.email, job_applications.resume_file, job_applications.job_id, jobs.title FROM job_applications INNER JOIN jobs ON job_applications.job_id = jobs.id")
        result = cursor.fetchall()
        cursor.close()
        job_applications = []
        for row in result:
            job_applications.append({
                'id': row[0],
                'name': row[1],
                'email': row[2],
                'resume_file': row[3],
                'job_id': row[4],
                'job_title': row[5]
            })

        return render_template('admin.html', jobs=jobs, job_applications=job_applications, admin=admin)
    else:
        return redirect(url_for('admin_login'))
@app.route('/resume/<path:filename>')
def resume_file(filename):
    return send_from_directory('pdf', filename)

@app.route('/admin/add_job', methods=['GET', 'POST'])
def add_job():
    if 'admin_logged_in' in session:
        if request.method == 'POST':
            title = request.form['title']
            location = request.form['location']
            salary = request.form['salary']
            currency = request.form['currency']
            responsibilities = request.form['responsibilities']
            requirements = request.form['requirements']

            if title.strip() == '' or location.strip() == '':
                flash('Please insert all credentials.', 'error')
                return redirect(url_for('add_job'))

            cursor = mysql.connection.cursor()
            cursor.execute("INSERT INTO jobs (title, location, salary, currency, responsibilities, requirements) "
                           "VALUES (%s, %s, %s, %s, %s, %s)",
                           (title, location, salary, currency, responsibilities, requirements))
            mysql.connection.commit()
            cursor.close()

            flash('Job added successfully', 'success')
            return redirect(url_for('add_job'))

        return render_template('add_job.html')
    else:
        return redirect(url_for('admin_login'))


@app.route('/admin/all_jobs', methods=['GET'])
def all_jobs():
    if 'admin_logged_in' in session:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM jobs")
        result = cursor.fetchall()
        cursor.close()
        jobs = []
        for row in result:
            jobs.append({
                'id': row[0],
                'title': row[1],
                'location': row[2],
                'salary': row[3],
                'currency': row[4],
                'responsibilities': row[5],
                'requirements': row[6]
            })
        return render_template('all_jobs.html', jobs=jobs)
    else:
        return redirect(url_for('admin_login'))
    
@app.route('/applicant-jobs/<applicant_email>')
def applicant_jobs(applicant_email):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT jobs.* FROM job_applications INNER JOIN jobs ON job_applications.job_id = jobs.id WHERE job_applications.email = %s", (applicant_email,))
    result = cursor.fetchall()
    cursor.close()

    if result:
        jobs = []
        for row in result:
            job = {
                'id': row[0],
                'title': row[1],
                'location': row[2],
                'salary': row[3],
                'currency': row[4]
            }
            jobs.append(job)

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT name FROM job_applications WHERE email = %s", (applicant_email,))
        applicant_name = cursor.fetchone()[0]
        cursor.close()

        return render_template('applicant_jobs.html', jobs=jobs, applicant_name=applicant_name)
    else:
        return 'Applicant not found!'



@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    if 'admin_logged_in' in session:
        return redirect(url_for('admin_dashboard'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM admins WHERE username = %s", (username,))
        admin_data = cursor.fetchone()
        cursor.close()

        if admin_data and admin_data[2] == password:
            session['admin_logged_in'] = True
            return redirect(url_for('admin_dashboard'))
        else:
            flash('Invalid username or password!')

    return render_template('login.html')


import logging
@app.route('/admin/logout')
def admin_logout():
    session.pop('admin_logged_in', None)
    logging.info('Admin logged out')
    return redirect(url_for('hello_sarvesh')) 


if __name__ == '__main__':
    app.run(debug=True)
