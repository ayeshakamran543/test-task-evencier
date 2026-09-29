import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/daily_insights.dart';

class HydrationCard extends StatelessWidget {
  const HydrationCard({
    super.key,
    required this.insights,
    required this.lastLoggedMl,
    required this.onLog,
  });

  final DailyInsights insights;
  final int? lastLoggedMl;
  final VoidCallback onLog;

  static String _litres(int ml) {
    final litres = ml / 1000;
    return litres % 1 == 0
        ? '${litres.toStringAsFixed(0)} L'
        : '${litres.toStringAsFixed(1)} L';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
            child: SizedBox(
              height: 124.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(end: insights.hydrationProgress),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) => Text(
                            '${(value * 100).round()}%',
                            style: AppTypography.displayb(
                              context,
                            ).copyWith(color: c.hydration),
                          ),
                        ),
                        const Spacer(),
                        Text('Hydration', style: AppTypography.h4b(context)),
                        GestureDetector(
                          onTap: onLog,
                          child: Text(
                            'Log Now',
                            style: AppTypography.l1(
                              context,
                            ).copyWith(color: c.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _litres(insights.waterGoalMl),
                              style: AppTypography.l3sb(
                                context,
                              ).copyWith(color: c.textPrimary),
                            ),
                            Text(
                              '0 L',
                              style: AppTypography.l3sb(
                                context,
                              ).copyWith(color: c.textPrimary),
                            ),
                          ],
                        ),
                        SizedBox(width: 8.w),
                        TweenAnimationBuilder<double>(
                          tween: Tween(end: insights.hydrationProgress),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) => CustomPaint(
                            size: Size(12.w, double.infinity),
                            painter: _GaugePainter(
                              progress: value,
                              track: c.hydration.withValues(alpha: 0.35),
                              fill: c.hydration,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(bottom: 2.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: c.border),
                              ),
                            ),
                            child: Text(
                              '${insights.waterMl}ml',
                              style: AppTypography.l1(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: c.bannerBackground,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Text(
              '${lastLoggedMl ?? 500} ml added to water log',
              textAlign: TextAlign.center,
              style: AppTypography.l1(context).copyWith(color: c.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.progress,
    required this.track,
    required this.fill,
  });

  final double progress;
  final Color track;
  final Color fill;

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width / 2;
    final trackPaint = Paint()
      ..color = track
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (double y = 0; y < size.height; y += 6) {
      final end = y + 2 > size.height ? size.height : y + 2;
      canvas.drawLine(Offset(x, y), Offset(x, end), trackPaint);
    }

    final tickPaint = Paint()..color = fill;
    for (final t in const [0.0, 0.5, 1.0]) {
      final y = (size.height - 3) * (1 - t);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, y, size.width, 3),
          const Radius.circular(2),
        ),
        tickPaint,
      );
    }

    if (progress > 0) {
      final fillPaint = Paint()
        ..color = fill
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x, size.height * (1 - progress)),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.progress != progress || old.track != track || old.fill != fill;
}
