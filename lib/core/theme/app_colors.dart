import 'package:flutter/material.dart';

/// Semantic colour tokens for the app.
///
/// Widgets never hard-code colours. They read these tokens through
/// `context.colors`, so every screen supports light and dark mode without
/// any per-widget `if (isDark)` checks.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.accentSoft,
    required this.hydration,
    required this.bannerBackground,
    required this.bannerText,
    required this.navBar,
    required this.scrim,
    required this.moodGlow,
    required this.dragHandle,
  });

  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color accentSoft;
  final Color hydration;
  final Color bannerBackground;
  final Color bannerText;
  final Color navBar;
  final Color scrim;
  final Color moodGlow;
  final Color dragHandle;

  static const dark = AppColors(
    background: Color(0xFF000000),
    surface: Color(0xFF18181C),
    surfaceMuted: Color(0xFF18181C),
    border: Color(0xFF2E3034),
    textPrimary: Color(0xFFEBEBEB),
    textSecondary: Color(0xFF7A7C90),
    accent: Color(0xFF20B76F),
    accentSoft: Color(0xFF01A53C),
    hydration: Color(0xFF48A4E5),
    bannerBackground: Color(0xFF1B3D45),
    bannerText: Color(0xFFD7F1F4),
    navBar: Color(0xFF000000),
    scrim: Color(0x99000000),
    moodGlow: Color(0xFF26324A),
    dragHandle: Color(0xFFA1A5B7),
  );

  static const light = AppColors(
    background: Color(0xFFF4F5F7),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFE7E9ED),
    border: Color(0xFFE2E5EA),
    textPrimary: Color(0xFF111418),
    textSecondary: Color(0xFF5B6470),
    accent: Color(0xFF1F8A5B),
    accentSoft: Color(0xFFE3F4EB),
    hydration: Color(0xFF2B6CB0),
    bannerBackground: Color(0xFFDCEFF1),
    bannerText: Color(0xFF0F5561),
    navBar: Color(0xFFFFFFFF),
    scrim: Color(0x61111418),
    moodGlow: Color(0xFFE4EBF7),
    dragHandle: Color(0xFFA1A5B7),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? accentSoft,
    Color? hydration,
    Color? bannerBackground,
    Color? bannerText,
    Color? navBar,
    Color? scrim,
    Color? moodGlow,
    Color? dragHandle,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      hydration: hydration ?? this.hydration,
      bannerBackground: bannerBackground ?? this.bannerBackground,
      bannerText: bannerText ?? this.bannerText,
      navBar: navBar ?? this.navBar,
      scrim: scrim ?? this.scrim,
      moodGlow: moodGlow ?? this.moodGlow,
      dragHandle: dragHandle ?? this.dragHandle,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      hydration: Color.lerp(hydration, other.hydration, t)!,
      bannerBackground: Color.lerp(
        bannerBackground,
        other.bannerBackground,
        t,
      )!,
      bannerText: Color.lerp(bannerText, other.bannerText, t)!,
      navBar: Color.lerp(navBar, other.navBar, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      moodGlow: Color.lerp(moodGlow, other.moodGlow, t)!,
      dragHandle: Color.lerp(dragHandle, other.dragHandle, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

@immutable
class AppPaletteSwatch {
  const AppPaletteSwatch({
    required this.base,
    required this.darkBackground,
    required this.lightForeground,
    required this.lightBackground,
  });

  final Color base;
  final Color darkBackground;
  final Color lightForeground;
  final Color lightBackground;
}

final appPurpleSwatch = AppPaletteSwatch(
  base: const Color(0xFF4855DF),
  darkBackground: const Color(0xFF4855DF).withValues(alpha: 0.17),
  lightForeground: const Color(0xFF4F46C8),
  lightBackground: const Color(0xFFE6E4FA),
);

final appGreenSwatch = AppPaletteSwatch(
  base: const Color(0xFF20B76F),
  darkBackground: const Color(0xFF20B76F).withValues(alpha: 0.17),
  lightForeground: const Color(0xFF1F7A4F),
  lightBackground: const Color(0xFFDDF1E6),
);

const appTealSwatch = AppPaletteSwatch(
  base: Color(0xFF32AAB7),
  darkBackground: Color(0xFF173A3F),
  lightForeground: Color(0xFF0F6D78),
  lightBackground: Color(0xFFD9F0F2),
);

const appOrangeSwatch = AppPaletteSwatch(
  base: Color(0xFFF5B971),
  darkBackground: Color(0xFF41301A),
  lightForeground: Color(0xFF9A5A0B),
  lightBackground: Color(0xFFFBEBD5),
);

const appPinkSwatch = AppPaletteSwatch(
  base: Color(0xFFF59BB8),
  darkBackground: Color(0xFF43202C),
  lightForeground: Color(0xFFB0305C),
  lightBackground: Color(0xFFFBE1EA),
);

const appBlueSwatch = AppPaletteSwatch(
  base: Color(0xFF8DB8F5),
  darkBackground: Color(0xFF1C2C44),
  lightForeground: Color(0xFF2B5FA8),
  lightBackground: Color(0xFFDEE8F8),
);

final List<Color> appAccentPalette = [
  appGreenSwatch.base,
  appPurpleSwatch.base,
  appTealSwatch.base,
];
