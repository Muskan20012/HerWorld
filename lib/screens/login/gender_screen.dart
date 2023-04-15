import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/login/AWH.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  var data = {};
  List genders = ["male", "female"];
  int? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Welcome User!",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "To give you better experience we need to know about you. Are  you ready?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     data["gender"] = "male";
                      //     setState(() {
                      //       selected = 0;
                      //     });
                      //   },
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           border: Border.all(
                      //             color: kprimaryColor,
                      //             width: selected == 0 ? 4 : 0,
                      //           ),
                      //           borderRadius: BorderRadius.circular(200),
                      //         ),
                      //         child: CircleAvatar(
                      //           radius: 100,
                      //           backgroundColor: selected == 0
                      //               ? ksecondarycolor
                      //               : Colors.transparent,
                      //           child: Icon(
                      //             Icons.male,
                      //             color: kprimaryColor,
                      //             size: 100,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: 10),
                      //       Text("Male",
                      //           style: TextStyle(color: kprimaryColor)),
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          data["gender"] = "female";
                          setState(() {
                            selected = 1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AWH(data: data),
                              ),
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kprimaryColor,
                                  width: selected == 1 ? 4 : 0,
                                ),
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: selected == 1
                                    ? ksecondarycolor
                                    : Colors.transparent,
                                child: Text("Let's go",
                                    style: TextStyle(color: kprimaryColor)),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Hero(
                //   tag: "next",
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: ksecondarycolor,
                //       elevation: 0,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onPressed: () {
                //       if (selected == null) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content: Text("Please fill all the fields"),
                //           ),
                //         );
                //       } else {}
                //     },
                //     child: SizedBox(
                //       height: 50,
                //       width: 200,
                //       child: Center(
                //         child: Text(
                //           "Next",
                //           style: TextStyle(color: kprimaryColor, fontSize: 28),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
