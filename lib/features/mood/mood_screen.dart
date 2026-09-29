import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/button/app_button.dart';
import 'mood_controller.dart';
import 'widgets/mood_wheel.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key, required this.onSubmitted});

  final VoidCallback onSubmitted;

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<MoodController>();
    final messenger = ScaffoldMessenger.of(context);
    final label = controller.mood.label;
    await controller.submit();
    messenger.showSnackBar(SnackBar(content: Text('Mood logged: $label')));
    onSubmitted();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MoodController>();
    final c = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.background,
        gradient: isDark
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, 0.1),
                colors: [c.moodGlow, c.background],
              ),
        image: isDark
            ? const DecorationImage(
                image: AssetImage('assets/pngs/Mood_bg.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              Text('Mood', style: AppTypography.display(context)),
              32.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start your day', style: AppTypography.h4(context)),
                    SizedBox(height: 8.h),
                    Text(
                      'How are you feeling at the Moment?',
                      style: AppTypography.h2sb(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wheelSize = math.min(
                      281.0.h,
                      math.max(140.0.h, constraints.maxHeight - 70.h),
                    );
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        38.verticalSpace,
                        MoodWheel(
                          size: wheelSize,
                          degrees: controller.degrees,
                          mood: controller.mood,
                          onChanged: controller.updateDegrees,
                          onSelectMood: controller.select,
                        ),
                        24.verticalSpace,
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            controller.mood.label,
                            key: ValueKey(controller.mood),
                            style: AppTypography.h1bm(context),
                          ),
                        ),
                        SizedBox(width: double.infinity),
                      ],
                    );
                  },
                ),
              ),
              AppButton(
                label: 'Continue',
                onPressed: () => _submit(context),
                isDisabled: controller.isSubmitting,
                backgroundColor: c.textPrimary,
                textColor: c.background,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
