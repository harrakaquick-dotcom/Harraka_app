import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/data/sample_catalog.dart';

/// Maps productId -> quantity. Shared across Home, Category, Product and
/// Cart screens so "add to cart" state stays in sync everywhere.
class CartNotifier extends StateNotifier<Map<String, int>> {
  CartNotifier() : super(const {'p1': 2, 'p3': 1, 'p5': 1});

  void add(String productId, int delta) {
    final next = Map<String, int>.from(state);
    final qty = (next[productId] ?? 0) + delta;
    if (qty <= 0) {
      next.remove(productId);
    } else {
      next[productId] = qty;
    }
    state = next;
  }

  int get itemCount => state.values.fold(0, (a, b) => a + b);

  int get itemTotal =>
      state.entries.fold(0, (t, e) => t + productById(e.key).price * e.value);

  int get mrpTotal =>
      state.entries.fold(0, (t, e) => t + productById(e.key).mrp * e.value);
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, int>>(
  (ref) => CartNotifier(),
);
