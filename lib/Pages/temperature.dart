import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:HPCS_app/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

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

  List<ChartData> fetchTodayTemperatures(List<Temperature> allTemperatures){
    List<ChartData> result= <ChartData>[];
    for(var temperature in allTemperatures.reversed){
      var temperatureDate = DateTime.parse(temperature.date);
      if( DateUtils.isSameDay(temperatureDate, DateTime.now())){
        result.insert(0,ChartData(DateFormat.Hm().format(temperatureDate).toString(), temperature.value.toDouble()));
      } else {
        return result;
      }
    }
    return result;
  }

  List<ChartData> fetchWeekTemperatures(List<Temperature> allTemperatures){
    Map<DateTime, List<int>> temporary= <DateTime, List<int>>{};
    List<ChartData> result= <ChartData>[];
    var day = DateUtils.dateOnly(DateTime.now());
    var limitDate = day.subtract(const Duration(days:7));
    for(var temperature in allTemperatures){
      var temperatureDate = DateUtils.dateOnly(DateTime.parse(temperature.date));
      if( limitDate.compareTo(temperatureDate) <= 0){
          temporary[temperatureDate]==null ? temporary[temperatureDate] = [temperature.value]  : temporary[temperatureDate]!.add(temperature.value);
      } else {
        break;
      }
    }
    temporary.forEach((date, valueList) {

      result.add(ChartData(DateFormat.Md().format(date).toString(), valueList.average.toDouble()));
    });
    return result;
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
                        var temperatureList = snapshot.data!.map((model) => Temperature(
                            date: DateTime.parse(model.date).toString(),
                            value: model.value) ).toList();
                        return Column(children: [
                          SfCartesianChart(
                              title: ChartTitle(
                                  text: 'The temperatures of ${DateFormat.yMMMMd('en_US').format(DateTime.now())}'),
// Initialize category axis
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
// Initialize line series
                                LineSeries<ChartData, String>(
                                    dataSource:  fetchTodayTemperatures(temperatureList),
                                    xValueMapper: (ChartData data,
                                        _) => data.x,
                                    yValueMapper: (ChartData data,
                                        _) => data.y)
                              ]),
                          SfCartesianChart(
                              title: ChartTitle(
                                  text: 'Recent Temperature data'),
// Initialize category axis
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
// Initialize line series
                                LineSeries<ChartData, String>(
                                    dataSource: fetchWeekTemperatures(temperatureList),
                                    xValueMapper: (ChartData data,
                                        _) => data.x,
                                    yValueMapper: (ChartData data,
                                        _) => data.y)
                              ]),
                        ]);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  )
                ]))));
  }}
