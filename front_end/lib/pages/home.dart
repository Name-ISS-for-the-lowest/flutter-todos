import 'package:flutter/material.dart';
import 'package:flutter_to_do/models/to_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todos = ToDo.getTodos();

  String toDoTittle = "";
  String toDoDescription = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController toDoDescriptionController = TextEditingController();
    TextEditingController toDoTitleController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: ListView(
          children: [
            // Column(
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //       child: TextField(
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(),
            //           hintText: 'Insert To-Do title',
            //         ),
            //         onChanged: (String value) async {
            //           toDoTittle = value;
            //           // print(value);
            //         },
            //         onSubmitted: (String value) async {
            //           toDoTittle = value;
            //         },
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //       child: TextField(
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(),
            //           hintText: 'Insert To-Do Description',
            //         ),
            //         onChanged: (String value) async {
            //           toDoDescription = value;
            //           // print(value);
            //         },
            //         onSubmitted: (String value) async {
            //           toDoDescription = value;
            //         },
            //       ),
            //     )
            //   ],
            // ),
            Form(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //this is the input field for the to-do title
                  child: TextFormField(
                    controller: toDoTitleController,
                    decoration:
                        const InputDecoration(hintText: 'Insert to-do title'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) async {
                      toDoTittle = value;
                    },
                    onChanged: (value) async {
                      toDoTittle = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //this is the input field for the todo description
                  child: TextFormField(
                    controller: toDoDescriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Insert to-do description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String value) async {
                      toDoDescription = value;
                    },
                    onFieldSubmitted: (value) async {
                      setState(() {
                        toDoDescription = value;
                        toDoDescriptionController.clearComposing();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //this is then submit button for the todo
                  child: ElevatedButton(
                    onPressed: () {
                      //here I run set state which refreshes the view
                      //and then I call addTodo which is a static method on the todo class
                      //and I pass a new todo object to it which adds the todo to the db
                      setState(() {
                        var newTodo = ToDo(
                          title: toDoTittle,
                          description: toDoDescription,
                          isDone: false,
                        );
                        newTodo.postTodo();
                        ToDo.addTodo(
                          newTodo,
                        );
                      });
                    },
                    child: const Text('Add To-Do'),
                  ),
                )
              ],
            )),
            toDoList(),
          ],
        ));
  }

  Column toDoList() {
    return Column(
      children: [
        Center(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: todos.length,
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: false,
                // onTap: () => {
                //   print("tapped"),
                //   setState(() {
                //     _isChecked = !_isChecked;
                //   })
                // },

                leading: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        ToDo.deleteTodo(
                          todos[index],
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      size: 33,
                    ),
                  ),
                ),
                title: Text(todos[index].title),
                subtitle: Text(todos[index].description),
                trailing: Checkbox(
                  value: todos[index].isDone,
                  onChanged: (bool? value) {
                    setState(() {
                      value == true
                          ? todos[index].setDone()
                          : todos[index].setNotDone();
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
