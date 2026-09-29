import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_dates.dart';
import '../../widgets/sheet_drag_handle.dart';

class MonthCalendarSheet extends StatefulWidget {
  const MonthCalendarSheet({
    super.key,
    required this.selected,
    required this.today,
  });

  final DateTime selected;
  final DateTime today;

  @override
  State<MonthCalendarSheet> createState() => _MonthCalendarSheetState();
}

class _MonthCalendarSheetState extends State<MonthCalendarSheet> {
  static const _weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  late DateTime _month = DateTime(widget.selected.year, widget.selected.month);

  void _shift(int months) {
    setState(() => _month = DateTime(_month.year, _month.month + months));
  }

  @override
  Widget build(BuildContext context) {
    final blanks = AppDates.leadingBlanks(_month);
    final count = AppDates.daysInMonth(_month);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SheetDragHandle(),
            Row(
              children: [
                IconButton(
                  tooltip: 'Previous month',
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => _shift(-1),
                ),
                Expanded(
                  child: Text(
                    DateFormat('MMM yyyy').format(_month),
                    textAlign: TextAlign.center,
                    style: AppTypography.b1b(context),
                  ),
                ),
                IconButton(
                  tooltip: 'Next month',
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => _shift(1),
                ),
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                for (final label in _weekdays)
                  Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: AppTypography.l1b(context),
                    ),
                  ),
              ],
            ),
            16.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 48.h,
              ),
              itemCount: blanks + count,
              itemBuilder: (context, index) {
                if (index < blanks) return const SizedBox.shrink();
                final day = DateTime(
                  _month.year,
                  _month.month,
                  index - blanks + 1,
                );
                return _CalendarDay(
                  day: day,
                  isSelected: AppDates.isSameDay(day, widget.selected),
                  isToday: AppDates.isSameDay(day, widget.today),
                  onTap: () => Navigator.of(context).pop(day),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime day;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: SizedBox(
        width: 42.w,
        height: 42.h,
        child: Material(
          color: isSelected
              ? c.accent.withValues(alpha: 0.17)
              : Colors.transparent,
          shape: CircleBorder(
            side: isSelected
                ? BorderSide(color: c.accent, width: 2.w)
                : BorderSide.none,
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Center(
              child: Text(
                '${day.day}',
                style: AppTypography.b2bm(context).copyWith(
                  fontWeight: isToday || isSelected
                      ? FontWeight.w700
                      : FontWeight.w400,
                  color: c.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
