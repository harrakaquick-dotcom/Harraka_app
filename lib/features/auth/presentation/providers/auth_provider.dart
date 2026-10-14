import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client_provider.dart';
import '../../data/repositories/auth_repositories_impl.dart';

final authRepositoryProvider = Provider<AuthRepositoriesImpl>((ref) {
  return AuthRepositoriesImpl(
    ref.watch(apiClientProvider),
  );
});