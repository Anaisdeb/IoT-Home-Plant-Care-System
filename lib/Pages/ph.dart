import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:HPCS_app/helper.dart';

class PhPage extends StatelessWidget {
  final int value;

  const PhPage({key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }}