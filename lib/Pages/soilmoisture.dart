import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:HPCS_app/helper.dart';

class SoilMoisturePage extends StatelessWidget {
  final int value;

  const SoilMoisturePage({key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }}