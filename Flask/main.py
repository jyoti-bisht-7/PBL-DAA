from flask import Flask,render_template,url_for,redirect
from datetime import datetime#importing libraries
# render_template to create a web app and render HTML templates
from flask_sqlalchemy import SQLAlchemy
from flask import request

app=Flask(__name__) # Create an instance of the Flask class (represents web application)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://flaskuser:password@localhost/testdb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db=SQLAlchemy(app)

class Todo(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    content=db.Column(db.String(200),nullable=False)
    completed=db.Column(db.Integer,default=0)
    date_created=db.Column(db.DateTime,default=datetime.utcnow) 
    
    def __repr__(self):
        return '<Task %r>' % self.id
    
@app.route('/',methods=['POST','GET']) #define a route for the root URL ('/) - when accessed, it will trigger the index function

def index():
    if request.method == 'POST':
        task_content=request.form['content']
        new_task=Todo(content=task_content)
        try:
            db.session.add(new_task)
            db.session.commit()
            return redirect('/')
        except:
            return 'There was an issue adding your task'
    else :
        tasks=Todo.query.order_by(Todo.date_created).all()
        return render_template('index.html',tasks=tasks) #render the HTML template  
 
@app.route('/delete/<int:id>')

def delete(id):
    task_to_delete=Todo.query.get_or_404(id)
    try:
        db.session.delete(task_to_delete)
        db.session.commit()
        return redirect('/')
    except:
        return 'There was a problem deleting the task'
        
@app.route('/update/<int:id>',methods=['GET','POST'])
def update(id):
    task=Todo.query.get_or_404(id)
    if request.method=='POST':
        task.content=request.form['content']
        try:
            db.session.commit()
            return redirect('/')
        except:
            return 'There was an issue updating your task'
    else:
        return render_template('update.html',task=task)
        
    
if __name__=="__main__": #ensure the app runs oly if this script is executed directly 
    with app.app_context():# Create the database inside the app context
        db.create_all()
    app.run(debug=True) #start the Flask development server with debugging enabled (auto reloads on code changes)
