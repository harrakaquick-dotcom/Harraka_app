import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class SavedAddressTile extends StatelessWidget {
  const SavedAddressTile({
    super.key,
    required this.label,
    required this.etaMinutes,
    required this.addressLine,
    this.onTap,
  });

  final String label;
  final int etaMinutes;
  final String addressLine;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.location_on, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: label,
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: '  •  $etaMinutes min',
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    addressLine,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
