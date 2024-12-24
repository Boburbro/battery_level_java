import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBatteryLevelJava(),
    );
  }
}

class MyBatteryLevelJava extends StatefulWidget {
  const MyBatteryLevelJava({super.key});

  @override
  State<MyBatteryLevelJava> createState() => _MyBatteryLevelJavaState();
}

class _MyBatteryLevelJavaState extends State<MyBatteryLevelJava> {
  static const platform = MethodChannel("my_app.dev/battery_level");

  String _batteryLevel = "Unknown battery level";

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = "Battery level at $result%";
    } on PlatformException catch (e) {
      batteryLevel = "Error getting battery level: ${e.message}";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Batter Level Java"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_batteryLevel),
            FilledButton.icon(
              onPressed: getBatteryLevel,
              icon: Icon(Icons.battery_std_rounded),
              label: Text("Get battery level"),
            )
          ],
        ),
      ),
    );
  }
}
