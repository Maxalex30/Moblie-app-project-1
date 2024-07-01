import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  double _fontSize = 14.0;
  double _volume = 0.5;
  String? _musicPath;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Map<DateTime, List<String>> _tasks = {};

  double get fontSize => _fontSize;
  double get volume => _volume;
  String? get musicPath => _musicPath;
  Map<DateTime, List<String>> get tasks => _tasks;

  void setFontSize(double newSize) {
    _fontSize = newSize;
    notifyListeners();
  }

  void setVolume(double newVolume) {
    _volume = newVolume;
    _audioPlayer.setVolume(newVolume);
    notifyListeners();
  }

  void setMusicPath(String path) {
    _musicPath = path;
    notifyListeners();
  }

  Future<void> playMusic() async {
    if (_musicPath != null) {
      await _audioPlayer.play(DeviceFileSource(_musicPath!), volume: _volume);
    }
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
  }

  // Task Management
  void addTask(DateTime date, String task) {
    if (_tasks[date] == null) {
      _tasks[date] = [];
    }
    _tasks[date]!.add(task);
    notifyListeners();
  }

  void removeTask(DateTime date, String task) {
    _tasks[date]?.remove(task);
    notifyListeners();
  }
}
