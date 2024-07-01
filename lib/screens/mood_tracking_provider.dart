import 'package:flutter/material.dart';

class MoodTrackingProvider with ChangeNotifier {
  int _exerciseScore = 0;
  int _mentalityScore = 0;
  int _spiritualityScore = 0;

  int get exerciseScore => _exerciseScore;
  int get mentalityScore => _mentalityScore;
  int get spiritualityScore => _spiritualityScore;

  void increaseExerciseScore(int value) {
    if (_exerciseScore + value <= 50) {
      _exerciseScore += value;
      notifyListeners();
    }
  }

  void increaseMentalityScore(int value) {
    if (_mentalityScore + value <= 50) {
      _mentalityScore += value;
      notifyListeners();
    }
  }

  void increaseSpiritualityScore(int value) {
    if (_spiritualityScore + value <= 50) {
      _spiritualityScore += value;
      notifyListeners();
    }
  }
}
