import 'package:flutter/foundation.dart';

import '../../core/utils/app_dates.dart';
import '../../data/models/daily_insights.dart';
import '../../data/repositories/fitness_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._repository, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now {
    _selectedDay = today;
  }

  final FitnessRepository _repository;
  final DateTime Function() _clock;

  late DateTime _selectedDay;
  DailyInsights? _insights;
  int? _temperature;
  int? _lastLoggedMl;
  bool _isLoading = true;
  Object? _error;
  bool _disposed = false;

  DateTime get today => AppDates.dateOnly(_clock());
  DateTime get selectedDay => _selectedDay;
  DailyInsights? get insights => _insights;
  int? get temperature => _temperature;
  int? get lastLoggedMl => _lastLoggedMl;
  bool get isLoading => _isLoading;
  Object? get error => _error;

  Future<void> load() async {
    _error = null;
    try {
      _insights = await _repository.fetchInsights(_selectedDay);
      _temperature = await _repository.fetchTemperature();
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  void selectDay(DateTime day) {
    final date = AppDates.dateOnly(day);
    if (AppDates.isSameDay(date, _selectedDay)) return;
    _selectedDay = date;
    _lastLoggedMl = null;
    _notify();
    load();
  }

  /// Optimistic update: the UI changes instantly and rolls back if the
  /// repository call fails.
  Future<void> logWater(int ml) async {
    final previous = _insights;
    if (previous == null) return;
    _insights = previous.copyWith(waterMl: previous.waterMl + ml);
    _lastLoggedMl = ml;
    _notify();
    try {
      await _repository.logWater(_selectedDay, ml);
    } catch (e) {
      _insights = previous;
      _lastLoggedMl = null;
      _error = e;
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
