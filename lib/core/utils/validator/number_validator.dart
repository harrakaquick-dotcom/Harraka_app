class NumberValidator {
  NumberValidator._();

  static String? validate(String? value) {
    final number = value?.trim() ?? '';
    if (number.isEmpty) return 'Mobile number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(number)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }
}
