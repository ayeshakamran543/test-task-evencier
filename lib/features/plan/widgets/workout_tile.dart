import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/category_style.dart';
import '../../../core/utils/app_dates.dart';
import '../../../data/models/workout.dart';
import '../../widgets/sheet_drag_handle.dart';
import '../schedule_controller.dart';

/// A workout on the training calendar.
///
/// Drag the handle icon to move it to another day instantly, or tap the
/// tile for a "Move to" sheet (the accessible alternative to dragging).
class DraggableWorkoutTile extends StatelessWidget {
  const DraggableWorkoutTile({super.key, required this.workout});

  final Workout workout;

  Future<void> _showMoveSheet(BuildContext context) async {
    final schedule = context.read<ScheduleController>();
    final days = AppDates.weekOf(workout.date);
    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetDragHandle(),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 8.h),
              child: Text(
                'Move "${workout.title}" to',
                style: AppTypography.b1sb(context),
              ),
            ),
            for (final day in days)
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                title: Text(DateFormat('EEEE, MMM d').format(day)),
                trailing: AppDates.isSameDay(day, workout.date)
                    ? Icon(Icons.check, color: sheetContext.colors.accent)
                    : null,
                onTap: () => Navigator.of(sheetContext).pop(day),
              ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
    if (picked != null) schedule.moveWorkout(workout.id, picked);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      hint: 'Double tap to move to another day, or drag the handle',
      child: WorkoutTile(
        workout: workout,
        draggable: true,
        onTap: () => _showMoveSheet(context),
      ),
    );
  }
}

class WorkoutTile extends StatelessWidget {
  const WorkoutTile({
    super.key,
    required this.workout,
    this.onTap,
    this.lifted = false,
    this.draggable = false,
  });

  final Workout workout;
  final VoidCallback? onTap;
  final bool lifted;

  final bool draggable;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = CategoryStyle.of(
      workout.category,
      Theme.of(context).brightness,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final handleWidth = 22.r + 8.w;
        final handle = Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Icon(Icons.drag_indicator, size: 22.r, color: c.textSecondary),
        );

        final chip = Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: style.background,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              workout.category.svgIcon != null
                  ? SvgPicture.asset(
                      workout.category.svgIcon!,
                      width: 10.r,
                      height: 10.r,
                      colorFilter: ColorFilter.mode(
                        style.foreground,
                        BlendMode.srcIn,
                      ),
                    )
                  : Icon(
                      workout.category.icon,
                      size: 10.r,
                      color: style.foreground,
                    ),
              4.horizontalSpace,
              Text(
                workout.category.label,
                style: AppTypography.l3sb(
                  context,
                ).copyWith(color: style.foreground),
              ),
            ],
          ),
        );

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border(
              left: BorderSide(color: c.textPrimary, width: 7.w),
            ),
          ),
          child: Material(
            color: c.surface,
            elevation: lifted ? 8 : 0,
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(8.r),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 63.h),
                child: Row(
                  children: [
                    Container(width: 3.w, color: style.foreground),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (draggable)
                                  Draggable<String>(
                                    data: workout.id,
                                    onDragStarted: () =>
                                        HapticFeedback.mediumImpact(),
                                    feedback: Material(
                                      color: Colors.transparent,
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        child: WorkoutTile(
                                          workout: workout,
                                          lifted: true,
                                        ),
                                      ),
                                    ),
                                    childWhenDragging: Opacity(
                                      opacity: 0.3,
                                      child: handle,
                                    ),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.grab,
                                      child: handle,
                                    ),
                                  )
                                else
                                  handle,
                                chip,
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              children: [
                                SizedBox(width: handleWidth),
                                Expanded(
                                  child: Text(
                                    workout.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.b2(context),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  workout.durationLabel,
                                  style: AppTypography.b2bm(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
