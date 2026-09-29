import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

/// The pill-shaped drag handle shown at the top of modal bottom sheets.
class SheetDragHandle extends StatelessWidget {
  const SheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(
        child: Container(
          width: 58.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: context.colors.dragHandle,
            borderRadius: BorderRadius.circular(10.53.r),
          ),
        ),
      ),
    );
  }
}
