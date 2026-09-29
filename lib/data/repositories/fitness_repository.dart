import '../models/daily_insights.dart';
import '../models/mood.dart';
import '../models/training_program.dart';
import '../models/workout.dart';

abstract class FitnessRepository {
  Future<TrainingProgram> fetchProgram();

  Future<void> saveWorkouts(List<Workout> workouts);

  Future<DailyInsights> fetchInsights(DateTime day);

  Future<void> logWater(DateTime day, int ml);

  Future<int> fetchTemperature();

  Future<void> logMood(Mood mood, DateTime at);
}
