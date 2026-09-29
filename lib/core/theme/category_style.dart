import 'package:flutter/material.dart';

import '../../data/models/workout.dart';
import 'app_colors.dart';

/// Tag colours for each workout category, tuned per brightness so the
/// label text keeps a readable contrast on its chip in both themes.
///
/// Colors are sourced from the canonical [AppPaletteSwatch]s defined in
/// `app_colors.dart` — the single place that owns these hues for the
/// whole app.
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
