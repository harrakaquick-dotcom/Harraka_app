import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'device_info.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<DeviceInfo> getDeviceInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;

      return DeviceInfo(
        platform: 'android',
        brand: info.brand,
        model: info.model,
        deviceName: info.device,
        osVersion: info.version.release,
        appVersion: packageInfo.version,
        deviceId: info.id,
      );
    }

    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;

      return DeviceInfo(
        platform: 'ios',
        brand: 'Apple',
        model: info.model,
        deviceName: info.name,
        osVersion: info.systemVersion,
        appVersion: packageInfo.version,
        deviceId: info.identifierForVendor,
      );
    }

    throw UnsupportedError('Unsupported platform');
  }
}

final deviceInfoProvider = FutureProvider<DeviceInfo>((ref) async {
  return DeviceInfoService().getDeviceInfo();
});