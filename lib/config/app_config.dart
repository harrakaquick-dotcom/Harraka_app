/// Environment configuration. Instantiate the matching env class in
/// `main_dev.dart` / `main_staging.dart` / `main_prod.dart` entry points.
class AppConfig {
  const AppConfig({required this.baseUrl, required this.envName});

  final String baseUrl;
  final String envName;
}
