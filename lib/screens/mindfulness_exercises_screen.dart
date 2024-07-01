import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_1/providers/app_provider.dart';

class MindfulnessExercisesScreen extends StatefulWidget {
  @override
  _MindfulnessExercisesScreenState createState() =>
      _MindfulnessExercisesScreenState();
}

class _MindfulnessExercisesScreenState extends State<MindfulnessExercisesScreen> {
  DateTime? _selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindfulness Exercises'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return Column(
            children: <Widget>[
              if (_selectedDate != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tasks for ${_selectedDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.tasks[_selectedDate]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[_selectedDate]![index];
                    return ListTile(
                      title: Text(task),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.removeTask(_selectedDate!, task);
                        },
                      ),
                    );
                  },
                ),
              ),
              if (_selectedDate != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (value) {
                      provider.addTask(_selectedDate!, value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Add Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
