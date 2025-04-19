import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothConnectionWidget extends StatefulWidget {
  const BluetoothConnectionWidget({super.key});

  @override
  _BluetoothConnectionWidgetState createState() => _BluetoothConnectionWidgetState();
}

class _BluetoothConnectionWidgetState extends State<BluetoothConnectionWidget> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    super.initState();

    // Start scanning for Bluetooth devices
    flutterBlue.scanResults.listen((results) {
      setState(() {
        devicesList = results
            .map((r) => r.device)
            .where((d) => d.name.isNotEmpty)
            .toSet()
            .toList();
      });
    });

    flutterBlue.startScan(timeout: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Bluetooth Devices',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: devicesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: devicesList.length,
                    itemBuilder: (context, index) {
                      final device = devicesList[index];
                      return ListTile(
                        title: Text(device.name),
                        subtitle: Text(device.id.toString()),
                        trailing: const Icon(Icons.bluetooth),
                        onTap: () async {
                          try {
                            await device.connect();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Connected to ${device.name}')),
                            );
                            Navigator.pop(context); // close the bottom sheet
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Connection failed: $e')),
                            );
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
