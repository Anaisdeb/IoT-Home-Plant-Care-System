// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_blue/flutter_blue.dart';

final FlutterBlue flutterBlue = FlutterBlue.instance;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Home Plant Care',
        home: Options(),
        debugShowCheckedModeBanner: false);
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double? y;
}

class StarDisplay extends StatelessWidget {
  final int value;

  const StarDisplay({key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            'https://m.media-amazon.com/images/I/71pLSZUMrdL.jpg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Hector the plant',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Dieffenbachia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Column(
                children: <Widget>[
                  Text(
                      'CURRENT STATUS',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                  Divider(),
                  ListTile(
                      title: Text(
                        'Temperature',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(1 < value ? Icons.star : Icons.star_border,
                          color: Colors.lightGreen, size: 30);
                    }),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        'Moisture',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                          index < value ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 30);
                    }),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        'pH',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(1 < value ? Icons.star : Icons.star_border,
                          color: Colors.lightGreen, size: 30);
                    }),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        'Lighting',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(4 < value ? Icons.star : Icons.star_border,
                          color: Colors.red.shade700, size: 30);
                    }),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Column(
                      children: [
                        CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.blueGrey,
                            child: IconButton(
                                icon: const Icon(
                                    Icons.build, color: Colors.white),
                                onPressed: null
                            )),
                        Text('modify sensor thresholds',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12))
                      ]),
                  Divider(),
                  SizedBox(height: 10),
                  Wrap(spacing: 80, children: [
                    IconButton(
                        icon: const Icon(
                            Icons.settings_rounded, color: Colors.blueGrey),
                        onPressed: null,
                        padding: EdgeInsets.all(0.0),
                        iconSize: 40
                    ),
                    CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.lightBlue,
                        child: Icon(Icons.share, color: Colors.white)),
                    CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.lightBlue,
                        child: Icon(
                            Icons.settings_bluetooth, color: Colors.white)),
                  ])
                ],
              ),
              padding: EdgeInsets.all(25.0))
        ],
      ),
    );
  }
}

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
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
              child: StarDisplay(value: 3),
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
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Soil metrics'),
                  backgroundColor: Colors.brown,
                ),
                body: Center(
                    child: SingleChildScrollView(
                        child: Column(children: [
                          TableCalendar(
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now()),
                          SfCartesianChart(
                              title: ChartTitle(text: 'Weekly history'),
                              // Initialize category axis
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                // Initialize line series
                                LineSeries<ChartData, String>(
                                    dataSource: [
                                      // Bind data source
                                      ChartData('Mon', 8.3),
                                      ChartData('Tue', 9.4),
                                      ChartData('Wed', 8.6),
                                      ChartData('Thur', 10.3),
                                      ChartData('Fri', 8.67)
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
                              ])
                        ]))));
          }
          if (index == 1) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Temperature conditions'),
                  backgroundColor: Colors.orangeAccent,
                ),
                body: Center(
                    child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                              child: SfCartesianChart(
                                  title: ChartTitle(
                                      text: 'Monthly average history'),
                                  // Initialize category axis
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    // Initialize line series
                                    LineSeries<ChartData, String>(
                                        dataSource: [
                                          // Bind data source
                                          ChartData('Jan', 8.3),
                                          ChartData('Feb', 9.4),
                                          ChartData('Mar', 11.6),
                                          ChartData('Apr', 13.3),
                                          ChartData('May', 16.67)
                                        ],
                                        xValueMapper: (ChartData data,
                                            _) => data.x,
                                        yValueMapper: (ChartData data,
                                            _) => data.y)
                                  ])),
                          Container(
                              child: SfCartesianChart(
                                  title: ChartTitle(
                                      text: 'Recent Temperature data'),
                                  // Initialize category axis
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    // Initialize line series
                                    LineSeries<ChartData, String>(
                                        dataSource: [
                                          // Bind data source
                                          ChartData('Sept-22', 21.7),
                                          ChartData('Sept-23', 23.2),
                                          ChartData('Sept-24', 22.6),
                                          ChartData('Sept-25', 22.3),
                                          ChartData('Sept-26', 23.2)
                                        ],
                                        xValueMapper: (ChartData data,
                                            _) => data.x,
                                        yValueMapper: (ChartData data,
                                            _) => data.y)
                                  ]))
                        ]))));
          }
          if (index == 2) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Sun light detection'),
                backgroundColor: Colors.yellow[600],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
                title: const Text('pH report'),
                backgroundColor: Colors.blueGrey),
            backgroundColor: Colors.white,
            body: Center(
                child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                          child: SfCartesianChart(
                              title: ChartTitle(
                                  text: 'Monthly average history'),
                              // Initialize category axis
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                // Initialize line series
                                LineSeries<ChartData, String>(
                                    dataSource: [
                                      // Bind data source
                                      ChartData('Jan', 8.3),
                                      ChartData('Feb', 7.4),
                                      ChartData('Mar', 6.9),
                                      ChartData('Apr', 7),
                                      ChartData('May', 8)
                                    ],
                                    xValueMapper: (ChartData data,
                                        _) => data.x,
                                    yValueMapper: (ChartData data,
                                        _) => data.y)
                              ])),
                      Container(
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 14,
                                  interval: 1,
                                  startAngle: 180,
                                  endAngle: 360,
                                  axisLineStyle: AxisLineStyle(
                                      gradient: SweepGradient(colors: <Color>[
                                        Colors.red.withOpacity(1),
                                        Colors.yellow,
                                        Colors.green,
                                        Colors.blue,
                                        Colors.deepPurple,
                                      ], stops: <double>[
                                        0,
                                        0.25,
                                        0.5,
                                        0.75,
                                        1
                                      ])),
                                  pointers: <GaugePointer>[NeedlePointer(value: 8.2)]
                              )
                            ],
                          )
                    )
                    ])))
          );
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
  }
}
