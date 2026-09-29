import 'package:flutter/material.dart';

import '../../../data/models/mood.dart';

extension MoodPalette on Mood {
  Color get color {
    switch (this) {
      case Mood.calm:
        return const Color(0xFF6EB9AD);
      case Mood.content:
        return const Color(0xFFC9BBEF);
      case Mood.peaceful:
        return const Color(0xFFF28DB3);
      case Mood.happy:
        return const Color(0xFFF99955);
    }
  }

  String get iconAsset {
    switch (this) {
      case Mood.calm:
        return 'assets/svgs/calm.svg';
      case Mood.content:
        return 'assets/svgs/content.svg';
      case Mood.peaceful:
        return 'assets/svgs/peaceful.svg';
      case Mood.happy:
        return 'assets/svgs/happy.svg';
    }
  }
}
