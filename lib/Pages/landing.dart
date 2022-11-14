import 'package:flutter/material.dart';

import 'package:HPCS_app/Pages/profile.dart';
import 'package:HPCS_app/Pages/temperature.dart';
import 'package:HPCS_app/Pages/soilmoisture.dart';
import 'package:HPCS_app/Pages/ph.dart';
import 'package:HPCS_app/Pages/sunlight.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _suggestions = <String>[
    'Soil Moisture',
    'Temperature',
    'Sun Light',
    'pH'
  ];


  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My plant'),
              backgroundColor: Colors.green,
            ),
            body: const Center(
              child: ProfilePage(),
            ),
          );
        },
      ),
    );
  }

  void _pushButton(index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          if (index == 0) {
            return SoilMoisturePage();
          }
          if (index == 1) {
            return TemperaturePage();
          }
          if (index == 2) {
            return SunLightPage();
          }
          return PhPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NEW from here ...
        appBar: AppBar(
          title: const Text('My healthy home plant'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(Icons.grass_rounded),
              onPressed: _pushInfo,
              tooltip: 'My plant\'s profile',
            ),
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(18.0), children: <Widget>[
          for (var i = 0; i < 8; i++)
            i.isOdd
                ? const Divider()
                : ListTile(
                title: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      alignment: Alignment.topLeft,
                    ),
                    onPressed: () => _pushButton(i ~/ 2),
                    child: Text(
                      _suggestions[i ~/ 2],
                      style: _biggerFont,
                    ))),
        ]));
  }}