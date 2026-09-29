import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_dates.dart';

class WeekStrip extends StatelessWidget {
  const WeekStrip({
    super.key,
    required this.selected,
    required this.today,
    required this.hasWorkout,
    required this.onSelected,
  });

  final DateTime selected;
  final DateTime today;
  final bool Function(DateTime day) hasWorkout;
  final ValueChanged<DateTime> onSelected;

  static const _labels = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];

  @override
  Widget build(BuildContext context) {
    final days = AppDates.weekOf(selected);
    return Row(
      children: [
        for (var i = 0; i < days.length; i++)
          Expanded(
            child: _DayCell(
              label: _labels[i],
              day: days[i],
              isSelected: AppDates.isSameDay(days[i], selected),
              isToday: AppDates.isSameDay(days[i], today),
              hasWorkout: hasWorkout(days[i]),
              onTap: () => onSelected(days[i]),
            ),
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.label,
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.hasWorkout,
    required this.onTap,
  });

  final String label;
  final DateTime day;
  final bool isSelected;
  final bool isToday;
  final bool hasWorkout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      selected: isSelected,
      label: DateFormat('EEEE d MMMM').format(day),
      excludeSemantics: true,
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.l1b(context).copyWith(color: c.textPrimary),
          ),
          12.verticalSpace,
          InkResponse(
            onTap: onTap,
            radius: 24.r,
            child: SizedBox(
              width: 40.w,
              height: 40.h,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36.w,
                  height: 36.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? c.accent.withValues(alpha: 0.17)
                        : c.surfaceMuted,
                    border: Border.all(
                      color: isSelected ? c.accent : Colors.transparent,
                      width: 2.w,
                    ),
                  ),
                  child: Text(
                    '${day.day}',
                    style: AppTypography.b2b(
                      context,
                    ).copyWith(color: c.textPrimary),
                  ),
                ),
              ),
            ),
          ),
          8.verticalSpace,
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasWorkout ? c.accent : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
