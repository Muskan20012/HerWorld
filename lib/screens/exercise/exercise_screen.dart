import 'dart:async';

import 'package:activity_ring/activity_ring.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/exercise/rest_screen.dart';
import 'package:gfg_hackathon/screens/exercise/results_screen.dart';

// import 'package:workick/screens/rest_screen.dart';
// import 'package:workick/screens/results_screen.dart';

class ExerciseScreen extends StatefulWidget {
  final data;
  const ExerciseScreen({required this.data});
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

FirebaseStorage _storage = FirebaseStorage.instance;

class _ExerciseScreenState extends State<ExerciseScreen> {
  late CountdownTimerController controller;
  Future downloadFile(String fileName) async {
    try {
      String downloadURL =
          await _storage.ref('exercise/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  int index = 0;
  changePage() {
    if (index < widget.data.data()["exercise"].length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RestScreen(),
        ),
      ).then(
        (value) => setState(
          () {
            // print("page changed");
            index++;
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            data: widget.data,
          ),
        ),
      );
    }
  }

  Widget exerciseProgress() {
    // checking if the exercise is timed or not
    if (widget.data.data()["exercise"][index]["timed"]) {
      // reps to seconds
      int seconds = int.parse(widget.data.data()["exercise"][index]["reps"]);
      int endTime = DateTime.now().millisecondsSinceEpoch +
          1000 * int.parse(widget.data.data()["exercise"][index]["reps"]);
      return Column(
        children: [
          SizedBox(
            height: 200,
            child: CountdownTimer(
              endTime: endTime,
              widgetBuilder: (_, time) {
                if (time == null) {
                  return const Text("next exercise");
                }
                return Ring(
                  // find the percentage of the time left
                  percent:
                      ((time.min ?? 0) * 60 + (time.sec ?? 0)) / seconds * 100,
                  color: RingColorScheme(ringColor: Colors.red),
                  radius: 80,
                  width: 10,
                  child: Center(
                    child: Text(
                      "${time.min ?? 0}:${time.sec ?? 0}",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  // child: Text(time.toString()),
                );
              },
              onEnd: () {
                changePage();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                changePage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ksecondarycolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
              ),
              child: Text("Skip ",
                  style: TextStyle(
                    fontSize: 20,
                    color: kprimaryColor,
                  )),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.data.data()["exercise"][index]["reps"]} Reps",
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                changePage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ksecondarycolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 20,
                  color: kprimaryColor,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: downloadFile(
                    widget.data.data()["exercise"][index]["data"]["image"]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // image: NetworkImage(widget.images[index]),
                          image: CachedNetworkImageProvider(
                              snapshot.data.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    //  return indicator
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            Expanded(
              // flex: 2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.data.data()["exercise"][index]["exercise"],
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        exerciseProgress(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
