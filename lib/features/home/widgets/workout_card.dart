import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/category_style.dart';
import '../../../data/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout, required this.onTap});

  final Workout workout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = CategoryStyle.of(
      workout.category,
      Theme.of(context).brightness,
    );
    final date = DateFormat('MMMM d').format(workout.date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border(
            left: BorderSide(color: style.foreground, width: 7.w),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$date - ${workout.durationLabel}',
                    style: AppTypography.l1b(
                      context,
                    ).copyWith(color: c.textPrimary),
                  ),
                  8.verticalSpace,
                  Text(workout.title, style: AppTypography.h2b(context)),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/svgs/forward_arrow.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(c.textPrimary, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

class RestDayCard extends StatelessWidget {
  const RestDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.self_improvement, color: c.accent, size: 30.w),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No workout scheduled. Recovery counts too.',
                  style: AppTypography.l1(
                    context,
                  ).copyWith(color: c.textPrimary),
                ),

                SizedBox(height: 2.h),
                Text('Rest day', style: AppTypography.h2b(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
