import 'package:flutter/material.dart';

enum WorkoutCategory {
  arms('Arms Workout', Icons.fitness_center, 'assets/svgs/arms_workout.svg'),
  legs('Leg Workout', Icons.directions_run, 'assets/svgs/legs_workout.svg'),
  upperBody('Upper Body', Icons.accessibility_new, null),
  core('Core', Icons.self_improvement, 'assets/svgs/internals_workout.svg'),
  cardio('Cardio', Icons.favorite, null),
  fullBody('Full Body', Icons.sports_gymnastics, null);

  const WorkoutCategory(this.label, this.icon, this.svgIcon);

  final String label;
  final IconData icon;

  final String? svgIcon;
}

class Workout {
  const Workout({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.minMinutes,
    required this.maxMinutes,
  });

  final String id;
  final String title;
  final WorkoutCategory category;

  final DateTime date;
  final int minMinutes;
  final int maxMinutes;

  String get durationLabel => '${minMinutes}m - ${maxMinutes}m';

  Workout copyWith({DateTime? date}) {
    return Workout(
      id: id,
      title: title,
      category: category,
      date: date ?? this.date,
      minMinutes: minMinutes,
      maxMinutes: maxMinutes,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Workout &&
      other.id == id &&
      other.title == title &&
      other.category == category &&
      other.date == date &&
      other.minMinutes == minMinutes &&
      other.maxMinutes == maxMinutes;

  @override
  int get hashCode =>
      Object.hash(id, title, category, date, minMinutes, maxMinutes);
}
