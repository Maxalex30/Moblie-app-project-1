import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindfulness App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: <Widget>[
                  _buildMenuButton(context, 'Mindfulness Exercises', '/mindfulness', Icons.self_improvement),
                  _buildMenuButton(context, 'Stress Reduction', '/stress-reduction', Icons.spa),
                  _buildMenuButton(context, 'Daily Affirmations', '/daily-affirmations', Icons.format_quote),
                  _buildMenuButton(context, 'Mood Tracking', '/mood-tracking', Icons.mood),
                  _buildMenuButton(context, 'Settings', '/settings', Icons.settings),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, String route, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // updated from primary
        foregroundColor: Colors.white, // updated from onPrimary
        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40.0),
          SizedBox(height: 10.0),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
