import 'package:flutter/material.dart';
import 'package:harraka/core/constants/app_colors.dart';
import 'package:harraka/core/constants/app_spacing.dart';
import 'package:harraka/core/constants/app_text_styles.dart';
import 'package:harraka/core/utils/validator/email_validator.dart';
import 'package:harraka/core/utils/validator/name_validator.dart';
import 'package:harraka/core/utils/validator/number_validator.dart';
import 'package:harraka/core/widgets/app_Gradient_button.dart';
import 'package:harraka/core/widgets/app_text_field.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_phone_field.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_text.dart';
import '../../../../../core/routing/route_names.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Sign up',
                            style: AppTextStyles.displayLarge,
                            children: [
                              TextSpan(
                                text: '.',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Sign up to start ordering groceries in minutes',
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        AppTextField(
                          controller: _nameController,
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          validator: NameValidator.validate,
                          // prefixIcon: Icons.person_outline,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AuthPhoneField(
                          controller: _phoneController,
                          validator: NumberValidator.validate,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _emailController,
                          labelText: 'Email Address',
                          hintText: 'example@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: EmailValidator.validate,
                          // prefixIcon: Icons.mail_outline,
                        ),
                      ],
                    ),
                  ),
                ),
                // BOTTOM
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    // border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppGradientButton(
                        label: 'Create Account',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                              RouteNames.otpVerification,
                              arguments: _phoneController.text.trim(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AuthText(
                        helperText: 'Already have an account? ',
                        text: 'Log in',
                        routeName: RouteNames.login,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
