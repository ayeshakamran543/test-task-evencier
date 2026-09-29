import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/workout.dart';
import 'workout_tile.dart';

class DayRow extends StatelessWidget {
  const DayRow({
    super.key,
    required this.day,
    required this.workouts,
    required this.isToday,
    required this.onDrop,
  });

  final DateTime day;
  final List<Workout> workouts;
  final bool isToday;
  final ValueChanged<String> onDrop;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final plannedColor = workouts.isNotEmpty
        ? c.textPrimary
        : const Color(0xFF5D607C);
    final labelColor = isToday ? c.accent : plannedColor;
    final numberColor = isToday ? c.accent : plannedColor;

    return DragTarget<String>(
      onWillAcceptWithDetails: (details) =>
          !workouts.any((w) => w.id == details.data),
      onAcceptWithDetails: (details) => onDrop(details.data),
      builder: (context, candidates, _) {
        final hovering = candidates.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: BoxConstraints(minHeight: 64.h),
          decoration: BoxDecoration(
            color: hovering
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.transparent,
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('EEE').format(day),
                            style: AppTypography.b2b(
                              context,
                            ).copyWith(color: labelColor),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${day.day}',
                            style: AppTypography.h3bm(
                              context,
                            ).copyWith(color: numberColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: workouts.isEmpty
                          ? AnimatedOpacity(
                              opacity: hovering ? 1 : 0,
                              duration: const Duration(milliseconds: 150),
                              child: Text(
                                'Drop here',
                                style: AppTypography.l1(
                                  context,
                                ).copyWith(color: c.accent),
                              ),
                            )
                          : Column(
                              children: [
                                for (final workout in workouts)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                    ),
                                    child: DraggableWorkoutTile(
                                      workout: workout,
                                    ),
                                  ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 24.w,
                right: 24.w,
                bottom: 0,
                child: Container(height: 1, color: c.border),
              ),
            ],
          ),
        );
      },
    );
  }
}
