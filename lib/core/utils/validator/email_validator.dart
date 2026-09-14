class EmailValidator {
  EmailValidator._();

  static String? validate(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
