import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../../order_history/presentation/screens/orders_screen.dart';
import '../../../profile/presentation/screens/account_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../widgets/cart_bar.dart';
import 'home_screen.dart';

const _tabs = [
  (icon: Icons.home_filled, label: 'Home'),
  (icon: Icons.grid_view_rounded, label: 'Categories'),
  (icon: Icons.search, label: 'Search'),
  (icon: Icons.receipt_long_outlined, label: 'Orders'),
  (icon: Icons.person_outline, label: 'Account'),
];

const _screens = [
  HomeScreen(),
  CategoryScreen(),
  SearchScreen(),
  OrdersScreen(),
  AccountScreen(),
];

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final showCartBar = cart.isNotEmpty && _index < 3;

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _index, children: _screens),
          if (showCartBar)
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: CartBar(
                itemCount: notifier.itemCount,
                itemTotal: notifier.itemTotal,
                onTap: () => Navigator.of(context).pushNamed(RouteNames.cart),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10.5),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10.5),
        items: _tabs
            .map((t) => BottomNavigationBarItem(icon: Icon(t.icon), label: t.label))
            .toList(),
      ),
    );
  }
}
