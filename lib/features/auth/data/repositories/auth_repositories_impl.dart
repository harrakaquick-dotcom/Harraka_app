import 'package:harraka/core/network/api_client.dart';
import 'package:harraka/core/network/api_endpoints.dart';
import 'package:harraka/features/auth/data/models/user_model.dart';

class AuthRepositoriesImpl {
  final ApiClient apiClient;

  AuthRepositoriesImpl(this.apiClient);

  Future<OtpEmail> login(String email) async {
    final response = apiClient.dio.post(
      ApiEndpoints.otpEmail,
      data: {"email": email},
    );
    return OtpEmail.fromJson(response);
  }
}
