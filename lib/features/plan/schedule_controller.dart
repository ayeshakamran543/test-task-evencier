import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../core/utils/app_dates.dart';
import '../../data/models/training_program.dart';
import '../../data/models/workout.dart';
import '../../data/repositories/fitness_repository.dart';

/// Single source of truth for the training plan, shared by the Home and
/// Plan screens so a workout moved on the plan shows up on Home at once.
///
/// Edits go to a draft; [save] commits them, [discard] throws them away.
class ScheduleController extends ChangeNotifier {
  ScheduleController(this._repository, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final FitnessRepository _repository;
  final DateTime Function() _clock;

  DateTime _programStart = DateTime(2000);
  int _totalWeeks = 1;
  List<Workout> _saved = const [];
  List<Workout> _draft = const [];
  bool _isLoading = true;
  bool _isSaving = false;
  Object? _error;
  bool _disposed = false;

  Object? get error => _error;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  int get totalWeeks => _totalWeeks;
  DateTime get today => AppDates.dateOnly(_clock());
  bool get hasUnsavedChanges => !listEquals(_saved, _draft);

  List<ProgramWeek> get weeks => List<ProgramWeek>.generate(
    _totalWeeks,
    (i) => ProgramWeek(
      number: i + 1,
      start: DateTime(
        _programStart.year,
        _programStart.month,
        _programStart.day + 7 * i,
      ),
    ),
  );

  Future<void> load() async {
    try {
      final program = await _repository.fetchProgram();
      _programStart = program.start;
      _totalWeeks = program.totalWeeks;
      _saved = List.unmodifiable(program.workouts);
      _draft = List.of(_saved);
      _error = null;
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  List<Workout> workoutsOn(DateTime day) =>
      _draft.where((w) => AppDates.isSameDay(w.date, day)).toList();

  int weekNumberFor(DateTime day) {
    final offset = AppDates.daysBetween(
      _programStart,
      AppDates.startOfWeek(day),
    );
    final week = offset ~/ 7 + 1;
    return math.min(math.max(week, 1), _totalWeeks);
  }

  /// Planned time for a week, using the upper bound of each workout.
  int totalMinutesFor(ProgramWeek week) => _draft
      .where((w) => week.contains(w.date))
      .fold<int>(0, (sum, w) => sum + w.maxMinutes);

  void moveWorkout(String id, DateTime toDay) {
    final index = _draft.indexWhere((w) => w.id == id);
    if (index == -1) return;
    final target = AppDates.dateOnly(toDay);
    if (AppDates.isSameDay(_draft[index].date, target)) return;
    _draft = List.of(_draft)..[index] = _draft[index].copyWith(date: target);
    _notify();
  }

  Future<void> save() async {
    if (!hasUnsavedChanges || _isSaving) return;
    _isSaving = true;
    _notify();
    try {
      await _repository.saveWorkouts(List.unmodifiable(_draft));
      _saved = List.unmodifiable(_draft);
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  void discard() {
    _draft = List.of(_saved);
    _notify();
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
