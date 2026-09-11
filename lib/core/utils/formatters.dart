import 'package:intl/intl.dart';

/// Currency, date, and distance formatting shared across features.
class Formatters {
  Formatters._();

  static final NumberFormat _currency = NumberFormat.currency(symbol: '₹', decimalDigits: 0);
  static final DateFormat _etaTime = DateFormat('h:mm a');
  static final DateFormat _orderDate = DateFormat('MMM d, y • h:mm a');

  static String currency(num amount) => _currency.format(amount);

  static String etaTime(DateTime time) => _etaTime.format(time);

  static String orderDate(DateTime date) => _orderDate.format(date);

  static String distance(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }
}
