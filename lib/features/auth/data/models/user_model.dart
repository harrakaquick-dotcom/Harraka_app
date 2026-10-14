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
  final String otp;
  final bool success;

  OtpEmail({required this.otp, required this.success});

  factory OtpEmail.fromJson(dynamic json) {
    return OtpEmail(success: json['success'], otp: json['message']);
  }
}
