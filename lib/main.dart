import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Task> tasks = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addTask(String title, String description) {
    setState(() {
      tasks.add(Task(title, description));
      titleController.clear();
      descriptionController.clear();
    });
  }

  void editTask(int index, String title, String description) {
    setState(() {
      tasks[index] = Task(title, description);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 0, 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              titleController.clear();
                              descriptionController.clear();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Implement your search functionality here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Add Title',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Add Description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                addTask(titleController.text, descriptionController.text);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange, // Change the button's background color to orange
            ),
            child: Text('Add', style: TextStyle(color: Colors.white)), // Change text color to white
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                // Set the background color to grey for all items
                Color itemColor = Colors.black12;
                return Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding around each list item
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                    ),
                    title: Text(tasks[index].title),
                    subtitle: Text(tasks[index].description),
                    tileColor: itemColor,
                    trailing: Icon(Icons.arrow_forward), // Add this line
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Alerts'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  editTask(index, titleController.text, descriptionController.text);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Edit'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteTask(index);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String title;
  String description;

  Task(this.title, this.description);
}
