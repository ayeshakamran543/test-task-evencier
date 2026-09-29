import '../../core/utils/app_dates.dart';
import 'workout.dart';

class TrainingProgram {
  const TrainingProgram({
    required this.start,
    required this.totalWeeks,
    required this.workouts,
  });

  final DateTime start;
  final int totalWeeks;
  final List<Workout> workouts;
}

class ProgramWeek {
  const ProgramWeek({required this.number, required this.start});

  final int number;

  final DateTime start;

  List<DateTime> get days => AppDates.weekOf(start);

  bool contains(DateTime day) {
    final offset = AppDates.daysBetween(start, day);
    return offset >= 0 && offset < 7;
  }
}
