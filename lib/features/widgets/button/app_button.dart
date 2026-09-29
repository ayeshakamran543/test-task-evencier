import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

part 'app_button_enums.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.buttonType = ButtonType.primary,
    this.isDisabled = false,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
  });

  final String label;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final bool isDisabled;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;

  bool get _isOutlined => buttonType == ButtonType.outlined;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fill = backgroundColor ?? colors.accent;

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height ?? 50.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isDisabled
              ? colors.surfaceMuted
              : _isOutlined
              ? Colors.transparent
              : fill,
          border: _isOutlined
              ? Border.all(color: isDisabled ? colors.border : fill)
              : null,
        ),
        child: Text(
          label,
          style: (textStyle ?? AppTypography.b1bm(context)).copyWith(
            color: isDisabled
                ? colors.textSecondary
                : textColor ??
                      (_isOutlined ? colors.textPrimary : Colors.white),
          ),
        ),
      ),
    );
  }
}
