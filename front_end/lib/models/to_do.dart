List<ToDo> globalTodos = [
  ToDo(title: "thingy", isDone: false, description: "a thing to do"),
  ToDo(title: "another", isDone: false, description: "a second thing todo")
];

class ToDo {
  String title;
  bool isDone;
  String description;
  String id;

  ToDo({
    required this.title,
    required this.isDone,
    required this.description,
  }) : id = createRandomID(10);

  static String createRandomID(int size) {
    String randomID = "";
    for (int i = 0; i < size; i++) {
      randomID += (i + 1).toString();
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
  }

  void setDone() {
    isDone = true;
  }

  void setNotDone() {
    isDone = false;
  }
}
