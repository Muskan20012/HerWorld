import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/recipies/recipies.dart';
import 'package:gfg_hackathon/storage_service.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    int servings = 0;
    const Categories = [
      // "preworkout",
      // "postworkout",
      "when you wake up",
      "breakfast",
      "middaymeal",
      "lunch",
      "postlunch",
      "eveningsnacks",
      "dinner",
      "beforesleep",
    ];
    const CategoriesName = {
      "preworkout": "When you wake up",
      "postworkout": "Post workout",
      "when you wake up": "Before Breakfast",
      "breakfast": "Breakfast",
      "middaymeal": "Mid day meal",
      "lunch": "Lunch",
      "postlunch": "Post lunch",
      "eveningsnacks": "Evening snacks",
      "dinner": "Dinner",
      "beforesleep": "Before sleep",
    };
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hii ${FirebaseAuth.instance.currentUser!.displayName!.split(" ")[0]}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      Text(
                        'Feeling Better!',
                        style: GoogleFonts.signika(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: _firestore.collection("food").get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> foodsnapshot) {
                  if (foodsnapshot.hasData) {
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },

                      // using streambuilder
                      child: StreamBuilder(
                        stream: _firestore
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("daily")
                            .doc(
                                DateFormat('yyyy-MM-dd').format(DateTime.now()))
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> dailydatasnapshot) {
                          if (dailydatasnapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: Categories.length,
                              itemBuilder: (context, categoryindex) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            CategoriesName[
                                                Categories[categoryindex]]!,
                                            style: GoogleFonts.signika(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        // get data from each category
                                        StreamBuilder(
                                          stream: dailydatasnapshot
                                              .data!.reference
                                              .collection(
                                                  Categories[categoryindex])
                                              .snapshots(),
                                          // if data is present
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot.data!.docs.isEmpty) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: const Center(
                                                      child: Text(
                                                          "Oops no food item added!")),
                                                );
                                              }
                                              return ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder:
                                                    (context, foodindex) {
                                                  return Column(
                                                    children: [
                                                      foodindex == 0
                                                          ? Container()
                                                          : const Center(
                                                              child: Divider(
                                                                thickness: 2,
                                                                indent: 50,
                                                                endIndent: 50,
                                                                height: 30,
                                                              ),
                                                            ),
                                                      InkWell(
                                                        // onTap open a dialog box to change the quantity
                                                        onTap: () {
                                                          changeQuantity(
                                                              context,
                                                              snapshot,
                                                              foodindex);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            // Image.network(downloadFoodFile(fileName))
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child:
                                                                  FutureBuilder(
                                                                future: downloadFoodFile(snapshot
                                                                    .data!
                                                                    .docs[
                                                                        foodindex]
                                                                        [
                                                                        "image"]
                                                                    .toString()),
                                                                builder: (context,
                                                                    imageurl) {
                                                                  if (imageurl
                                                                      .hasData) {
                                                                    return Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          color:
                                                                              Colors.grey),
                                                                      clipBehavior:
                                                                          Clip.hardEdge,
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl: imageurl
                                                                            .data!
                                                                            .toString(),
                                                                        width:
                                                                            75,
                                                                        height:
                                                                            75,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return const Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            75,
                                                                        height:
                                                                            75,
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            foodindex]
                                                                            [
                                                                            "name"]
                                                                        .toString(),
                                                                    softWrap:
                                                                        false,
                                                                    style: GoogleFonts
                                                                        .signika(
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            18,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // servings
                                                                  Text(
                                                                    "${snapshot.data!.docs[foodindex]["quantity"]} x ${snapshot.data!.docs[foodindex]["servings"]}",
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                        // button to add food to each category
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: ksecondarycolor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              // go to recipes
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Recipies(
                                                    category: Categories[
                                                        categoryindex],
                                                    recipies:
                                                        foodsnapshot.data!.docs,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Text(
                                                  "Add Food",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> changeQuantity(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int foodindex) {
    int servings = 0;
    return showDialog(
        context: context,
        builder: (context) {
          servings = snapshot.data!.docs[foodindex]["servings"];
          return AlertDialog(
            backgroundColor: ksecondarycolor,
            title: Text(
              snapshot.data!.docs[foodindex]["name"],
              style: GoogleFonts.signika(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            content: Container(
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity",
                        style: GoogleFonts.signika(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      Text(
                        snapshot.data!.docs[foodindex]["quantity"].toString(),
                        style: GoogleFonts.signika(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: NumberPicker(
                      minValue: 1,
                      axis: Axis.horizontal,
                      maxValue: 20,
                      value: servings,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          servings = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Close",
                  style: GoogleFonts.signika(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
