/// Backend base URL and endpoint paths. Values are read from
/// [lib/config/env] at runtime — see [AppConfig].
class ApiEndpoints {
  ApiEndpoints._();

  static const String login = '/auth/login';
  static const String otpVerify = '/auth/otp/verify';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String products = '/products';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String addresses = '/addresses';
  static const String profile = '/profile';
}
