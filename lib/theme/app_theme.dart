import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark => _build(Brightness.dark);
  static ThemeData get light => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = isDark ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subtextColor = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final primary = isDark ? AppColors.teal : AppColors.tealDark;

    return base.copyWith(
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: (isDark ? const ColorScheme.dark() : const ColorScheme.light()).copyWith(
        primary: primary,
        secondary: isDark ? AppColors.blue : AppColors.blueDark,
        error: AppColors.error,
        surface: isDark ? AppColors.darkBg2 : Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
      ),
      textTheme: base.textTheme.copyWith(
        displayLarge:  GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700, color: textColor),
        displayMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: textColor),
        displaySmall:  GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: textColor),
        headlineLarge: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: textColor),
        headlineMedium:GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
        headlineSmall: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
        titleLarge:    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
        titleMedium:   GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: textColor),
        bodyLarge:     GoogleFonts.inter(fontSize: 16, color: textColor),
        bodyMedium:    GoogleFonts.inter(fontSize: 14, color: textColor),
        bodySmall:     GoogleFonts.inter(fontSize: 12, color: subtextColor),
        labelLarge:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        foregroundColor: textColor,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkGlass : AppColors.lightGlass,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        labelStyle: GoogleFonts.inter(color: subtextColor, fontSize: 14),
        hintStyle: GoogleFonts.inter(color: isDark ? AppColors.darkMuted : AppColors.lightMuted, fontSize: 14),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.darkBg2 : Colors.white,
        contentTextStyle: GoogleFonts.inter(color: textColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
