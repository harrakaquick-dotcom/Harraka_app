import 'package:flutter/material.dart';
import 'package:harraka/core/constants/app_text_styles.dart';
import 'package:harraka/core/routing/route_names.dart';
import 'package:harraka/core/widgets/app_Gradient_button.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_button.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_phone_field.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_text.dart';
import 'package:harraka/features/auth/presentation/widgets/divider_text.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/validator/number_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      spacing: AppSpacing.lg,
                      children: [
                        AuthPhoneField(
                          labelText: 'Mobile Number',
                          validator: NumberValidator.validate,
                        ),
                        AppGradientButton(
                          label: 'Continue',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushNamed(RouteNames.home);
                            }
                          },
                        ),
                        DividerText(text: 'OR'),
                        AuthButton(
                          label: 'Continue with Google',
                          onPressed: () {},
                        ),
                        AuthText(
                          helperText: 'New to Harraka? ',
                          text: 'Create account',
                          routeName: RouteNames.signup,
                        ),
                        Text(
                          'By continuing you agree to our Terms of Service and Privacy Policy',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
