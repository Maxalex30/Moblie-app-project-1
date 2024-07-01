import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_1/screens/home_screen.dart';
import 'package:project_1/screens/mindfulness_exercises_screen.dart';
import 'package:project_1/screens/stress_reduction_screen.dart';
import 'package:project_1/screens/daily_affirmations_screen.dart';
import 'package:project_1/screens/mood_tracking_screen.dart';
import 'package:project_1/screens/settings_screen.dart';
import 'package:project_1/providers/app_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'Mindfulness App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: provider.fontSize),
              bodyMedium: TextStyle(fontSize: provider.fontSize),
            ),
          ),
          home: HomeScreen(),
          routes: {
            '/mindfulness': (context) => MindfulnessExercisesScreen(),
            '/stress-reduction': (context) => StressReductionScreen(),
            '/daily-affirmations': (context) => DailyAffirmationsScreen(),
            '/mood-tracking': (context) => MoodTrackingScreen(),
            '/settings': (context) => SettingsScreen(),
          },
        );
      },
    );
  }
}
