import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 60,
        left: 20,
        bottom: 30,
      ),
      color: AppColors.primary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          Image.asset(
            'assets/icons/harraka_app_splash.png',
            height: 80,
            width: 80,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Log in to Harraka',
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.background,
            ),
          ),
          Text(
            'Groceries at your door in 10 minutes',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.border,
            ),
          ),
        ],
      ),
    );
  }
}
