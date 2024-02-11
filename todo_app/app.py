from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import os
import json

app = Flask(__name__)

credentials_path = '/etc/secrets/db_credentials.json'

def load_db_credentials(path):
    with open(path) as f:
        return json.load(f)

if os.path.exists(credentials_path):
    creds = load_db_credentials(credentials_path)
    db_user = creds.get('username')
    db_pass = creds.get('password')
    db_host = creds.get('host')
    db_name = creds.get('dbname')
    app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{db_user}:{db_pass}@{db_host}/{db_name}"
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URI', 'sqlite:///todos.db')

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    task = db.Column(db.String(200), nullable=False)
    completed = db.Column(db.Boolean, default=False)

@app.route('/')
def index():
    todos = Todo.query.all()
    return render_template('index.html', todos=todos, enumerate=enumerate)

@app.route('/add', methods=['POST'])
def add():
    task = request.form.get('task')
    if task:
        new_todo = Todo(task=task)
        db.session.add(new_todo)
        db.session.commit()
    return redirect(url_for('index'))

@app.route('/delete/<int:task_id>')
def delete(task_id):
    todo = Todo.query.get_or_404(task_id)
    db.session.delete(todo)
    db.session.commit()
    return redirect(url_for('index'))

@app.route('/complete/<int:task_id>')
def complete(task_id):
    todo = Todo.query.get_or_404(task_id)
    todo.completed = True
    db.session.commit()
    return redirect(url_for('index'))

# Create the initial database
with app.app_context():
    db.create_all()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
