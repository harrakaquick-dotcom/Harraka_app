import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/app_config.dart';

void bootstrap(AppConfig config){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
        child: HarrakaApp())
  );
}