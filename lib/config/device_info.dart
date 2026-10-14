class DeviceInfo {
  final String platform;
  final String? brand;
  final String? model;
  final String? deviceName;
  final String osVersion;
  final String appVersion;
  final String? deviceId;

  const DeviceInfo({
    required this.platform,
    this.brand,
    this.model,
    this.deviceName,
    required this.osVersion,
    required this.appVersion,
    this.deviceId,
  });
}