// import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

List<ToDo> globalTodos = [
  ToDo(title: "thingy", isDone: false, description: "a thing to do"),
  ToDo(title: "another", isDone: false, description: "a second thing todo")
];

// var db = Db("mongodb://localhost:27017");
// var todoCollection = db.collection("todos");

class ToDo {
  String title;
  bool isDone;
  String description;
  String id;

  ToDo({
    required this.title,
    required this.isDone,
    required this.description,
  }) : id = createRandomID(20);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isDone": isDone,
      "description": description,
      "id": id,
    };
  }

  void postTodo() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/todos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(toJson()),
      );
      if (response.statusCode == 200) {
        print("success");
      } else {
        print("failed");
      }
    } catch (e) {
      print(e);
    }
  }

  static String createRandomID(int size) {
    var rand = Random();
    String randomID = "";
    for (int i = 0; i < size; i++) {
      randomID += (rand.nextInt(10)).toString();
    }
    return randomID;
  }

  static List<ToDo> getTodos() {
    // List<ToDo> todos = [];
    //we call mongodb and get todos
    //from collection, and then parse and get all;
    return globalTodos;
  }

  static void addTodo(ToDo value) {
    //we call mongodb and add todo
    //to collection

    globalTodos.add(value);
  }

  static void deleteTodo(ToDo value) {
    //we call mongodb and delete todo
    //from collection
    globalTodos.remove(value);
  }

  static void updateTodo(ToDo value) {
    //we call mongodb and update todo
    //in collection
    for (int i = 0; i < globalTodos.length; i++) {
      if (globalTodos[i].id == value.id) {
        globalTodos[i] = value;
      }
    }
    //we simply send the request to the server
  }

  void setDone() {
    isDone = true;
    updateTodo(this);
  }

  void setNotDone() {
    isDone = false;
    updateTodo(this);
  }
}
