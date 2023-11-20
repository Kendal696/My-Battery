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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: BatteryMonitorPage(),
    );
  }
}

class BatteryMonitorPage extends StatefulWidget {
  @override
  _BatteryMonitorPageState createState() => _BatteryMonitorPageState();
}

class _BatteryMonitorPageState extends State<BatteryMonitorPage> {
  double? _batteryLevel;

  @override
  void initState() {
    super.initState();
    BatteryInfoPlugin().androidBatteryInfoStream.listen((batteryInfo) {
      setState(() {
        _batteryLevel = batteryInfo?.batteryLevel?.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Monitor'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: ListView(
          children: [
            BatteryLevelSection(batteryLevel: _batteryLevel),
            Divider(),
            BatteryHistorySection(),
            Divider(),
            BatteryAlertsSection(),
          ],
        ),
      ),
    );
  }
}

class BatteryLevelSection extends StatelessWidget {
  final double? batteryLevel;

  const BatteryLevelSection({Key? key, this.batteryLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.battery_charging_full,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          batteryLevel != null
              ? BatteryLevelCard(batteryLevel: batteryLevel!)
              : CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class BatteryLevelCard extends StatelessWidget {
  final double batteryLevel;

  const BatteryLevelCard({Key? key, required this.batteryLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.redAccent,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Battery Level: ${batteryLevel.toStringAsFixed(0)}%",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Widget para la sección de Historial de Batería
class BatteryHistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.history, color: Colors.blue),
      title: Text('Battery History'),
      onTap: () {
        // TODO: Navegar a la pantalla de historial de batería
      },
    );
  }
}

// Widget para la sección de Alertas de Nivel de Batería
class BatteryAlertsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications_active, color: Colors.red),
      title: Text('Battery Alerts'),
      onTap: () {
        // TODO: Navegar a la pantalla de configuración de alertas
      },
    );
  }
}
