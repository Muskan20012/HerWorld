import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gfg_hackathon/const/colors.dart';

class WaterTracker extends StatefulWidget {
  WaterTracker({Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  // int _waterConsumed = 0;
  // TimeOfDay _notificationTime = TimeOfDay(hour: 15, minute: 35);
  // bool _notificationsEnabled = true;
  // Future<void> _showNotification() async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'my_channel_id', 'Water Tracker', 'Intake water regularly',
  //       importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //   await widget.flutterLocalNotificationsPlugin.show(1, 'Stay Hydrated',
  //       'You have not consumed enough water today', platformChannelSpecifics,
  //       payload: 'item x');
  // }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String today = now.toString().substring(0, 10);

    return Container(
      // height: 200,
      // margin: const EdgeInsets.all(20.0),

      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Stay Hydrated",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: widget.data.reference.collection("daily").doc(today).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.data() == null) {
                  // set water to 0
                  widget.data.reference
                      .collection("daily")
                      .doc(today)
                      .set({"water": 0, "date": today}).then((value) {
                    setState(() {});
                  });
                  return SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child: Text(
                        'Loading',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                  // return const CircularProgressIndicator();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (snapshot.data!.get("water") > 0) {
                          widget.data.reference
                              .collection("daily")
                              .doc(today)
                              .update(
                                  {"water": snapshot.data!.get("water") - 1});
                          setState(() {
                            // _waterConsumed = snapshot.data!.get("water") - 1;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),
                    // Text(snapshot.data!.get("water").toString()),

                    Container(
                      height: 100,
                      width: 100,
                      child: LiquidCircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        value: snapshot.data!.get("water") / 8,
                        backgroundColor: Colors
                            .white, // Defaults to the current Theme's backgroundColor.
                        center: snapshot.data!.get("water") < 8
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.get("water").toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Glasses",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.get("water").toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Good Job",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        widget.data.reference
                            .collection("daily")
                            .doc(today)
                            .update({"water": snapshot.data!.get("water") + 1});
                        setState(() {
                          // _waterConsumed = snapshot.data!.get("water") + 1;
                        });
                        // if (_notificationsEnabled) {
                        //   _showNotification();
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('Loading');
              }
            },
          ),
        ],
      ),
    );
  }
}
