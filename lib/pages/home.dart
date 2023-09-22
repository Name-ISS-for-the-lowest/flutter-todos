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
      body: Center(
        child: ListView.separated(
          itemCount: todos.length,
          separatorBuilder: (context, index) => SizedBox(width: 25),
          itemBuilder: (context, index) {
            return ListTile(
              // onTap: () => {
              //   print("tapped"),
              //   setState(() {
              //     _isChecked = !_isChecked;
              //   })
              // },
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
              trailing: Checkbox(
                value: todos[index].isDone,
                onChanged: (bool? value) {
                  print("hello");
                  setState(() {
                    todos[index].isDone = value!;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
