import 'package:flutter/material.dart';
import 'dart:math';

class DailyAffirmationsScreen extends StatefulWidget {
  @override
  _DailyAffirmationsScreenState createState() => _DailyAffirmationsScreenState();
}

class _DailyAffirmationsScreenState extends State<DailyAffirmationsScreen> {
  late String _currentAffirmation; // marked as late

  final List<String> _affirmations = [
    'You are capable of amazing things.',
    'Believe in yourself and all that you are.',
    'You are stronger than you think.',
    'You are worthy of all the good things in life.',
    'Every day is a new beginning.',
    'You have the power to create change.',
    'You are enough just as you are.',
    'Positivity is a choice.',
    'You are brave, bold, and beautiful.',
    'You are making a difference.',
    'Trust the process.',
    'You are resilient.',
    'You are in control of your own happiness.',
    'You are deserving of love and respect.',
    'You are growing and learning every day.',
    'You have the ability to overcome any challenge.',
    'You are creating a life you love.',
    'Your potential is limitless.',
    'You are a work in progress, and that’s okay.',
    'You are a beautiful person inside and out.',
  ];

  @override
  void initState() {
    super.initState();
    _generateRandomAffirmation();
  }

  void _generateRandomAffirmation() {
    final random = Random();
    setState(() {
      _currentAffirmation = _affirmations[random.nextInt(_affirmations.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Affirmations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentAffirmation,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomAffirmation,
              child: Text('New Affirmation'),
            ),
          ],
        ),
      ),
    );
  }
}
