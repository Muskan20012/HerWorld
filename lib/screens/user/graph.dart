import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/nutrition.dart';

class GraphScreen extends StatefulWidget {
  final data;
  const GraphScreen({Key? key, this.data}) : super(key: key);
  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<NutritionData> nutriData = [];
  int weeks = 1;
  var reqData = {};
  @override
  void initState() {
    print(widget.data);
    widget.data.forEach((key, value) {
      if (DateTime.now().difference(DateTime.parse(key)).inDays < 7) {
        nutriData.add(NutritionData(key, value['calories'], value['carbs'],
            value['fat'], value['protein'], value['fiber']));
      }
    });
    // fill missing dates with 0
    for (int i = 0; i < 7; i++) {
      var date = DateTime.now().subtract(Duration(days: i));
      var dateString = date.toString().split(' ')[0];
      if (nutriData.where((element) => element.date == dateString).length ==
          0) {
        nutriData.add(NutritionData(dateString, 0, 0, 0, 0, 0));
      }
    }
    // sort the data by date
    nutriData.sort((a, b) => a.date.compareTo(b.date));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                swapAnimationDuration: Duration(seconds: 1),
                swapAnimationCurve: Curves.linear,
                LineChartData(
                  titlesData: FlTitlesData(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: nutriData
                          .map((e) => FlSpot(
                              double.parse(e.date.split('-')[2]), e.carbs))
                          .toList(),
                      barWidth: 2,
                    ),
                    LineChartBarData(
                      spots: nutriData
                          .map((e) =>
                              FlSpot(double.parse(e.date.split('-')[2]), e.fat))
                          .toList(),
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: LineChart(
            //     swapAnimationDuration: Duration(seconds: 1),
            //     swapAnimationCurve: Curves.linear,
            //     LineChartData(
            //       titlesData: FlTitlesData(),
            //       lineBarsData: [
            //         LineChartBarData(
            //           spots: nutriData
            //               .map((e) => FlSpot(
            //                   double.parse(e.date.split('-')[2]), e.calories))
            //               .toList(),
            //           belowBarData: BarAreaData(show: false),
            //           barWidth: 2,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // text with widget.data.values

            Text(widget.data.values.toString()),
          ],
        ),
      ),
    );
  }
}
