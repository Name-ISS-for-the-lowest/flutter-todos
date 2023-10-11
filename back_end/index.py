from flask import Flask, request
import json
import pymongo


host = "localhost"
port = 27017
database = "todos"
client = pymongo.MongoClient(host, port)
db = client[database]
todosCollection = db["todos"]


app = Flask(__name__)

@app.route('/addTodo', methods=['GET', 'POST'])
# here I need to add the todo to the database
def addTodo():
    if request.method == 'POST':
        try:
            data = json.loads(request.data) # Parse JSON data from the request body
            print(data)
            #before inserting check if todo already exists
            #if it does do not insert
            check = todosCollection.find_one({"id": data["id"]})
            print("here is the check", check)
            if check:
                print("todo already exists")
                return "todo already exists"
            result = todosCollection.insert_one(data)
            print(f"Inserted todo with id: {result.inserted_id}")
            return "data"
            #add todo to the database here
        except json.JSONDecodeError as e:
            return f'Error parsing JSON: {str(e)}'
        

@app.route('/getTodos', methods=['GET'])
#return all todos from the database
def getTodos():
    #get todos from the database here
    cursor = todosCollection.find()
    results = []
    for document in cursor:
        results.append(document)
    json_results = json.dumps(results, default=str)
    print(json_results)
    #send back the todos as a json
    # return json.dumps(resut)
    return json_results


@app.route('/deleteTodo', methods=['GET', 'POST'])
#delete todo from the database
def deleteTodo():
    if request.method == 'POST':
        try:
            data = json.loads(request.data)# Parse JSON data from the request body
            print("request data", data)
            result = todosCollection.delete_one({"id": data["id"]})
            
            print(f"Deleted count: {result.deleted_count}")
            return "success"
            #delete todo from the database here
        except json.JSONDecodeError as e:
            return f'Error parsing JSON: {str(e)}'
    else :
        return "must be a post request"

@app.route('/updateTodo', methods=['GET', 'POST'])
#update todo from the database
def updateTodo():
    if request.method == 'POST':
        try:
            data = json.loads(request.data)# Parse JSON data from the request body
            print("request data", data)
            result = todosCollection.update_one({"id": data["id"]}, {"$set": {"isDone": data["isDone"]}})
            
            print(f"Updated count: {result.modified_count}")
            return "success"
            #delete todo from the database here
        except json.JSONDecodeError as e:
            return f'Error parsing JSON: {str(e)}'
    else :
        return "must be a post request"

if __name__ == '__main__':
    app.run()