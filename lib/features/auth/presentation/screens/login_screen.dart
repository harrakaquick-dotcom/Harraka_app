import 'package:flutter/material.dart';
import 'package:harraka/features/auth/presentation/widgets/auth_phone_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/validator/number_validator.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 600,
            color: AppColors.primary,
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(children: [Text('login')]),
          ),
        ),
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthPhoneField(
                labelText: "enter phone",
                validator: NumberValidator.validate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
