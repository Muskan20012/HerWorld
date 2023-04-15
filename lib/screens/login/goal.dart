import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/onboarding/authenticate.dart';

class Goal extends StatefulWidget {
  const Goal({required this.data});
  final data;
  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  //creating a list of goals
  List<String> goalText = [
    'Learn the basics of fitness',
    'Lose weight',
    'Gain weight',
    'Build muscle',
    'Improve your health',
    'Improve flexibility',
  ];
  int selected = 0;
  @override
  void initState() {
    widget.data["goal"] = goalText[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //select one of the goals from the list
                      Row(
                        children: [
                          IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Select Your Goal",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "To give you better experience we need to know about you",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      ListView.builder(
                        itemCount: goalText.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = index;
                                widget.data["goal"] = goalText[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: index == selected
                                      ? Colors.black
                                      : Colors.grey,
                                  width: index == selected ? 3 : 1,
                                ),
                                // show border only when selected
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(goalText[index]),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Hero(
                tag: "next",
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // if there is a display name in firebase auth then use that
                    if (FirebaseAuth.instance.currentUser!.displayName !=
                        null) {
                      widget.data["name"] =
                          FirebaseAuth.instance.currentUser!.displayName;
                    } else {
                      widget.data["name"] = "User";
                    }
                    // else use the name from the form
                    Map<String, dynamic> converted =
                        Map<String, dynamic>.from(widget.data);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set(converted)
                        .then(
                          (value) => {
                            //pop all the screens and go to home screen
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Authenticate(),
                                ),
                                (route) => false)
                          },
                        );
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: kprimaryColor, fontSize: 28),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
