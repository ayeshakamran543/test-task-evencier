import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/utils/app_dates.dart';
import '../plan/schedule_controller.dart';
import 'home_controller.dart';
import 'widgets/blogs_section.dart';
import 'widgets/daily_motivation_card.dart';
import 'widgets/hydration_card.dart';
import 'widgets/insight_cards.dart';
import 'widgets/month_calendar_sheet.dart';
import 'widgets/quick_workout_grid.dart';
import 'widgets/week_strip.dart';
import 'widgets/workout_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onNavigateToPlan});

  final VoidCallback onNavigateToPlan;

  static TextStyle _sectionTitle(BuildContext context) =>
      AppTypography.h2b(context);

  Future<void> _openCalendar(BuildContext context) async {
    final home = context.read<HomeController>();
    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (_) =>
          MonthCalendarSheet(selected: home.selectedDay, today: home.today),
    );
    if (picked != null) home.selectDay(picked);
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeController>();
    final schedule = context.watch<ScheduleController>();
    final c = context.colors;
    final day = home.selectedDay;
    final workouts = schedule.workoutsOn(day);
    final insights = home.insights;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
            child: _Header(
              weekLabel: schedule.isLoading
                  ? ''
                  : 'Week ${schedule.weekNumberFor(day)}/${schedule.totalWeeks}',
              onWeekTap: () => _openCalendar(context),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: home.load,
              child: ListView(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                children: [
                  Text(
                    AppDates.headline(day, home.today),
                    style: AppTypography.b1b(context),
                  ),
                  16.verticalSpace,
                  WeekStrip(
                    selected: day,
                    today: home.today,
                    hasWorkout: (d) => schedule.workoutsOn(d).isNotEmpty,
                    onSelected: home.selectDay,
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text('Workouts', style: _sectionTitle(context)),
                      ),
                      const _ThemeToggle(),
                      if (home.temperature != null) ...[
                        SizedBox(width: 8.w),
                        Text(
                          '${home.temperature}°',
                          style: AppTypography.h2bm(context),
                        ),
                      ],
                    ],
                  ),
                  24.verticalSpace,
                  if (schedule.isLoading)
                    _LoadingBlock(height: 76.h)
                  else if (workouts.isEmpty)
                    const RestDayCard()
                  else
                    for (final workout in workouts)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: WorkoutCard(
                          workout: workout,
                          onTap: onNavigateToPlan,
                        ),
                      ),
                  32.verticalSpace,
                  Text('My Insights', style: _sectionTitle(context)),
                  24.verticalSpace,
                  if (insights == null && home.error != null)
                    _ErrorBlock(onRetry: home.load)
                  else if (insights == null)
                    _LoadingBlock(height: 260.h)
                  else ...[
                    SizedBox(
                      height: 152.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: CaloriesCard(insights: insights)),
                          12.horizontalSpace,
                          Expanded(child: WeightCard(insights: insights)),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    HydrationCard(
                      insights: insights,
                      lastLoggedMl: home.lastLoggedMl,
                      onLog: () => home.logWater(500),
                    ),
                  ],
                  32.verticalSpace,
                  const DailyMotivationCard(),
                  32.verticalSpace,
                  Text('Quick Workout', style: _sectionTitle(context)),
                  16.verticalSpace,
                  const QuickWorkoutGrid(),
                  32.verticalSpace,
                  Text('Blogs', style: _sectionTitle(context)),
                  16.verticalSpace,
                  const BlogsSection(),
                  32.verticalSpace,
                  if (!AppDates.isSameDay(day, home.today)) ...[
                    16.verticalSpace,
                    Center(
                      child: TextButton(
                        onPressed: () => home.selectDay(home.today),
                        style: TextButton.styleFrom(foregroundColor: c.accent),
                        child: const Text('Back to today'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.weekLabel, required this.onWeekTap});

  final String weekLabel;
  final VoidCallback onWeekTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(
            'assets/svgs/bell.svg',
            width: 24.r,
            height: 24.r,
            colorFilter: ColorFilter.mode(
              context.colors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: onWeekTap,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/pie.svg',
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      context.colors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  4.horizontalSpace,
                  Text(
                    weekLabel,
                    style: AppTypography.b2bm(context).copyWith(
                      inherit: false,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20.sp,
                    color: context.colors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Balances the notification bell so the week label stays centered.
        SizedBox(width: 48.w),
      ],
    );
  }
}

/// Toggles light/dark mode. Lives next to the "Workouts" temperature
/// reading rather than the app bar.
class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () =>
          context.read<ThemeController>().toggle(Theme.of(context).brightness),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) =>
            RotationTransition(turns: animation, child: child),
        child: SvgPicture.asset(
          isDark ? 'assets/svgs/sun.svg' : 'assets/svgs/moon.svg',
          key: ValueKey(isDark),
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            context.colors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _LoadingBlock extends StatelessWidget {
  const _LoadingBlock({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}

class _ErrorBlock extends StatelessWidget {
  const _ErrorBlock({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          const Expanded(child: Text("Couldn't load your insights.")),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
