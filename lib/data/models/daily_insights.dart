class DailyInsights {
  const DailyInsights({
    required this.consumedCalories,
    required this.calorieGoal,
    required this.weightKg,
    required this.weightChangeKg,
    required this.waterMl,
    required this.waterGoalMl,
  });

  final int consumedCalories;
  final int calorieGoal;
  final double weightKg;
  final double weightChangeKg;
  final int waterMl;
  final int waterGoalMl;

  int get remainingCalories =>
      consumedCalories >= calorieGoal ? 0 : calorieGoal - consumedCalories;

  double get calorieProgress => calorieGoal == 0
      ? 0
      : (consumedCalories / calorieGoal).clamp(0.0, 1.0).toDouble();

  double get hydrationProgress =>
      waterGoalMl == 0 ? 0 : (waterMl / waterGoalMl).clamp(0.0, 1.0).toDouble();

  DailyInsights copyWith({int? waterMl}) {
    return DailyInsights(
      consumedCalories: consumedCalories,
      calorieGoal: calorieGoal,
      weightKg: weightKg,
      weightChangeKg: weightChangeKg,
      waterMl: waterMl ?? this.waterMl,
      waterGoalMl: waterGoalMl,
    );
  }
}
