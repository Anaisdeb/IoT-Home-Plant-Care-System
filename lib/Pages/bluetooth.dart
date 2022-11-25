import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';

class BluetoothSettings extends StatefulWidget {
  BluetoothSettings({super.key});
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =  <BluetoothDevice>[];
  @override
  State<BluetoothSettings> createState() => _BluetoothSettingsState();
}

class _BluetoothSettingsState extends State<BluetoothSettings> {

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Start scanning
    widget.flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      // do something with scan results
      for (ScanResult result in results) {
        print("found one");
        _addDeviceTolist(result.device);
      }
    });

// Stop scanning
    widget.flutterBlue.stopScan();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              TextButton(
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Bluetooth Settings'),
      backgroundColor: Colors.blueAccent,
    ),
      body: _buildListViewOfDevices(),);
  }
}
