import 'package:flutter/material.dart';
import 'package:flutter_to_do/models/to_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todos = ToDo.getTodos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: ListView(
          children: [
            Text("welcome to home page"),
            Column(children: [
              toDoList(),
            ])
          ],
        ));
  }

  Center toDoList() {
    return Center(
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
    );
  }
}
