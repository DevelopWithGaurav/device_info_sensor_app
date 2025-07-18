import 'package:device_info_sensor_app/view/sensor_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../generated/assets.dart';
import '../providers/device_info_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeviceInfoProvider>(context, listen: false).getDeviceInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Screen')),
      body: Consumer<DeviceInfoProvider>(builder: (_, deviceInfoProvider, child) {
        return deviceInfoProvider.isLoading
            ? Center(
                child: LottieBuilder.asset(
                  Assets.assetsLottiesLoading,
                  width: 185,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(Constants.kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Battery: ${deviceInfoProvider.battery}'),
                    Text('Device Name: ${deviceInfoProvider.deviceName}'),
                    Text('OS Version: ${deviceInfoProvider.osVersion}'),
                    const SizedBox(height: 60),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SensorInfoScreen())),
                      label: Text('Sensor Screen'),
                      icon: Icon(Icons.sensors),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
