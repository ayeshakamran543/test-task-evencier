import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final c = context.colors;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
        children: [
          Text('Profile', style: AppTypography.h1bm(context)),
          24.verticalSpace,
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: c.accentSoft,
                  child: Icon(Icons.person, color: c.textPrimary),
                ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Guest athlete', style: AppTypography.h5sb(context)),
                    SizedBox(height: 2.h),
                    Text(
                      '8-week training plan',
                      style: AppTypography.b2(
                        context,
                      ).copyWith(color: c.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 28.h),
          Text('Appearance', style: AppTypography.b1sb(context)),
          SizedBox(height: 12.h),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto_outlined),
                label: Text('System'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
                label: Text('Light'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
                label: Text('Dark'),
              ),
            ],
            selected: {theme.mode},
            onSelectionChanged: (selection) => theme.setMode(selection.first),
          ),
          SizedBox(height: 8.h),
          Text(
            'System follows your device setting. Your choice is saved.',
            style: AppTypography.l1(context).copyWith(color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}
