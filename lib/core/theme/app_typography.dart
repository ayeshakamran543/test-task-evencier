import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// Centralized text style scale for the app.
///
/// Each style defaults its color to `context.colors.textPrimary`. Override
/// via `.copyWith(color: ...)` when a screen needs a different color (e.g.
/// `context.colors.textSecondary`).
///
/// Each size step exposes up to four weight variants:
///   - base   (no suffix)  — regular, w400
///   - `bm`   suffix       — medium, w500
///   - `sb`   suffix       — semibold, w600
///   - `b`    suffix       — bold, w700
class AppTypography {
  AppTypography._();

  static const _family = 'Mulish';

  static TextStyle _style(
    BuildContext context,
    double size,
    FontWeight weight,
  ) => TextStyle(
    fontFamily: _family,
    fontSize: size.sp,
    fontWeight: weight,
    letterSpacing: 0,
    color: context.colors.textPrimary,
  );

  // ---------------- DISPLAY ----------------
  // Large stat figures (e.g. hydration amount, insight numbers). Base 32.

  static TextStyle display(BuildContext context) =>
      _style(context, 32, FontWeight.w400);
  static TextStyle displaybm(BuildContext context) =>
      _style(context, 32, FontWeight.w500);
  static TextStyle displaysb(BuildContext context) =>
      _style(context, 32, FontWeight.w600);
  static TextStyle displayb(BuildContext context) =>
      _style(context, 32, FontWeight.w700);

  // ---------------- HEADINGS ----------------

  /// Page title (e.g. Profile, Mood). Base 28.
  static TextStyle h1(BuildContext context) =>
      _style(context, 28, FontWeight.w400);
  static TextStyle h1bm(BuildContext context) =>
      _style(context, 28, FontWeight.w500);
  static TextStyle h1sb(BuildContext context) =>
      _style(context, 28, FontWeight.w600);
  static TextStyle h1b(BuildContext context) =>
      _style(context, 28, FontWeight.w700);

  /// Large emphasis heading (e.g. selected mood emoji). Base 24.
  static TextStyle h2(BuildContext context) =>
      _style(context, 24, FontWeight.w400);
  static TextStyle h2bm(BuildContext context) =>
      _style(context, 24, FontWeight.w500);
  static TextStyle h2sb(BuildContext context) =>
      _style(context, 24, FontWeight.w600);
  static TextStyle h2b(BuildContext context) =>
      _style(context, 24, FontWeight.w700);

  /// Section title. Base 20.
  static TextStyle h3(BuildContext context) =>
      _style(context, 20, FontWeight.w400);
  static TextStyle h3bm(BuildContext context) =>
      _style(context, 20, FontWeight.w500);
  static TextStyle h3sb(BuildContext context) =>
      _style(context, 20, FontWeight.w600);
  static TextStyle h3b(BuildContext context) =>
      _style(context, 20, FontWeight.w700);

  /// Screen greeting/header. Base 18.
  static TextStyle h4(BuildContext context) =>
      _style(context, 18, FontWeight.w400);
  static TextStyle h4bm(BuildContext context) =>
      _style(context, 18, FontWeight.w500);
  static TextStyle h4sb(BuildContext context) =>
      _style(context, 18, FontWeight.w600);
  static TextStyle h4b(BuildContext context) =>
      _style(context, 18, FontWeight.w700);

  /// Sub-heading. Base 17.
  static TextStyle h5(BuildContext context) =>
      _style(context, 17, FontWeight.w400);
  static TextStyle h5bm(BuildContext context) =>
      _style(context, 17, FontWeight.w500);
  static TextStyle h5sb(BuildContext context) =>
      _style(context, 17, FontWeight.w600);
  static TextStyle h5b(BuildContext context) =>
      _style(context, 17, FontWeight.w700);

  // ---------------- BODY ----------------

  /// Prominent body / row title. Base 16.
  static TextStyle b1(BuildContext context) =>
      _style(context, 16, FontWeight.w400);
  static TextStyle b1bm(BuildContext context) =>
      _style(context, 16, FontWeight.w500);
  static TextStyle b1sb(BuildContext context) =>
      _style(context, 16, FontWeight.w600);
  static TextStyle b1b(BuildContext context) =>
      _style(context, 16, FontWeight.w700);

  /// Default body / secondary text (e.g. subtitle, chip, tab, card-title
  /// text). Base 14.
  static TextStyle b2(BuildContext context) =>
      _style(context, 14, FontWeight.w400);
  static TextStyle b2bm(BuildContext context) =>
      _style(context, 14, FontWeight.w500);
  static TextStyle b2sb(BuildContext context) =>
      _style(context, 14, FontWeight.w600);
  static TextStyle b2b(BuildContext context) =>
      _style(context, 14, FontWeight.w700);

  // ---------------- LABELS ----------------

  /// Default caption text. Base 12.
  static TextStyle l1(BuildContext context) =>
      _style(context, 12, FontWeight.w400);
  static TextStyle l1bm(BuildContext context) =>
      _style(context, 12, FontWeight.w500);
  static TextStyle l1sb(BuildContext context) =>
      _style(context, 12, FontWeight.w600);
  static TextStyle l1b(BuildContext context) =>
      _style(context, 12, FontWeight.w700);

  /// Secondary/meta text, nav icons. Base 11.
  static TextStyle l2(BuildContext context) =>
      _style(context, 11, FontWeight.w400);
  static TextStyle l2bm(BuildContext context) =>
      _style(context, 11, FontWeight.w500);
  static TextStyle l2sb(BuildContext context) =>
      _style(context, 11, FontWeight.w600);
  static TextStyle l2b(BuildContext context) =>
      _style(context, 11, FontWeight.w700);

  /// Tiny label (e.g. calendar weekday header). Base 10.
  static TextStyle l3(BuildContext context) =>
      _style(context, 10, FontWeight.w400);
  static TextStyle l3bm(BuildContext context) =>
      _style(context, 10, FontWeight.w500);
  static TextStyle l3sb(BuildContext context) =>
      _style(context, 10, FontWeight.w600);
  static TextStyle l3b(BuildContext context) =>
      _style(context, 10, FontWeight.w700);

  /// Smallest label (e.g. unit text). Base 9.
  static TextStyle l4(BuildContext context) =>
      _style(context, 9, FontWeight.w400);
  static TextStyle l4bm(BuildContext context) =>
      _style(context, 9, FontWeight.w500);
  static TextStyle l4sb(BuildContext context) =>
      _style(context, 9, FontWeight.w600);
  static TextStyle l4b(BuildContext context) =>
      _style(context, 9, FontWeight.w700);
}
