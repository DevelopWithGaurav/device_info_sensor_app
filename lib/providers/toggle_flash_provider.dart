import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class ToggleFlashProvider extends ChangeNotifier {
  static const platform = MethodChannel('com.example.device/info');

  bool _isOn = false;

  bool get isOn => _isOn;

  Future<void> toggleFlashlight(bool turnOn) async {
    try {
      await platform.invokeMethod('toggleFlashlight', {'turnOn': turnOn});
      _isOn = turnOn;

      notifyListeners();
    } catch (e) {
      Utils.customLog('Failed to toggle flashlight: $e');
    }
  }
}
