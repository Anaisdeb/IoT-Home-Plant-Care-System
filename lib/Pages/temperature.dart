import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:HPCS_app/helper.dart';
import 'package:HPCS_app/cosmos.dart';

class TemperaturePage extends StatelessWidget {
  final int value;
  Cosmos cosmos = Cosmos( documentDBMasterKey:'master key');
  TemperaturePage({key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  TextButton(
                    child: const Text(
                      'Connect',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () async {
                      print("Test");
                      Map<String, dynamic> get_dbs = await cosmos.queryCosmos(
                          url: 'https://hpcs2.documents.azure.com:443/dbs/HPCSData/colls/Temperature/docs/', method: 'GET');
                      print("Hello");
                      print(get_dbs);
                    },
                  ),
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
  }}
