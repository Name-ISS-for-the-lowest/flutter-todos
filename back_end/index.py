from flask import Flask, request
import json


app = Flask(__name__)

@app.route('/addTodo', methods=['GET', 'POST'])
# here I need to add the todo to the database
def addTodo():
    if request.method == 'POST':
        try:
            data = json.loads(request.data)  # Parse JSON data from the request body
            #add todo to the database here
        except json.JSONDecodeError as e:
            return f'Error parsing JSON: {str(e)}'
        
@app.route('/getTodos', methods=['GET'])
#return all todos from the database
def getTodos():
    #get todos from the database here
    return "todos"


@app.route('/deleteTodo', methods=['GET', 'POST'])
#delete todo from the database
def deleteTodo():
    if request.method == 'POST':
        try:
            data = json.loads(request.data)  # Parse JSON data from the request body
            #delete todo from the database here
        except json.JSONDecodeError as e:
            return f'Error parsing JSON: {str(e)}'

if __name__ == '__main__':
    app.run()