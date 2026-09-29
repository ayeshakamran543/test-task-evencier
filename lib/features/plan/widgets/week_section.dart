import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_dates.dart';
import '../../../data/models/training_program.dart';
import '../schedule_controller.dart';
import 'day_row.dart';

class WeekSection extends StatefulWidget {
  const WeekSection({
    super.key,
    required this.week,
    required this.initiallyExpanded,
  });

  final ProgramWeek week;
  final bool initiallyExpanded;

  @override
  State<WeekSection> createState() => _WeekSectionState();
}

class _WeekSectionState extends State<WeekSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final schedule = context.watch<ScheduleController>();
    final c = context.colors;
    final week = widget.week;

    final borderColor =
        appAccentPalette[(week.number - 1) % appAccentPalette.length];

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: borderColor),
          child: SizedBox(height: 3.h, width: double.infinity),
        ),
        Material(
          color: c.surfaceMuted,
          child: InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 14.w, 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Week ${week.number}/${schedule.totalWeeks}',
                          style: AppTypography.h4b(context),
                        ),
                        2.verticalSpace,
                        Text(
                          AppDates.weekRangeLabel(week.start),
                          style: AppTypography.b1(
                            context,
                          ).copyWith(color: c.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Total: ${schedule.totalMinutesFor(week)}min',
                    style: AppTypography.b1(
                      context,
                    ).copyWith(color: c.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Column(
                  children: [
                    for (final day in week.days)
                      DayRow(
                        day: day,
                        workouts: schedule.workoutsOn(day),
                        isToday: AppDates.isSameDay(day, schedule.today),
                        onDrop: (id) => schedule.moveWorkout(id, day),
                      ),
                  ],
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
