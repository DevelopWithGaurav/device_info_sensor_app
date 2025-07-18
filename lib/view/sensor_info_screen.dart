import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/toggle_flash_provider.dart';

class SensorInfoScreen extends StatelessWidget {
  const SensorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor Screen')),
      body: Consumer<ToggleFlashProvider>(builder: (_, toggleFlashProvider, child) {
        return SwitchListTile(
          title: const Text('Flashlight'),
          value: toggleFlashProvider.isOn,
          onChanged: toggleFlashProvider.toggleFlashlight,
        );
      }),
    );
  }
}
