import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harraka/core/constants/app_strings.dart';
import 'package:harraka/core/widgets/app_back_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_Gradient_button.dart';
import '../widgets/otp_box_field.dart';

const _otpLength = 4;
const _resendSeconds = 60;

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber, required this.otp});

  final String phoneNumber;
  final String otp;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final _focusNodes = List.generate(_otpLength, (_) => FocusNode());

  Timer? _resendTimer;
  int _secondsLeft = _resendSeconds;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    // Focus must be requested after the first frame — calling requestFocus()
    // directly in initState is unreliable (focus tree not attached yet).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusScope.of(context).requestFocus(_focusNodes.first);
    });
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
    _secondsLeft = _resendSeconds;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
        return;
      }
      setState(() => _secondsLeft--);
    });
    // Refresh "Resend code in 1:00" label immediately on manual resend.
    if (mounted) setState(() {});
  }

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  /// System-keyboard entry: auto-advance on digit, auto-back on delete.
  /// Multi-digit input (long-press paste / SMS autofill) is distributed
  /// across boxes starting at [index].
  void _onChanged(String value, int index) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 1) {
      _fillFromPaste(digits, startIndex: index);
      return;
    }

    if (digits.length == 2 && index < _otpLength - 1) {
      // Edge case: IME committed 2 chars at once — keep first here.
      _controllers[index].text = digits[0];
    }

    if (value.isNotEmpty) {
      if (index < _otpLength - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    setState(() {});
  }

  /// Fills boxes from [digits] starting at [startIndex] (paste handling).
  void _fillFromPaste(String digits, {int startIndex = 0}) {
    final clean = digits.replaceAll(RegExp(r'\D'), '');
    if (clean.isEmpty) return;
    var cursor = startIndex.clamp(0, _otpLength - 1);
    for (final ch in clean.characters) {
      if (cursor >= _otpLength) break;
      _controllers[cursor].text = ch;
      cursor++;
    }
    setState(() {});
    if (_isComplete) {
      FocusScope.of(context).unfocus();
    } else {
      final next = math.min(startIndex + clean.length, _otpLength - 1);
      FocusScope.of(context).requestFocus(_focusNodes[next]);
    }
  }

  void _clear() {
    for (final controller in _controllers) {
      controller.clear();
    }
    setState(() {});
    FocusScope.of(context).requestFocus(_focusNodes.first);
  }

  void _verify() {
    if (!_isComplete) return;
    FocusScope.of(context).unfocus();
    TextInput.finishAutofillContext();
    Navigator.of(context).pushReplacementNamed(RouteNames.addresses);
  }

  String get _maskedPhone {
    final phone = widget.phoneNumber;
    if (phone.length < 5) return phone;
    if (phone.contains('@')) {
      return '${phone.substring(0, 3)}••• ••${phone.substring(phone.length - 9)}';
    }
    return '${AppStrings.countryCode}  ${phone.substring(0, 2)}••• ••${phone.substring(phone.length - 3)}';
  }

  String get _resendLabel => _secondsLeft > 0
      ? 'Resend code in 0:${_secondsLeft.toString().padLeft(2, '0')}'
      : 'Resend code';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(leading: AppBackButton()),
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.md),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: const Icon(
                    Icons.mark_chat_read_outlined,
                    color: AppColors.primary,
                    size: 34,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Verify your number', style: AppTextStyles.headingLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'We sent a $_otpLength-digit code to $_maskedPhone',
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                AutofillGroup(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_otpLength, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index == _otpLength - 1 ? 0 : AppSpacing.sm,
                        ),
                        child: OtpBoxField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          filled: _controllers[index].text.isNotEmpty,
                          autofocus: index == 0,
                          textInputAction: index == _otpLength - 1
                              ? TextInputAction.done
                              : TextInputAction.next,
                          onChanged: (value) => _onChanged(value, index),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _secondsLeft == 0 ? _startResendTimer : null,
                      child: Text(
                        _resendLabel,
                        style: AppTextStyles.caption.copyWith(
                          color: _secondsLeft > 0
                              ? AppColors.textSecondary
                              : AppColors.primary,
                          fontWeight: _secondsLeft > 0
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
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
                Text(
                  '${_controllers.where((c) => c.text.isNotEmpty).length}/$_otpLength digits entered',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppGradientButton(
                  label: 'Verify & continue',
                  onPressed: _isComplete ? _verify : null,
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
