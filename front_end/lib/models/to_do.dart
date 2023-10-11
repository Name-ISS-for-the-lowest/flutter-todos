// import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

List<ToDo> globalTodos = [];

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
    this.id = "",
  }) {
    if (id == "") {
      id = createRandomID(10);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isDone": isDone,
      "description": description,
      "id": id,
    };
  }

  // void postTodo() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://10.0.2.2:5000/addTodo'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(toJson()),
  //     );
  //     if (response.statusCode == 200) {
  //       print("success");
  //     } else {
  //       print("failed");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static String createRandomID(int size) {
    var rand = Random();
    String randomID = "";
    for (int i = 0; i < size; i++) {
      randomID += (rand.nextInt(10)).toString();
    }
    return randomID;
  }

  static Future<List<ToDo>> getTodos() async {
    try {
      await http.get(
        Uri.parse('http://10.0.2.2:5000/getTodos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((value) {
        var data = jsonDecode(value.body);
        globalTodos = [];
        for (var todo in data) {
          globalTodos.add(ToDo(
            title: todo["title"],
            isDone: todo["isDone"],
            description: todo["description"],
            id: todo["id"],
          ));
        }
      });
    } catch (e) {
      print(e);
    }
    return globalTodos;
  }

  static Future<void> addTodo(ToDo value) async {
    //we call mongodb and add todo
    //to collection
    try {
      await http.post(
        Uri.parse('http://10.0.2.2:5000/addTodo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(value.toJson()),
      );
    } catch (e) {
      print(e);
    }

    globalTodos.add(value);
  }

  static Future<void> deleteTodo(ToDo value) async {
    //we call mongodb and delete todo
    //from collection
    try {
      await http.post(
        Uri.parse('http://10.0.2.2:5000/deleteTodo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(value.toJson()),
      );
    } catch (e) {
      print(e);
    }

    globalTodos.remove(value);
  }

  static Future<void> updateTodo(ToDo value) async {
    //we call mongodb and update todo
    //in collection
    try {
      await http.post(
        Uri.parse('http://10.0.2.2:5000/updateTodo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(value.toJson()),
      );
    } catch (e) {
      print(e);
    }
    //we simply send the request to the server
  }

  void setDone() {
    isDone = true;
  }

  void setNotDone() {
    isDone = false;
  }
}
