import 'package:flutter/material.dart';
import 'package:harraka/features/auth/presentation/screens/signup_screen.dart';
import '../../features/addresses/presentation/screens/select_address_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/checkout/presentation/screens/payment_screen.dart';
import '../../features/home/presentation/screens/home_shell.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/order_history/presentation/screens/orders_screen.dart';
import '../../features/order_tracking/presentation/screens/tracking_screen.dart';
import '../../features/product_details/presentation/screens/product_details_screen.dart';
import '../../features/profile/presentation/screens/account_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/support/presentation/screens/support_screen.dart';
import 'route_names.dart';

/// Central [onGenerateRoute] table. Add a case per screen as features
/// are implemented; keep route names in [RouteNames].
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.signup:
        return MaterialPageRoute(builder: (_)=> const SignupScreen());
      case RouteNames.otpVerification:
        final phoneNumber = settings.arguments as String? ?? '';
        return MaterialPageRoute(builder: (_) => OtpScreen(phoneNumber: phoneNumber));
      case RouteNames.addresses:
        return MaterialPageRoute(builder: (_) => const SelectAddressScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeShell());
      case RouteNames.category:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case RouteNames.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case RouteNames.productDetails:
        final productId = settings.arguments as String? ?? 'p1';
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen(productId: productId));
      case RouteNames.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case RouteNames.checkout:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case RouteNames.orderTracking:
        return MaterialPageRoute(builder: (_) => const TrackingScreen());
      case RouteNames.orderHistory:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case RouteNames.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case RouteNames.support:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
