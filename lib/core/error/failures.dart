/// Base type for domain/presentation-layer error results.
abstract class Failure {
  const Failure(this.message);

  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on the server']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Unable to load cached data']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
