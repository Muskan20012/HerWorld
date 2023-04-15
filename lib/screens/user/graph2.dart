// import 'package:draw_graph/draw_graph.dart';
// import 'package:intl/intl.dart';
// import 'package:draw_graph/models/feature.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:gfg_hackathon/const/colors.dart';
// import 'package:gfg_hackathon/const/nutrition.dart';
// import 'package:gfg_hackathon/screens/user/user_screen.dart';

// class GraphScreen2 extends StatefulWidget {
//   final data;
//   const GraphScreen2({Key? key, this.data}) : super(key: key);
//   @override
//   State<GraphScreen2> createState() => _GraphScreen2State();
// }

// class _GraphScreen2State extends State<GraphScreen2> {
//   List<Color> gradientColors = [
//     Colors.cyan,
//     Colors.blue,
//   ];
//   List<NutritionData> nutriData = [];
//   int weeks = 1;
//   var reqData = {};
//   var highestcal = 10.0;
//   List days = [];
//   @override
//   void initState() {
//     // print(widget.data);
//     widget.data.forEach((key, value) {
//       if (DateTime.now().difference(DateTime.parse(key)).inDays < 7) {
//         nutriData.add(NutritionData(key, value['calories'], value['carbs'],
//             value['fat'], value['protein'], value['fiber']));
//       }
//     });
//     // fill missing dates with 0
//     for (int i = 0; i < 7; i++) {
//       var date = DateTime.now().subtract(Duration(days: i));
//       var dateString = date.toString().split(' ')[0];
//       if (nutriData.where((element) => element.date == dateString).length ==
//           0) {
//         nutriData.add(NutritionData(dateString, 0, 0, 0, 0, 0));
//       }
//     }
//     // sort the data by date
//     nutriData.sort((a, b) => a.date.compareTo(b.date));

//     // List<String> days = [];
//     DateTime now = DateTime.now();
//     for (int i = 0; i < 7; i++) {
//       DateTime day = now.subtract(Duration(days: i));
//       String name = DateFormat('EE').format(day);
//       days.add(name);
//     }
//     print(days);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int i = 1;
//     final List<Feature> features = [
//       Feature(
//         title: "Calories",
//         color: Colors.red,
//         // convert the calories to data
//         data: nutriData.map((e) => e.calories).toList(),
//       ),
//       Feature(
//         title: "Protein",
//         color: Colors.green,
//         data: nutriData.map((e) => e.protein).toList(),
//       ),
//       Feature(
//         title: "Carbs",
//         color: Colors.blue,
//         data: nutriData.map((e) => e.carbs).toList(),
//       ),
//       Feature(
//         title: "Fat",
//         color: Colors.yellow,
//         data: nutriData.map((e) => e.fat).toList(),
//       ),
//       Feature(
//         title: "Fiber",
//         color: Colors.purple,
//         data: nutriData.map((e) => e.fiber).toList(),
//       ),
//     ];
//     widget.data.forEach((key, value) {
//       if (DateTime.now().difference(DateTime.parse(key)).inDays < 7) {
//         // get highest value of calories
//         if (value['calories'] > highestcal) {
//           highestcal = (value['calories']);
//           print(highestcal);
//         }
//         // nutriData.add(NutritionData(key, value['calories'], value['carbs'],
//         //     value['fat'], value['protein'], value['fiber']));
//       }
//     });
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               GraphStyle(
//                 gradientColors: gradientColors,
//                 days: days,
//                 title: "Calories",
//                 data: nutriData
//                     .map((e) =>
//                         FlSpot(double.parse(e.date.split('-')[2]), e.calories))
//                     .toList(),
//               ),
//               GraphStyle(
//                 gradientColors: gradientColors,
//                 days: days,
//                 title: "Protein",
//                 data: nutriData
//                     .map((e) =>
//                         FlSpot(double.parse(e.date.split('-')[2]), e.protein))
//                     .toList(),
//               ),
//               GraphStyle(
//                 gradientColors: gradientColors,
//                 days: days,
//                 title: "Carbs",
//                 data: nutriData
//                     .map((e) =>
//                         FlSpot(double.parse(e.date.split('-')[2]), e.carbs))
//                     .toList(),
//               ),
//               GraphStyle(
//                 gradientColors: gradientColors,
//                 days: days,
//                 title: "Fat",
//                 data: nutriData
//                     .map((e) =>
//                         FlSpot(double.parse(e.date.split('-')[2]), e.fat))
//                     .toList(),
//               ),
//               GraphStyle(
//                 gradientColors: gradientColors,
//                 days: days,
//                 title: "Fiber",
//                 data: nutriData
//                     .map((e) =>
//                         FlSpot(double.parse(e.date.split('-')[2]), e.fiber))
//                     .toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
