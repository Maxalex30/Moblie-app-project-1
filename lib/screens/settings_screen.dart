import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_1/providers/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Font Size'),
                Slider(
                  value: provider.fontSize,
                  min: 10,
                  max: 30,
                  divisions: 20,
                  label: provider.fontSize.round().toString(),
                  onChanged: (double newSize) {
                    provider.setFontSize(newSize);
                  },
                ),
                Text('Volume'),
                Slider(
                  value: provider.volume,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: (provider.volume * 100).round().toString(),
                  onChanged: (double newVolume) {
                    provider.setVolume(newVolume);
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Implement music file picker and upload logic here
                  },
                  child: Text('Upload Music'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
