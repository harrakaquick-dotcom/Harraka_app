import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

const _backspaceKey = 'backspace';

const _keypadRows = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
  ['', '0', _backspaceKey],
];

/// Custom on-screen numeric keypad that drives OTP entry — the OTP screen
/// never opens the system keyboard, matching the reference design.
class OtpKeypad extends StatelessWidget {
  const OtpKeypad({super.key, required this.onKeyTap, required this.onBackspace});

  final ValueChanged<String> onKeyTap;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _keypadRows.map(_buildRow).toList(),
    );
  }

  Widget _buildRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(children: keys.map((key) => Expanded(child: _buildKey(key))).toList()),
    );
  }

  Widget _buildKey(String key) {
    if (key.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          onTap: key == _backspaceKey ? onBackspace : () => onKeyTap(key),
          child: SizedBox(
            height: 56,
            child: Center(
              child: key == _backspaceKey
                  ? const Icon(Icons.backspace_outlined, color: AppColors.textPrimary, size: 20)
                  : Text(key, style: AppTextStyles.headingMedium),
            ),
          ),
        ),
      ),
    );
  }
}
