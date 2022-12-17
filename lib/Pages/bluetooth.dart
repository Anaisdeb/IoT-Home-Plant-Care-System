import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothSettings extends StatefulWidget {
  BluetoothSettings({super.key});
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =  <BluetoothDevice>[];
  final Map<Guid, int> readValues = <Guid, int>{};

  @override
  State<BluetoothSettings> createState() => _BluetoothSettingsState();
}

class _BluetoothSettingsState extends State<BluetoothSettings> {
  final _writeController = TextEditingController();
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];

  _addDeviceToList(final BluetoothDevice device) {
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
    widget.flutterBlue.startScan(timeout: const Duration(seconds: 4));

// Listen to scan results
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      // do something with scan results
      for (ScanResult result in results) {
        debugPrint("found one");
        if(result.device.name != ''){
          _addDeviceToList(result.device);
        }
      }
    });

// Stop scanning
    widget.flutterBlue.stopScan();
  }

  ListView _buildListViewOfDevices() {
    List<Widget> containers = <Widget>[];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        SizedBox(
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
                onPressed: () async {
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } on PlatformException catch (e) {
                    if (e.code != 'already_connected') {
                      rethrow;
                    }
                  } finally {
                    _services = (await device.discoverServices()).where((m) => m.characteristics.any((c)=> c.properties.notify)).toList();
                  }
                  setState(() {
                    _connectedDevice = device;


                  });
                },
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
      body: _buildView(),);
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  ListView _buildConnectDeviceView() {
    List<Widget> containers = <Widget>[];

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = <Widget>[];

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible( child:Text("${_connectedDevice?.name}", style: const TextStyle(fontSize: 30), overflow: TextOverflow.fade)),
                  ],
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Flexible( child:Text("Service uuid : ${service.uuid.toString()}", style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.fade)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible( child: Text("Characteristic uuid : ${characteristic.uuid.toString()}", style: const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        );
      }
      containers.addAll(characteristicsWidget);
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = <ButtonTheme>[];

    if (characteristic.properties.notify) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              child: const Text('Sync to cloud', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  characteristic.value.listen((value) async {
                    widget.readValues[characteristic.uuid] = value.first;
                    final response = await http.post(Uri.parse("https://hpcs-back-end.azurewebsites.net/temperatures"),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        }, body: jsonEncode(<String, dynamic>{
                          'date': DateTime.now().toString(),
                          'value': value.first
                        }));
                    if (response.statusCode == 201) {
                      // If the server did return a 201 CREATED response,
                      return print("It worked");
                    } else {
                      // If the server did not return a 201 CREATED response,
                      // then throw an exception.
                      throw Exception('Failed to create album.');
                    }
                  });
                  await characteristic.setNotifyValue(true);
                },
            ),
          ),
        ),
      );
    }

    return buttons;
  }
}
