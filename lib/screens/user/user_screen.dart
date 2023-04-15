import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/const/food_categories.dart';
import 'dart:core';

import 'package:gfg_hackathon/screens/user/graph.dart';
import 'package:gfg_hackathon/screens/user/graph2.dart';
import 'package:gfg_hackathon/screens/user/my_diet.dart';

class UserScreen extends StatefulWidget {
  final data;
  const UserScreen({Key? key, this.data}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map foodData = {};
  @override
  void initState() {
    CollectionReference reference = widget.data.reference.collection('daily');
    reference.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        for (var category in foodCategories) {
          doc.reference.collection(category).get().then((value) {
            for (var element in value.docs) {
              var data;
              int servings = element.data()['servings'];
              if (foodData[doc.id] == null) {
                data = {
                  "calories":
                      double.parse(element.data()["macros"]['calories']) *
                          servings,
                  "carbs": double.parse(element.data()["macros"]['carbs']) *
                      servings,
                  "fat":
                      double.parse(element.data()["macros"]['fat']) * servings,
                  "protein": double.parse(element.data()["macros"]['protein']) *
                      servings,
                  "fiber": double.parse(element.data()["macros"]['fiber']) *
                      servings,
                };
                foodData[doc.id] = data;
              }
              // else add the data to the existing map
              else {
                data = {
                  "calories": foodData[doc.id]['calories'] +
                      double.parse(element.data()["macros"]['calories']) *
                          servings,
                  "carbs": foodData[doc.id]['carbs'] +
                      double.parse(element.data()["macros"]['carbs']) *
                          servings,
                  "fat": foodData[doc.id]['fat'] +
                      double.parse(element.data()["macros"]['fat']) * servings,
                  "protein": foodData[doc.id]['protein'] +
                      double.parse(element.data()["macros"]['protein']) *
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
    // print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // back button
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                  ),
                ),
                // user name
                // const Text("Profile"),
                // Text(FirebaseAuth.instance.currentUser!.displayName!),
                Container(
                  height: 40,
                  width: 48,
                ),
              ],
            ),
            CircleAvatar(
              radius: 45,
              // backgroundImage: NetworkImage(
              // if no image is provided, use the default image
              backgroundImage: FirebaseAuth.instance.currentUser!.photoURL ==
                      null
                  ? const NetworkImage(
                      "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png")
                  : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                // edit button
                IconButton(
                  onPressed: () {
                    // open a dialog box to edit the name
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                "Silver Plan Member",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // go pro button
                    ListTile(
                      focusColor: Colors.white,
                      leading: Icon(
                        Icons.star,
                        color: kprimaryColor,
                      ),
                      title: const Text("Go Pro"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Coming Soon!"),
                          ),
                        );
                      },
                    ),
                    // my fitness data button
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.bar_chart,
                    //     color: kprimaryColor,
                    //     // color: klightOrange,
                    //   ),
                    //   title: const Text("My Fitness Data"),
                    //   trailing: const Icon(Icons.arrow_forward_ios, size: 15),
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
                    // ),
                    // My disorders button
                    ListTile(
                      leading: Icon(
                        Icons.medical_services,
                        color: kprimaryColor,
                        // color: klightOrange,
                      ),
                      title: Text("My Disorders"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                    // My diet button
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyDiet(
                              data: widget.data.reference.collection("daily"),
                            ),
                          ),
                        );
                      },
                      leading: Icon(
                        color: kprimaryColor,
                        Icons.restaurant,
                        // color: klightOrange,
                      ),
                      title: const Text("My Diet"),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 15, color: Colors.white),
                    ),
                    // goals button
                    ListTile(
                      leading: Icon(
                        color: kprimaryColor,
                        Icons.flag,
                      ),
                      title: Text("Goals"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          size: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // sign out button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dialog() {
    showDialog(
      context: context,
      builder: (context) {
        String name = "";
        return AlertDialog(
          title: const Text("Edit Name"),
          content: TextField(
            decoration: const InputDecoration(
              hintText: "Enter your name",
            ),
            onChanged: (value) {
              // update the name
              // FirebaseAuth.instance.currentUser!
              //     .updateDisplayName(value);
              name = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  FirebaseAuth.instance.currentUser!.updateDisplayName(name);
                  Navigator.pop(context);
                });
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
