import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/device_info_provider.dart';
import 'providers/toggle_flash_provider.dart';
import 'view/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DeviceInfoProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ToggleFlashProvider(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        title: 'Device Info',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
        debugShowCheckedModeBanner: false,
        home: const DashboardScreen(),
      ),
    );
  }
}
