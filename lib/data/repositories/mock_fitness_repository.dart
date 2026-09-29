import '../../core/utils/app_dates.dart';
import '../models/daily_insights.dart';
import '../models/mood.dart';
import '../models/training_program.dart';
import '../models/workout.dart';
import 'fitness_repository.dart';

class MockFitnessRepository implements FitnessRepository {
  MockFitnessRepository({
    DateTime Function()? clock,
    this.latency = Duration.zero,
  }) : _clock = clock ?? DateTime.now;

  final DateTime Function() _clock;

  final Duration latency;

  static const totalWeeks = 8;

  List<Workout>? _workouts;
  final Map<DateTime, DailyInsights> _insights = {};
  final List<({Mood mood, DateTime at})> moodLog = [];

  DateTime get _today => AppDates.dateOnly(_clock());

  DateTime get _programStart {
    final monday = AppDates.startOfWeek(_today);
    return DateTime(monday.year, monday.month, monday.day - 7);
  }

  Future<T> _respond<T>(T value) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    return value;
  }

  @override
  Future<TrainingProgram> fetchProgram() {
    _workouts ??= _seedWorkouts();
    return _respond(
      TrainingProgram(
        start: _programStart,
        totalWeeks: totalWeeks,
        workouts: List.unmodifiable(_workouts!),
      ),
    );
  }

  @override
  Future<void> saveWorkouts(List<Workout> workouts) {
    _workouts = List.of(workouts);
    return _respond<void>(null);
  }

  @override
  Future<DailyInsights> fetchInsights(DateTime day) {
    final key = AppDates.dateOnly(day);
    return _respond(_insights.putIfAbsent(key, () => _seedInsights(key)));
  }

  @override
  Future<void> logWater(DateTime day, int ml) async {
    final current = await fetchInsights(day);
    _insights[AppDates.dateOnly(day)] = current.copyWith(
      waterMl: current.waterMl + ml,
    );
  }

  @override
  Future<int> fetchTemperature() => _respond(9);

  @override
  Future<void> logMood(Mood mood, DateTime at) {
    moodLog.add((mood: mood, at: at));
    return _respond<void>(null);
  }

  List<Workout> _seedWorkouts() {
    final start = _programStart;
    DateTime day(int offset) =>
        DateTime(start.year, start.month, start.day + offset);

    return [
      Workout(
        id: 'w1',
        title: 'Full Body Reset',
        category: WorkoutCategory.fullBody,
        date: day(1),
        minMinutes: 25,
        maxMinutes: 30,
      ),
      Workout(
        id: 'w2',
        title: 'Easy Run',
        category: WorkoutCategory.cardio,
        date: day(4),
        minMinutes: 20,
        maxMinutes: 25,
      ),
      Workout(
        id: 'w3',
        title: 'Arm Blaster',
        category: WorkoutCategory.arms,
        date: day(7),
        minMinutes: 25,
        maxMinutes: 30,
      ),
      Workout(
        id: 'w4',
        title: 'Leg Day Blitz',
        category: WorkoutCategory.legs,
        date: day(10),
        minMinutes: 25,
        maxMinutes: 30,
      ),
      Workout(
        id: 'w5',
        title: 'Upper Body',
        category: WorkoutCategory.upperBody,
        date: _today,
        minMinutes: 25,
        maxMinutes: 30,
      ),
      Workout(
        id: 'w6',
        title: 'Core Crusher',
        category: WorkoutCategory.core,
        date: day(15),
        minMinutes: 15,
        maxMinutes: 20,
      ),
      Workout(
        id: 'w7',
        title: 'HIIT Cardio',
        category: WorkoutCategory.cardio,
        date: day(18),
        minMinutes: 20,
        maxMinutes: 25,
      ),
    ];
  }

  DailyInsights _seedInsights(DateTime day) {
    final offset = AppDates.daysBetween(_today, day);
    if (offset == 0) {
      return const DailyInsights(
        consumedCalories: 550,
        calorieGoal: 2500,
        weightKg: 75,
        weightChangeKg: 1.6,
        waterMl: 0,
        waterGoalMl: 2000,
      );
    }
    final isPast = offset < 0;
    return DailyInsights(
      consumedCalories: isPast ? 1600 + (day.day * 53) % 700 : 0,
      calorieGoal: 2500,
      weightKg: 75,
      weightChangeKg: 1.6,
      waterMl: isPast ? 1250 + (day.day * 125) % 750 : 0,
      waterGoalMl: 2000,
    );
  }
}
