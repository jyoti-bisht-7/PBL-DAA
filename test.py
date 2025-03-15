from flask import Flask, render_template, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

# Initialize Flask app
app = Flask(__name__)

# Configure database URI
app.config['SQLALCHEMY_DATABASE_URI'] = r'sqlite:///test.db'
db = SQLAlchemy(app)

# Define the Todo model
class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(200), nullable=False)
    completed = db.Column(db.Integer, default=0)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return f'<Task {self.id}>'

# Create route
@app.route('/')
def index():
    return render_template('index.html')

# ✅ Create the database inside the app context
if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)
