import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/mood.dart';
import 'mood_palette.dart';

class MoodWheel extends StatelessWidget {
  const MoodWheel({
    super.key,
    required this.degrees,
    required this.mood,
    required this.onChanged,
    required this.onSelectMood,
    this.size = 240,
  });

  final double degrees;
  final Mood mood;
  final ValueChanged<double> onChanged;
  final ValueChanged<Mood> onSelectMood;
  final double size;

  static double get _ringWidth => 26.0.r;

  void _handle(Offset local) {
    final dx = local.dx - size / 2;
    final dy = local.dy - size / 2;

    if (math.sqrt(dx * dx + dy * dy) < size * 0.2) return;
    final angle = math.atan2(dx, -dy) * 180 / math.pi;
    onChanged(angle < 0 ? angle + 360 : angle);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final radius = size / 2;
    final knobTrack = radius - _ringWidth / 2;
    final radians = degrees * math.pi / 180;
    final knob = Offset(
      radius + knobTrack * math.sin(radians),
      radius - knobTrack * math.cos(radians),
    );
    final knobSize = 34.0.r;

    return Semantics(
      label: 'Mood',
      value: mood.label,
      increasedValue: mood.next.label,
      decreasedValue: mood.previous.label,
      onIncrease: () => onSelectMood(mood.next),
      onDecrease: () => onSelectMood(mood.previous),
      child: GestureDetector(
        onPanStart: (d) => _handle(d.localPosition),
        onPanUpdate: (d) => _handle(d.localPosition),
        onTapDown: (d) => _handle(d.localPosition),
        child: SizedBox.square(
          dimension: size,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        Mood.calm.color,
                        Mood.content.color,
                        Mood.peaceful.color,
                        Mood.happy.color,
                        Mood.calm.color,
                      ],
                      stops: const [0, 0.25, 0.5, 0.75, 1],

                      transform: GradientRotation(
                        -math.pi / 2 + Mood.calm.centerDegrees * math.pi / 180,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size - _ringWidth * 2,
                  height: size - _ringWidth * 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c.background,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: Tween(begin: 0.85, end: 1.0).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: SvgPicture.asset(
                      mood.iconAsset,
                      key: ValueKey(mood),
                      width: size * 0.4,
                      height: size * 0.4,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: knob.dx - knobSize / 2,
                top: knob.dy - knobSize / 2,
                child: Container(
                  width: knobSize,
                  height: knobSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
