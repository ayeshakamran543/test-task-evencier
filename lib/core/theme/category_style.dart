import 'package:flutter/material.dart';

import '../../data/models/workout.dart';
import 'app_colors.dart';

@immutable
class CategoryStyle {
  const CategoryStyle(this.foreground, this.background);

  final Color foreground;
  final Color background;

  static CategoryStyle of(WorkoutCategory category, Brightness brightness) {
    final swatch = _swatchFor(category);
    return brightness == Brightness.dark
        ? CategoryStyle(swatch.base, swatch.darkBackground)
        : CategoryStyle(swatch.lightForeground, swatch.lightBackground);
  }

  static AppPaletteSwatch _swatchFor(WorkoutCategory category) {
    switch (category) {
      case WorkoutCategory.arms:
        return appGreenSwatch;
      case WorkoutCategory.legs:
        return appPurpleSwatch;
      case WorkoutCategory.upperBody:
        return appTealSwatch;
      case WorkoutCategory.core:
        return appOrangeSwatch;
      case WorkoutCategory.cardio:
        return appPinkSwatch;
      case WorkoutCategory.fullBody:
        return appBlueSwatch;
    }
  }
}
