import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

/// A single digit box in an OTP entry row. Purely presentational — the
/// caller drives its content and focus (see `OtpScreen` + `OtpKeypad`);
/// this widget never receives text input directly.
class OtpBoxField extends StatelessWidget {
  const OtpBoxField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.filled,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: true,
        showCursor: false,
        textAlign: TextAlign.center,
        style: AppTextStyles.headingLarge,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: filled ? AppColors.primaryLight : AppColors.surface,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
