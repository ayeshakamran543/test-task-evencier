import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_typography.dart';

class _QuickWorkout {
  const _QuickWorkout(this.label, this.background);

  final String label;
  final String background;
}

const _workouts = [
  _QuickWorkout('Arm Blaster', 'assets/pngs/QW_bg1.png'),
  _QuickWorkout('Chest Pump', 'assets/pngs/QW_bg2.png'),
  _QuickWorkout('Core Crusher', 'assets/pngs/QW_bg3.png'),
  _QuickWorkout('Leg Day Blitz', 'assets/pngs/QW_bg4.png'),
  _QuickWorkout('Back Attack', 'assets/pngs/QW_bg5.png'),
  _QuickWorkout('Shoulder Shockwave', 'assets/pngs/QW_bg6.png'),
];

/// A 2-column grid of quick-start workout shortcuts.
class QuickWorkoutGrid extends StatelessWidget {
  const QuickWorkoutGrid({super.key, this.onSelected});

  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _workouts.length; i += 2)
          Padding(
            padding: EdgeInsets.only(
              bottom: i + 2 < _workouts.length ? 8.h : 0,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _Tile(_workouts[i], onSelected)),
                  SizedBox(width: 8.w),
                  Expanded(child: _Tile(_workouts[i + 1], onSelected)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.workout, this.onSelected);

  final _QuickWorkout workout;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected == null ? null : () => onSelected!(workout.label),
      child: Container(
        constraints: BoxConstraints(minHeight: 91.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          image: DecorationImage(
            image: AssetImage(workout.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/svgs/quick_wo.svg',
              width: 34.r,
              height: 34.r,
            ),
            8.verticalSpace,
            Text(
              workout.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.b2b(context).copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
