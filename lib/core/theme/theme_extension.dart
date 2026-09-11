import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Custom theme tokens not covered by [ThemeData], accessible via
/// `Theme.of(context).extension<AppThemeExtension>()`.
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.success,
    required this.successLight,
    required this.warning,
  });

  final Color success;
  final Color successLight;
  final Color warning;

  static const light = AppThemeExtension(
    success: AppColors.secondary,
    successLight: AppColors.secondaryLight,
    warning: AppColors.warning,
  );

  @override
  AppThemeExtension copyWith({
    Color? success,
    Color? successLight,
    Color? warning,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
