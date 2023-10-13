import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selectable List Example',
      home: SelectableListScreen(),
    );
  }
}

class SelectableListScreen extends StatefulWidget {
  @override
  _SelectableListScreenState createState() => _SelectableListScreenState();
}

class _SelectableListScreenState extends State<SelectableListScreen> {
  List<bool> selectedItems = List.generate(5, (index) => false);

  void toggleSelection(int index) {
    setState(() {
      selectedItems[index] = !selectedItems[index];
    });
  }

  int getSelectedCount() {
    return selectedItems.where((itemSelected) => itemSelected).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Screen'),
      ),
      body: ListView.builder(
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              toggleSelection(index);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: selectedItems[index] ? Colors.blue : null,
              child: Text('Item ${index + 1}'), // Start from Item 1
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Selected Items'),
                content: Text('Number of selected items: ${getSelectedCount()}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
