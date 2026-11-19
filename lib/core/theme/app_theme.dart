import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';

/// Single source of truth for the app's Material 3 theming.
///
/// "Royal" identity: deep indigo/obsidian (dark) or warm ivory/parchment
/// (light) base, with royal gold as the primary accent and amethyst as
/// the secondary accent — deliberately not another blue/red gadget UI.
///
/// Typography pairing:
///  • Outfit  — headings, titles, numeric readouts (geometric, premium)
///  • Inter   — body copy, labels (highly legible at small sizes)
class AppTheme {
  AppTheme._();

  // Build the Flutter TextTheme directly. Using GoogleFonts.*TextTheme here
  // crosses TextTheme types in the resolved material_ui/google_fonts stack.
  // Applying GoogleFonts to individual Flutter TextStyles avoids that clash.
  static TextTheme _textTheme(TextTheme base, Color primaryText) {
    TextStyle? outfit(TextStyle? style, {
      FontWeight weight = FontWeight.w600,
      double? letterSpacing,
    }) =>
        GoogleFonts.outfit(
          textStyle: style?.copyWith(
            fontWeight: weight,
            letterSpacing: letterSpacing,
            color: primaryText,
          ),
        );

    TextStyle? inter(TextStyle? style, {double? height}) =>
        GoogleFonts.inter(
          textStyle: style?.copyWith(height: height, color: primaryText),
        );

    return base.copyWith(
      displayLarge: outfit(base.displayLarge, letterSpacing: -0.5),
      displayMedium: outfit(base.displayMedium, letterSpacing: -0.5),
      displaySmall: outfit(base.displaySmall),
      headlineLarge: outfit(base.headlineLarge),
      headlineMedium: outfit(base.headlineMedium),
      headlineSmall: outfit(base.headlineSmall),
      titleLarge: outfit(base.titleLarge, letterSpacing: 0.1),
      titleMedium: outfit(base.titleMedium),
      titleSmall: outfit(base.titleSmall, weight: FontWeight.w500),
      bodyLarge: inter(base.bodyLarge, height: 1.4),
      bodyMedium: inter(base.bodyMedium, height: 1.4),
      bodySmall: inter(base.bodySmall, height: 1.3),
      labelLarge: outfit(base.labelLarge, letterSpacing: 0.4),
      labelMedium: outfit(base.labelMedium, letterSpacing: 0.6),
      labelSmall: outfit(base.labelSmall, weight: FontWeight.w500, letterSpacing: 0.8),
    );
  }

  static ThemeData _build(AppPalette palette, Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = isDark
        ? ColorScheme.dark(
            brightness: Brightness.dark,
            primary: palette.gold,
            onPrimary: const Color(0xFF241A02),
            secondary: palette.amethyst,
            onSecondary: const Color(0xFF1B0F35),
            tertiary: palette.emerald,
            surface: palette.surface,
            onSurface: palette.textPrimary,
            error: palette.statusEmergency,
            onError: Colors.white,
            outline: palette.glassStroke,
          )
        : ColorScheme.light(
            brightness: Brightness.light,
            primary: palette.gold,
            onPrimary: Colors.white,
            secondary: palette.amethyst,
            onSecondary: Colors.white,
            tertiary: palette.emerald,
            surface: palette.surface,
            onSurface: palette.textPrimary,
            error: palette.statusEmergency,
            onError: Colors.white,
            outline: palette.glassStroke,
          );

    final base = ThemeData(brightness: brightness, useMaterial3: true);

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.backgroundGradient.first,
      textTheme: _textTheme(base.textTheme, palette.textPrimary),
      splashFactory: InkRipple.splashFactory,
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: palette.textPrimary,
          letterSpacing: 0.2,
        ),
        iconTheme: IconThemeData(color: palette.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          side: BorderSide(color: palette.glassStroke, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: palette.divider,
        thickness: 1,
        space: 1,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: palette.gold,
        inactiveTrackColor: palette.glassFill,
        thumbColor: Colors.white,
        overlayColor: palette.gold.withValues(alpha: 0.15),
        trackHeight: 4,
        valueIndicatorColor: palette.surfaceHigh,
        valueIndicatorTextStyle: GoogleFonts.outfit(
          color: palette.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? palette.gold
              : palette.textTertiary,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? palette.gold.withValues(alpha: 0.35)
              : palette.glassFill,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.gold,
          foregroundColor: isDark ? const Color(0xFF241A02) : Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.textPrimary,
          side: BorderSide(color: palette.glassStroke, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: palette.gold,
        unselectedItemColor: palette.textTertiary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.surfaceHigh,
        contentTextStyle: GoogleFonts.inter(color: palette.textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.surfaceHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
      ),
    );
  }

  static ThemeData get dark => _build(AppPalette.dark, Brightness.dark);
  static ThemeData get light => _build(AppPalette.light, Brightness.light);
}
