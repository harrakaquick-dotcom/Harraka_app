import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_Gradient_button.dart';
import '../widgets/otp_box_field.dart';
import '../widgets/otp_keypad.dart';

const _otpLength = 4;
const _resendSeconds = 30;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controllers = List.generate(_otpLength, (_) => TextEditingController());
  final _focusNodes = List.generate(_otpLength, (_) => FocusNode());

  Timer? _resendTimer;
  int _secondsLeft = _resendSeconds;

  @override
  void initState() {
    super.initState();
    _focusNodes.first.requestFocus();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _secondsLeft = _resendSeconds);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  int get _activeIndex {
    final firstEmpty = _controllers.indexWhere((c) => c.text.isEmpty);
    return firstEmpty == -1 ? _otpLength - 1 : firstEmpty;
  }

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  void _onKeyTap(String digit) {
    final index = _activeIndex;
    if (_isComplete) return;

    setState(() => _controllers[index].text = digit);

    if (index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _onBackspace() {
    var index = _focusNodes.indexWhere((node) => node.hasFocus);
    if (index == -1) index = _activeIndex;

    if (_controllers[index].text.isEmpty && index > 0) {
      index--;
      _focusNodes[index].requestFocus();
    }
    setState(() => _controllers[index].text = '');
  }

  void _clear() {
    setState(() {
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _focusNodes.first.requestFocus();
  }

  void _verify() {
    if (!_isComplete) return;
    Navigator.of(context).pushReplacementNamed(RouteNames.home);
  }

  String get _maskedPhone {
    final phone = widget.phoneNumber;
    if (phone.length < 5) return phone;
    return '${phone.substring(0, 2)}••• ••${phone.substring(phone.length - 3)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Text('Verify your number', style: AppTextStyles.headingLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'We sent a $_otpLength-digit code to +91 $_maskedPhone',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: List.generate(_otpLength, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == _otpLength - 1 ? 0 : AppSpacing.sm,
                    ),
                    child: OtpBoxField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      filled: _controllers[index].text.isNotEmpty,
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _secondsLeft == 0 ? _startResendTimer : null,
                    child: Text(
                      _secondsLeft > 0
                          ? 'Resend code in 0:${_secondsLeft.toString().padLeft(2, '0')}'
                          : 'Resend code',
                      style: AppTextStyles.caption.copyWith(
                        color: _secondsLeft > 0 ? AppColors.textSecondary : AppColors.primary,
                        fontWeight: _secondsLeft > 0 ? FontWeight.normal : FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _clear,
                    child: Text(
                      'Clear',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              OtpKeypad(onKeyTap: _onKeyTap, onBackspace: _onBackspace),
              const SizedBox(height: AppSpacing.lg),
              AppGradientButton(
                label: 'Verify & continue',
                onPressed: _isComplete ? _verify : null,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
