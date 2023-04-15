import 'package:activity_ring/activity_ring.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gfg_hackathon/const/colors.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({Key? key}) : super(key: key);

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  late Timer _timer;
  int _start = 20;
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    // print("timer started");
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pop(context, 0);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Take Rest",
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
              Ring(
                animate: _start != 20,
                curve: Curves.easeOutCubic,
                percent: 100 - (_start / 20) * 100,
                radius: 150,
                color: RingColorScheme(
                  gradient: true,
                  ringColors: [Colors.blue, Colors.green, Colors.red],
                ),
                child: Column(
                  children: [
                    Text(
                      _start.toString(),
                      style: const TextStyle(fontSize: 120),
                    ),
                    const Text("seconds"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _timer.cancel();
                      Navigator.pop(context);
                    },
                    child: const Text("Skip"),
                  ),
                  // right ico
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
