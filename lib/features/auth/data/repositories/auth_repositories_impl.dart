import 'package:harraka/core/network/api_client.dart';
import 'package:harraka/core/network/api_endpoints.dart';
import 'package:harraka/features/auth/data/models/user_model.dart';

class AuthRepositoriesImpl {
  final ApiClient apiClient;

  AuthRepositoriesImpl(this.apiClient);

  Future<OtpEmail> login(String email) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.otpEmail,
      data: {"email": email},
    );
    return OtpEmail.fromJson(response.data);
  }

  Future<VerifyOtp> verifyOtp({String? phone, String? email,required String otp}) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.otpVerify,
      data: {
        if (phone != null && phone.isNotEmpty) "phone": phone,
        if (email != null && email.isNotEmpty) "email": email,
        "otp": otp,
        "device_id": "unknown",
      }
    );

    print("Response = ${response.data}");

    return VerifyOtp.fromJson(response.data);
  }
}
