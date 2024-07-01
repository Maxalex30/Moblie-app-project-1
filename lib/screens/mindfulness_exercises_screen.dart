import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:project_1/providers/app_provider.dart';

class MindfulnessExercisesScreen extends StatefulWidget {
  @override
  _MindfulnessExercisesScreenState createState() =>
      _MindfulnessExercisesScreenState();
}

class _MindfulnessExercisesScreenState extends State<MindfulnessExercisesScreen> {
  final List<Exercise> exercises = [
    Exercise(
      name: 'Breathing Exercise',
      image: 'assets/images/breathing_exercise.png',
      instructions: 'Sit comfortably, close your eyes, and focus on your breath. Breathe in through your nose for 4 seconds, hold for 7 seconds, and exhale through your mouth for 8 seconds.',
      duration: '5 minutes',
      preparation: 'Find a quiet place to sit comfortably.',
    ),
    Exercise(
      name: 'Body Scan',
      image: 'assets/images/body_scan.png',
      instructions: 'Lie down comfortably and close your eyes. Focus on each part of your body, starting from your toes and moving up to your head. Notice any sensations you feel.',
      duration: '10 minutes',
      preparation: 'Find a comfortable place to lie down.',
    ),
    Exercise(
      name: 'Mindful Walking',
      image: 'assets/images/mindful_walking.png',
      instructions: 'Walk slowly and focus on the sensation of your feet touching the ground. Notice the sights, sounds, and smells around you.',
      duration: '15 minutes',
      preparation: 'Choose a quiet place for a walk.',
    ),
    Exercise(
      name: 'Loving Kindness Meditation',
      image: 'assets/images/loving_kindness.png',
      instructions: 'Sit comfortably and close your eyes. Repeat the phrases "May I be happy, may I be healthy, may I be safe, may I live with ease," then extend these wishes to others.',
      duration: '10 minutes',
      preparation: 'Find a quiet place to sit comfortably.',
    ),
    Exercise(
      name: 'Mindful Eating',
      image: 'assets/images/mindful_eating.png',
      instructions: 'Eat slowly and savor each bite. Notice the flavors, textures, and aromas of your food. Pay attention to how your body feels as you eat.',
      duration: '10 minutes',
      preparation: 'Prepare a small meal or snack.',
    ),
  ];

  late Exercise selectedExercise;
  DateTime? _selectedDate;
  bool _isAddingTask = false;
  TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final random = Random();
    selectedExercise = exercises[random.nextInt(exercises.length)];
  }

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
        _isAddingTask = true;
      });
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          selectedExercise.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          selectedExercise.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Duration: ${selectedExercise.duration}',
                          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Preparation: ${selectedExercise.preparation}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Instructions: ${selectedExercise.instructions}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
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
                if (_isAddingTask)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            labelText: 'Add Task',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (value) {
                            provider.addTask(_selectedDate!, value);
                            setState(() {
                              _isAddingTask = false;
                              _taskController.clear();
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isAddingTask = false;
                            });
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Exercise {
  final String name;
  final String image;
  final String instructions;
  final String duration;
  final String preparation;

  Exercise({
    required this.name,
    required this.image,
    required this.instructions,
    required this.duration,
    required this.preparation,
  });
}
