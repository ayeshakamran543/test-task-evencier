import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_typography.dart';
import 'schedule_controller.dart';
import 'widgets/week_section.dart';

class TrainingCalendarScreen extends StatelessWidget {
  const TrainingCalendarScreen({super.key});

  Future<void> _save(BuildContext context) async {
    final schedule = context.read<ScheduleController>();
    final messenger = ScaffoldMessenger.of(context);
    try {
      await schedule.save();
      messenger.showSnackBar(
        const SnackBar(content: Text('Training plan saved')),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Couldn't save. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final schedule = context.watch<ScheduleController>();

    final canSave = schedule.hasUnsavedChanges && !schedule.isSaving;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Training Calendar',
                        style: AppTypography.h2(context),
                      ),
                    ],
                  ),
                ),
                if (schedule.hasUnsavedChanges)
                  GestureDetector(
                    onTap: canSave ? () => _save(context) : null,
                    child: Text('Save', style: AppTypography.h4b(context)),
                  ),
              ],
            ),
          ),

          Expanded(
            child: schedule.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 24.h),
                    itemCount: schedule.weeks.length,
                    itemBuilder: (context, index) {
                      final week = schedule.weeks[index];
                      return WeekSection(
                        key: ValueKey(week.number),
                        week: week,
                        initiallyExpanded: week.contains(schedule.today),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
