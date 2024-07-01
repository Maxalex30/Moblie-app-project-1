import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'mood_tracking_provider.dart';

class MoodTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoodTrackingProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mood Tracking'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Consumer<MoodTrackingProvider>(
                  builder: (context, provider, child) {
                    return SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries>[
                        LineSeries<MoodData, int>(
                          name: 'Exercise',
                          color: Colors.blue,
                          dataSource: _getMoodData(provider.exerciseScore),
                          xValueMapper: (MoodData data, _) => data.index,
                          yValueMapper: (MoodData data, _) => data.score,
                        ),
                        LineSeries<MoodData, int>(
                          name: 'Mentality',
                          color: Colors.orange,
                          dataSource: _getMoodData(provider.mentalityScore),
                          xValueMapper: (MoodData data, _) => data.index,
                          yValueMapper: (MoodData data, _) => data.score,
                        ),
                        LineSeries<MoodData, int>(
                          name: 'Spirituality',
                          color: Colors.green,
                          dataSource: _getMoodData(provider.spiritualityScore),
                          xValueMapper: (MoodData data, _) => data.index,
                          yValueMapper: (MoodData data, _) => data.score,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  _buildActivityButton(context, 'Do a Run', () {
                    Provider.of<MoodTrackingProvider>(context, listen: false).increaseExerciseScore(10);
                  }),
                  _buildActivityButton(context, 'Do Mindfulness', () {
                    Provider.of<MoodTrackingProvider>(context, listen: false).increaseMentalityScore(30);
                  }),
                  _buildActivityButton(context, 'Pray or Meditate', () {
                    Provider.of<MoodTrackingProvider>(context, listen: false).increaseSpiritualityScore(30);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<MoodData> _getMoodData(int score) {
    return List.generate(10, (index) => MoodData(index, score / 10));
  }

  Widget _buildActivityButton(BuildContext context, String label, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}

class MoodData {
  final int index;
  final double score;

  MoodData(this.index, this.score);
}
