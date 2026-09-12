import 'package:flutter/material.dart';
import 'package:harraka/core/widgets/app_Gradient_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_Gradient_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(flex: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.large),
                child: Image.asset(
                  'assets/icons/harraka_app_icon.png',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Harraka',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Groceries at your door\nin 10 minutes',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge,
              ),
              const Spacer(flex: 3),
              AppGradientButton(
                label: 'Get Started',
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteNames.signup),
              ),
              const SizedBox(height: AppSpacing.md),
          //     Row(
          //       spacing: 0,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'Already have an account? ',
          //           style: AppTextStyles.bodyMedium,
          //         ),
          //         TextButton(
          //           child: Text(
          //             'Log in',
          //             style: AppTextStyles.bodyMedium.copyWith(
          //               color: AppColors.primary,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           onPressed: () =>
          //               Navigator.of(context).pushNamed(RouteNames.login),
          //         ),
          //       ],
          //     ),
          //     const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
