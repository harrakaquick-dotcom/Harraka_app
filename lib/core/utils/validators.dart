/// Shared form-field validators returning an error string, or null when valid.
class Validators {
  Validators._();

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final digitsOnly = RegExp(r'^\d{10}$');
    if (!digitsOnly.hasMatch(value.trim())) return 'Enter a valid 10-digit phone number';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().length != length) {
      return 'Enter the $length-digit OTP';
    }
    return null;
  }
}
