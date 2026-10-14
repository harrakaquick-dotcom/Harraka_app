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
