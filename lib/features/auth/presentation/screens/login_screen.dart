import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harraka/core/constants/app_text_styles.dart';
import 'package:harraka/core/routing/route_names.dart';
import 'package:harraka/core/utils/validator/email_validator.dart';
import 'package:harraka/core/widgets/app_Gradient_button.dart';
import 'package:harraka/core/widgets/app_text_field.dart';
import 'package:harraka/features/auth/data/models/user_model.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_button.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_text.dart';
import 'package:harraka/features/auth/presentation/widgets/divider_text.dart';
import 'package:harraka/features/auth/presentation/widgets/login_header.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<OtpEmail> login({required String email}) async {
    final repository = ref.read(authRepositoryProvider);

    final res = await repository.login(email);

    print("login response  = $res");

    return res;
  }

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
                  LoginHeader(),
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
                        // AuthPhoneField(
                        //   controller: _phoneController,
                        //   labelText: 'Mobile Number',
                        //   validator: NumberValidator.validate,
                        // ),
                        AppTextField(
                          labelText: 'E-mail Address',
                          keyboardType: TextInputType.text,
                          helperText:
                              "We'll send a 4-digit code to verify it's you",
                          hintText: 'example@gmail.com',
                          controller: _emailController,
                          validator: EmailValidator.validate,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 10,
                          children: [
                            AuthText(
                              helperText: "Continue with number  ",
                              text: "Phone number",
                              routeName: RouteNames.loginWithNumber,
                            ),
                          ],
                        ),
                        AppGradientButton(
                          label: 'Continue',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final email = _emailController.text.trim();
                              // Call the login method
                              final res = await login(email: email);

                              if (mounted) {
                                Navigator.of(context).pushNamed(
                                  RouteNames.otpVerification,
                                  arguments: email,
                                );
                              }
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
