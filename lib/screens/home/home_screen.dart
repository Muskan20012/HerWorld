import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/screens/bmi/bmi.dart';
import 'package:gfg_hackathon/screens/disease/disease.dart';
import 'package:gfg_hackathon/screens/exercise/workout_screen.dart';
import 'package:gfg_hackathon/screens/period/period_tracker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gfg_hackathon/screens/exercise/fitness_cards.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/const/food_categories.dart';
import 'package:gfg_hackathon/screens/disease/disease.dart';
import 'package:gfg_hackathon/screens/exercise/fitness_cards.dart';
import 'package:gfg_hackathon/screens/home/components/home_top.dart';
import 'package:gfg_hackathon/screens/home/components/transformation.dart';
import 'package:gfg_hackathon/screens/home/components/water_tracker.dart';
import 'package:gfg_hackathon/screens/recipies/diet_screen.dart';
// import 'package:workick/screens/user/graph2.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Map foodData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var reference = snapshot.data!.reference.collection('daily');
            reference.get().then((QuerySnapshot querySnapshot) {
              for (var doc in querySnapshot.docs) {
                for (var category in foodCategories) {
                  doc.reference.collection(category).get().then((value) {
                    for (var element in value.docs) {
                      var data;
                      int servings = element.data()['servings'];
                      if (foodData[doc.id] == null) {
                        data = {
                          "calories": double.parse(
                                  element.data()["macros"]['calories']) *
                              servings,
                          "carbs":
                              double.parse(element.data()["macros"]['carbs']) *
                                  servings,
                          "fat": double.parse(element.data()["macros"]['fat']) *
                              servings,
                          "protein": double.parse(
                                  element.data()["macros"]['protein']) *
                              servings,
                          "fiber":
                              double.parse(element.data()["macros"]['fiber']) *
                                  servings,
                        };
                        foodData[doc.id] = data;
                      }
                      // else add the data to the existing map
                      else {
                        data = {
                          "calories": foodData[doc.id]['calories'] +
                              double.parse(
                                      element.data()["macros"]['calories']) *
                                  servings,
                          "carbs": foodData[doc.id]['carbs'] +
                              double.parse(element.data()["macros"]['carbs']) *
                                  servings,
                          "fat": foodData[doc.id]['fat'] +
                              double.parse(element.data()["macros"]['fat']) *
                                  servings,
                          "protein": foodData[doc.id]['protein'] +
                              double.parse(
                                      element.data()["macros"]['protein']) *
                                  servings,
                          "fiber": foodData[doc.id]['fiber'] +
                              double.parse(element.data()["macros"]['fiber']) *
                                  servings,
                        };
                        foodData.update(doc.id, (value) => data);
                      }
                    }
                  });
                }
              }
            });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HomeTop(data: snapshot.data),
              const SizedBox(height: 80),
              // water card
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FitnessCard(),
                                ),
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 110,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Home \nWorkouts",
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      // exercise or workout icon
                                      Icons.fitness_center,
                                      color: kprimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DietPage(),
                                  ),
                                ).then((value) => setState(() {}));
                              },
                              child: Container(
                                width: 110,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Diet \nTracker",
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      // diet or food icon
                                      Icons.fastfood,
                                      color: kprimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                // push to bmi calculator page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BMI(),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 110,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Calculate \nBMI",
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      // exercise or workout icon
                                      Icons.calculate,
                                      color: kprimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // push to disease reversals page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PeriodTrackerScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 110,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Period \Tracker",
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      // disease or medicine icon,
                                      Icons.medical_services,
                                      color: kprimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => GraphScreen2(
                            //           data: foodData,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   child: Container(
                            //     width: 110,
                            //     margin:
                            //         const EdgeInsets.symmetric(vertical: 10),
                            //     padding: EdgeInsets.all(20),
                            //     decoration: BoxDecoration(
                            //       color: kBackgroundColor,
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     child: Column(
                            //       children: [
                            //         Text(
                            //           "Nutrition\nReports",
                            //           textAlign: TextAlign.center,
                            //         ),
                            //         Icon(
                            //           // nutrition icon
                            //           Icons.pages,
                            //           color: kprimaryColor,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),

                        snapshot.hasData
                            ? WaterTracker(
                                data: snapshot.data,
                              )
                            : Shimmer.fromColors(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                baseColor: Colors.black12,
                                highlightColor: Colors.white,
                              ),

                        // FitnessCard(),
                        Container(
                          // color: Colors.red,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Our Customers",
                                style: TextStyle(
                                  // color: Colors.grey[900],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TransformationWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
