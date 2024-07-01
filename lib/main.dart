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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<AppProvider>(context);
    if (provider.musicPath != null) {
      _audioPlayer.setSource(UrlSource(provider.musicPath!));
      _audioPlayer.setVolume(provider.volume);
      _audioPlayer.play(UrlSource(provider.musicPath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindfulness App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mindfulness');
              },
              child: Text('Mindfulness Exercises'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/stress-reduction');
              },
              child: Text('Stress Reduction Techniques'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/daily-affirmations');
              },
              child: Text('Daily Affirmations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mood-tracking');
              },
              child: Text('Mood Tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
