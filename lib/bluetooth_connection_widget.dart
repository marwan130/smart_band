import 'package:flutter/material.dart';

class BluetoothConnectionWidget extends StatelessWidget {
  const BluetoothConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bluetooth Connection Unavailable',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Center(
            child: Text('Bluetooth functionality is currently disabled.'),
          ),
        ],
      ),
    );
  }
}