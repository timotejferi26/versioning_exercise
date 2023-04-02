import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:versioning_exercise/providers/task_list_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tasks'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add task'),
                  content: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(hintText: "Name"),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(hintText: "Description"),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        nameController.clear();
                        descriptionController.clear();
                      },
                    ),
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        ref.read(taskListProvider.notifier).addTask(
                            nameController.text.trimRight(),
                            descriptionController.text.trimRight());
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        )
    );
  }
}

class ExceptionHandlerWidget extends StatelessWidget {
  const ExceptionHandlerWidget({Key? key, required this.exception}) : super(key: key);

  final Object exception;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Icon(Icons.error_outline, color: Colors.red, size: 40,),
        ),
        Text(exception.toString())
      ],
    );
  }
}
