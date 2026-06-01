import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF185ABC);
  static const Color secondary = Color(0xFF00BFA6);
  static const Color background = Color(0xFFF4F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFD7E1EB);
  static const Color textPrimary = Color(0xFF102A43);
  static const Color textSecondary = Color(0xFF52667A);
  static const Color textHint = Color(0xFF7A8A99);
  static const Color disabled = Color(0xFFB0BEC5);
  static const Color error = Color(0xFFB00020);
}

class AppBorderRadius {
  AppBorderRadius._();

  static const double small = 10.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

class AppShadow {
  AppShadow._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color.fromRGBO(20, 33, 61, 0.08),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color.fromRGBO(20, 33, 61, 0.05),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];
}

class AppSpacing {
  AppSpacing._();

  static const double baseWidth = 375.0;
  static const double baseHeight = 812.0;

  static double scaleWidth(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;
    return value * width / baseWidth;
  }

  static double scaleHeight(BuildContext context, double value) {
    final height = MediaQuery.of(context).size.height;
    return value * height / baseHeight;
  }

  static double font(BuildContext context, double value) {
    return scaleWidth(context, value);
  }

  static EdgeInsets all(BuildContext context, double value) {
    final scaled = scaleHeight(context, value);
    return EdgeInsets.all(scaled);
  }

  static EdgeInsets symmetric(
    BuildContext context, {
    double vertical = 0,
    double horizontal = 0,
  }) {
    return EdgeInsets.symmetric(
      vertical: scaleHeight(context, vertical),
      horizontal: scaleWidth(context, horizontal),
    );
  }

  static EdgeInsets only(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: scaleWidth(context, left),
      top: scaleHeight(context, top),
      right: scaleWidth(context, right),
      bottom: scaleHeight(context, bottom),
    );
  }

  static SizedBox verticalGap(BuildContext context, double size) {
    return SizedBox(height: scaleHeight(context, size));
  }

  static SizedBox horizontalGap(BuildContext context, double size) {
    return SizedBox(width: scaleWidth(context, size));
  }
}

class AppTypography {
  AppTypography._();

  static TextStyle heading(BuildContext context) {
    return TextStyle(
      fontSize: AppSpacing.font(context, 24),
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.3,
    );
  }

  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontSize: AppSpacing.font(context, 20),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.3,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: AppSpacing.font(context, 16),
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    );
  }

  static TextStyle label(BuildContext context) {
    return TextStyle(
      fontSize: AppSpacing.font(context, 14),
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontSize: AppSpacing.font(context, 15),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    );
  }

  static TextStyle input(BuildContext context) {
    return TextStyle(
      fontSize: AppSpacing.font(context, 15),
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.surface,
      canvasColor: AppColors.background,
      dividerColor: AppColors.border,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.background,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.textPrimary),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
