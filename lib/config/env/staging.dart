import '../app_config.dart';

const AppConfig stagingConfig = AppConfig(
  // baseUrl: 'https://staging-api.harraka.app',
  baseUrl: 'http://127.0.0.1:3000/auth/',
  appName: 'Harraka',
  environment: Environment.dev,
  enableLogging: true,
);
