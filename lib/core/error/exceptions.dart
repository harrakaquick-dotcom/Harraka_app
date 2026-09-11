/// Thrown by the data layer; caught and mapped to a [Failure] by repositories.
class ServerException implements Exception {
  const ServerException([this.message = 'Something went wrong on the server']);

  final String message;
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection']);

  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'Unable to load cached data']);

  final String message;
}
