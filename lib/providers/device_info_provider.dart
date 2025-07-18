import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class DeviceInfoProvider extends ChangeNotifier {
  static const platform = MethodChannel('com.example.device/info');

  String _battery = 'Unknown';
  String _deviceName = 'Unknown';
  String _osVersion = 'Unknown';

  bool _isLoading = false;

  String get battery => _battery;

  String get deviceName => _deviceName;

  String get osVersion => _osVersion;

  bool get isLoading => _isLoading;

  Future<void> getDeviceInfo() async {
    if (!_isLoading) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      final result = await platform.invokeMethod<Map>('getDeviceInfo');

      _battery = '${result?['battery']}%';
      _deviceName = result?['deviceName'] ?? 'Unknown';
      _osVersion = result?['osVersion'] ?? 'Unknown';

      notifyListeners();
    } catch (e) {
      Utils.customLog("Failed to get device info: $e");
    }

    if (_isLoading) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
