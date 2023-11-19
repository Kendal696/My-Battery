import 'package:flutter/material.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery Percentage'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.white],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/battery_icon.png', // Ruta de tu imagen
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                StreamBuilder<AndroidBatteryInfo?>(
                  stream: BatteryInfoPlugin().androidBatteryInfoStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final batteryLevel =
                          snapshot.data?.batteryLevel ?? 'Desconocido';
                      return Card(
                        elevation: 4,
                        color: Colors.lightBlueAccent, // Color celeste
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Battery Level: $batteryLevel%",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
