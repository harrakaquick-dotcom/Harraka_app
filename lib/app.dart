import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harraka/config/app_config.dart';
import 'core/constants/app_strings.dart';
import 'core/routing/app_router.dart';
import 'core/routing/route_names.dart';
import 'core/theme/app_theme.dart';

/// MaterialApp root — theme and routing injection.
class HarrakaApp extends ConsumerWidget {
  const HarrakaApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
