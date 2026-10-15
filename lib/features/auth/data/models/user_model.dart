import 'dart:async';

class UserModel {
  final String username;
  final int phoneNumber;
  final String email;
  final String deviceID;

  UserModel({
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.deviceID,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['name'],
      email: json['email'],
      phoneNumber: json['phone'],
      deviceID: json['device_id'],
    );
  }
}

class OtpEmail {
  final String message;
  final bool success;
  final String otp;

  OtpEmail({required this.message, required this.success, required this.otp});

  factory OtpEmail.fromJson(Map<String, dynamic> json) {
    return OtpEmail(
      success: json['success'] as bool,
      message: json['message'] as String,
      otp: json['otp'] as String,
    );
  }
}

class VerifyOtp {
  final bool isNewUser;
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  VerifyOtp({
    required this.isNewUser,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory VerifyOtp.fromJson(Map<String, dynamic> json) {
    return VerifyOtp(
      isNewUser: json['is_new_user'] as bool,
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      tokenType: json["token_type"] as String,
    );
  }
}
