import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Single digit box in the OTP entry row.
///
/// Works with the system keyboard: accepts one numeric digit, auto-advances
/// via [onChanged], and reports backspace-to-previous through the same
/// callback (empty value => move focus back).
class OtpBoxField extends StatelessWidget {
  const OtpBoxField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.filled,
    required this.autofocus,
    required this.onChanged,
    required this.textInputAction,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool filled;
  final bool autofocus;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 68,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        textInputAction: textInputAction,
        textAlign: TextAlign.center,
        cursorColor: AppColors.primary,
        cursorWidth: 2,
        showCursor: true,
        // NOTE: no maxLength / LengthLimiting here on purpose — paste of the
        // full code must reach onChanged so the screen can distribute digits
        // across boxes. Single-char limit is enforced in _onChanged instead.
        autofillHints: const [AutofillHints.oneTimeCode],
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyles.headingLarge.copyWith(fontSize: 24),
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
            borderSide: BorderSide(
              color: filled ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
          ),
        ),
        onChanged: onChanged,
        onTap: () {
          // Place cursor at end so re-tapping a filled box replaces cleanly.
          controller.selection = TextSelection.collapsed(
            offset: controller.text.length,
          );
        },
      ),
    );
  }
}
