import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/daily_insights.dart';

class _InsightTile extends StatelessWidget {
  const _InsightTile({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: child,
    );
  }
}

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key, required this.insights});

  final DailyInsights insights;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final small = AppTypography.l1sb(context).copyWith(color: c.textSecondary);
    return _InsightTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${insights.consumedCalories}',
                  style: AppTypography.displaysb(context),
                ),
                TextSpan(text: ' Calories', style: AppTypography.h4b(context)),
              ],
            ),
          ),
          Text(
            '${insights.remainingCalories} Remaining',
            style: AppTypography.b2bm(context).copyWith(color: c.textSecondary),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: small),
              Text('${insights.calorieGoal}', style: small),
            ],
          ),
          8.verticalSpace,
          TweenAnimationBuilder<double>(
            tween: Tween(end: insights.calorieProgress.clamp(0.0, 1.0)),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => Container(
              height: 6.h,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFF464646),
                borderRadius: BorderRadius.circular(3.r),
              ),
              child: FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7BBDE2), Color(0xFF69C0B1)],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeightCard extends StatelessWidget {
  const WeightCard({super.key, required this.insights});

  final DailyInsights insights;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final change = insights.weightChangeKg;
    final gained = change >= 0;
    final weight = insights.weightKg % 1 == 0
        ? insights.weightKg.toStringAsFixed(0)
        : insights.weightKg.toStringAsFixed(1);

    return _InsightTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: weight, style: AppTypography.displaybm(context)),
                TextSpan(
                  text: 'kg',
                  style: AppTypography.b1bm(
                    context,
                  ).copyWith(color: c.textPrimary),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 15.r,
                height: 15.r,
                decoration: const BoxDecoration(
                  color: Color(0xFF154124),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  gained ? Icons.north_east : Icons.south_east,
                  size: 9.r,
                  color: c.accentSoft,
                ),
              ),
              4.horizontalSpace,
              Text(
                '${gained ? '+' : ''}${change.toStringAsFixed(1)}kg',
                style: AppTypography.b2bm(
                  context,
                ).copyWith(color: c.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          Text('Weight', style: AppTypography.b2bm(context)),
        ],
      ),
    );
  }
}
