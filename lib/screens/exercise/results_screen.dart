import 'package:flutter/material.dart';
import 'package:gfg_hackathon/screens/home/home_screen.dart';
import 'package:gfg_hackathon/const/colors.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({this.data});
  final data;
  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                // "Congrulations you have burned approx ${widget.data.data().toString()} calories",
                "Congrulations!!!!\n You are done",
                style: TextStyle(
                  fontSize: 30,
                )),
            //add a button to route to the home screen
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                ).then((value) => setState(() {}));
              },
              child: Container(
                width: 110,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ksecondarycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Home",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: kprimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
