import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/exercise/exercise_screen.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

class WorkOutScreen extends StatefulWidget {
  WorkOutScreen({required this.data});
  final data;
  @override
  State<WorkOutScreen> createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen> {
  @override
  void initState() {
    // print(widget.data.get("exercise"));
    // getdata();
    super.initState();
  }

  Future downloadFile(String fileName) async {
    try {
      String downloadURL =
          await _storage.ref('exercise/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future downloadWorkout(String fileName) async {
    try {
      String downloadURL =
          await _storage.ref('workouts/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  late List images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: downloadWorkout(widget.data.data()["image"]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              snapshot.data.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                          // rounded bottom corners
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 1],
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                widget.data.data()["name"],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              // disable image refresh

              shrinkWrap: true,
              itemCount: widget.data.data()["exercise"].length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: downloadFile(widget.data.data()["exercise"]
                            [index]["data"]["image"]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              // margin: EdgeInsets.only(right: 16),

                              clipBehavior: Clip.hardEdge,
                              // borderRadius
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data.toString(),
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return Container(
                              height: 80,
                              width: 80,
                              // child: Center(
                              //   child: CircularProgressIndicator(),
                              // ),
                            );
                          }
                        },
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.data.data()["exercise"][index]
                                    ["exercise"],
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ksecondarycolor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  "${widget.data.data()["exercise"][index]["reps"]} - ${widget.data.data()["exercise"][index]["timed"] ? "Seconds" : "Reps"}",
                                  style: TextStyle(
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  // titlecase
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ExerciseScreen(
                        data: widget.data,
                      );
                    },
                  ),
                );
                // getdata();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Start Workout",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
