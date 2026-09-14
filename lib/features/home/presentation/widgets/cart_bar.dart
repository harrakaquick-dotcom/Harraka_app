import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class CartBar extends StatelessWidget {
  const CartBar({super.key, required this.itemCount, required this.itemTotal, required this.onTap});

  final int itemCount;
  final int itemTotal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.textPrimary,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$itemCount items',
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '₹$itemTotal',
                    style: AppTextStyles.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View cart ',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  const Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
