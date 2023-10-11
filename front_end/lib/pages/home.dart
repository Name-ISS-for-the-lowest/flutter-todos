import 'package:flutter/material.dart';
import 'package:flutter_to_do/models/to_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todos = [];
  Future<void> fetchTodos() async {
    todos = await ToDo.getTodos();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  String toDoTittle = "";
  String toDoDescription = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController toDoDescriptionController = TextEditingController();
    TextEditingController toDoTitleController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      //this is the input field for the to-do title
                      child: TextFormField(
                        controller: toDoTitleController,
                        decoration: const InputDecoration(
                            hintText: 'Insert to-do title'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else {
                            toDoTittle = value;
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (String value) async {
                          toDoDescription = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      //this is then submit button for the todo
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await ToDo.addTodo(ToDo(
                              title: toDoTittle,
                              description: toDoDescription,
                              isDone: false,
                            ));
                            setState(() {
                              toDoDescriptionController.clear();
                              toDoTitleController.clear();
                            });
                          }
                        },
                        child: const Text('Add To-Do'),
                      ),
                    )
                  ],
                )),
            Expanded(child: toDoList()),
          ],
        ));
  }

  ListView toDoList() {
    return ListView.separated(
      // shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (context, index) => const SizedBox(width: 25),
      itemBuilder: (context, index) {
        return ListTile(
          isThreeLine: false,
          leading: Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              onPressed: () async {
                await ToDo.deleteTodo(
                  todos[index],
                );
                setState(() {});
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
            onChanged: (bool? value) async {
              value == true
                  ?todos[index].setDone()
                  : todos[index].setNotDone();

              setState(() {});
              await ToDo.updateTodo(
                todos[index],
              );
            },
          ),
        );
      },
    );
  }
}
