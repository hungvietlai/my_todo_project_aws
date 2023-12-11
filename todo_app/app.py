from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///todos.db'
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
