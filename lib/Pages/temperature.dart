import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:HPCS_app/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePage();
}

class _TemperaturePage extends State<TemperaturePage> {
  late Future<List<Temperature>> temperatures;

  Future<List<Temperature>> fetchTemperatures() async {
    final response = await http.get(Uri.parse("https://hpcs-back-end.azurewebsites.net/temperatures"));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Temperature> temperatures = List<Temperature>.from(l.map((model)=> Temperature.fromJson(model)));
      print(temperatures[0].value);
      return temperatures;
    } else {
      throw Exception('Failed to load temperatures');
    }
  }
  @override
  void initState() {
    super.initState();
    temperatures = fetchTemperatures();
  }

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
                  FutureBuilder<List<Temperature>>(
                    future: temperatures,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            child: SfCartesianChart(
                                title: ChartTitle(
                                    text: 'Recent Temperature data'),
// Initialize category axis
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
// Initialize line series
                                  LineSeries<ChartData, String>(
                                      dataSource:  snapshot.data!.map((model) => ChartData(model.date, model.value.toDouble()) ).toList(),
                                      xValueMapper: (ChartData data,
                                          _) => data.x,
                                      yValueMapper: (ChartData data,
                                          _) => data.y)
                                ]));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  )
                ]))));
  }}
