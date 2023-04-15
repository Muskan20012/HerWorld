import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/exercise/workout_screen.dart';

// import 'package:gym/screens/workoutScreen.dart';
FirebaseStorage _storage = FirebaseStorage.instance;

class FitnessCard extends StatefulWidget {
  const FitnessCard({Key? key}) : super(key: key);

  @override
  State<FitnessCard> createState() => _FitnessCardState();
}

class _FitnessCardState extends State<FitnessCard> {
  @override
  void initState() {
    super.initState();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Future downloadFile(String fileName) async {
      try {
        String downloadURL =
            await _storage.ref('workouts/$fileName').getDownloadURL();
        return downloadURL;
      } on FirebaseException catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _firestore.collection("workouts").get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // sort the data by level and then by name
                    snapshot.data!.docs.sort((a, b) {
                      if (a.get("level") == b.get("level")) {
                        return a.get("name").compareTo(b.get("name"));
                      } else {
                        return a.get("level").compareTo(b.get("level"));
                      }
                    });

                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Beginner",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            try {
                              if (snapshot.data!.docs[index].get("level") ==
                                  1) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WorkOutScreen(
                                          data: snapshot.data!.docs[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    // border clip
                                    clipBehavior: Clip.hardEdge,
                                    // borde radius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        FutureBuilder(
                                          future: downloadFile(snapshot
                                              .data!.docs[index]
                                              .get("image")),
                                          builder: (context, snaps) {
                                            if (snaps.hasData) {
                                              return Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          snaps.data.toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height: 150,
                                                    width: double.infinity,
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0.0),
                                                          Colors.black
                                                              .withOpacity(0.8),
                                                        ],
                                                        stops: const [0.6, 1.0],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 20,
                                                    left: 20,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get("name"),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20))
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Icon(
                                                      Icons.bolt,
                                                      color: kprimaryColor,
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                            return const Expanded(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            } catch (e) {
                              return Container();
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Intermediate",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            try {
                              if (snapshot.data!.docs[index].get("level") ==
                                  2) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WorkOutScreen(
                                          data: snapshot.data!.docs[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    // border clip
                                    clipBehavior: Clip.hardEdge,
                                    // borde radius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        FutureBuilder(
                                          future: downloadFile(snapshot
                                              .data!.docs[index]
                                              .get("image")),
                                          builder: (context, snaps) {
                                            if (snaps.hasData) {
                                              return Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          snaps.data.toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height: 150,
                                                    width: double.infinity,
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0.0),
                                                          Colors.black
                                                              .withOpacity(0.8),
                                                        ],
                                                        stops: const [0.6, 1.0],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 20,
                                                    left: 20,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get("name"),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20))
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.bolt,
                                                          color: kprimaryColor,
                                                        ),
                                                        // SizedBox(
                                                        //   width: 5,
                                                        // ),
                                                        Icon(
                                                          Icons.bolt,
                                                          color: kprimaryColor,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                            return const Expanded(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            } catch (e) {
                              return Container();
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Advanced",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            try {
                              if (snapshot.data!.docs[index].get("level") ==
                                  3) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WorkOutScreen(
                                          data: snapshot.data!.docs[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    // border clip
                                    clipBehavior: Clip.hardEdge,
                                    // borde radius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        FutureBuilder(
                                          future: downloadFile(snapshot
                                              .data!.docs[index]
                                              .get("image")),
                                          builder: (context, snaps) {
                                            if (snaps.hasData) {
                                              return Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          snaps.data.toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height: 150,
                                                    width: double.infinity,
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0.0),
                                                          Colors.black
                                                              .withOpacity(0.8),
                                                        ],
                                                        stops: const [0.6, 1.0],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 20,
                                                    left: 20,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get("name"),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20))
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.bolt,
                                                          color: kprimaryColor,
                                                        ),
                                                        Icon(
                                                          Icons.bolt,
                                                          color: kprimaryColor,
                                                        ),
                                                        Icon(
                                                          Icons.bolt,
                                                          color: kprimaryColor,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                            return const Expanded(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            } catch (e) {
                              return Container();
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    // return Text("hello");
  }
}

// import 'package:flutter/material.dart';

// class FitnessCard extends StatefulWidget {
//   const FitnessCard({Key? key}) : super(key: key);

//   @override
//   State<FitnessCard> createState() => _FitnessCardState();
// }

// class _FitnessCardState extends State<FitnessCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Text("hello world");
//   }
// }
