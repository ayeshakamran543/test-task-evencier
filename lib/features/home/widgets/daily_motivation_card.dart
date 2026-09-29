import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// A motivational quote card shown below the home screen's insights.
class DailyMotivationCard extends StatelessWidget {
  const DailyMotivationCard({
    super.key,
    this.message =
        'Push yourself because no one else is going to do it for you!',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFF303135), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/svgs/Daily_motivation.svg',
            width: 45.r,
            height: 45.r,
          ),
          24.verticalSpace,
          Text(
            'Daily Motivation',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
          ),
          8.verticalSpace,
          Text(message, style: AppTypography.h4bm(context)),
        ],
      ),
    );
  }
}
