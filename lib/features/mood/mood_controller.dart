import 'package:flutter/foundation.dart';

import '../../data/models/mood.dart';
import '../../data/repositories/fitness_repository.dart';

class MoodController extends ChangeNotifier {
  MoodController(this._repository, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final FitnessRepository _repository;
  final DateTime Function() _clock;

  double _degrees = Mood.calm.centerDegrees;
  bool _isSubmitting = false;
  bool _disposed = false;

  double get degrees => _degrees;
  Mood get mood => Mood.fromDegrees(_degrees);
  bool get isSubmitting => _isSubmitting;

  void updateDegrees(double degrees) {
    _degrees = degrees % 360;
    _notify();
  }

  void select(Mood mood) => updateDegrees(mood.centerDegrees);

  Future<void> submit() async {
    if (_isSubmitting) return;
    _isSubmitting = true;
    _notify();
    try {
      await _repository.logMood(mood, _clock());
    } finally {
      _isSubmitting = false;
      _notify();
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
