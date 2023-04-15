import 'package:activity_ring/activity_ring.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';

class GoalCompletion extends StatefulWidget {
  const GoalCompletion({Key? key}) : super(key: key);

  @override
  State<GoalCompletion> createState() => _GoalCompletionState();
}

class _GoalCompletionState extends State<GoalCompletion> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: -70,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
              // color: ,
              color: Colors.black,
              // borderRadius: BorderRadius.circular(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(70),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          height: 220,
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 1,
                              height: 40,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Eaten"),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  textBaseline: TextBaseline.alphabetic,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: const [
                                    Text(
                                      "1024",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Kcal",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 1,
                              height: 40,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Burned"),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  textBaseline: TextBaseline.alphabetic,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: const [
                                    Text(
                                      "1987",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Kcal",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    color: Colors.red,
                    child: Ring(
                      percent: 0,
                      color: RingColorScheme(
                        gradient: true,
                        backgroundColor: Colors.grey[300],
                        ringGradient: [
                          Color(0xfffef2f4),
                          const Color(0xFFd14d72),
                        ],
                      ),
                      radius: 48,
                      width: 13,
                    ),
                  ),
                ],
              ),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Carbs"),
                          SizedBox(
                            height: 5,
                          ),
                          LinearProgressIndicator(
                            value: 0.8,
                            backgroundColor: Colors.grey[600],
                            // gradient progress bar
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFFACC7),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("5g left"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Protien"),
                          SizedBox(
                            height: 5,
                          ),
                          LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Colors.grey[600],
                            // gradient progress bar
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFFACC7),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("12g left"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fat"),
                          SizedBox(
                            height: 5,
                          ),
                          LinearProgressIndicator(
                            value: 0.0,
                            backgroundColor: Colors.grey[600],
                            // gradient progress bar
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFFACC7),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("0g left"),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class _GoalCompletionState extends State<GoalCompletion> {
//   @override
//   Widget build(BuildContext context) {
//     return Positioned.fill(
//       bottom: -50,
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           decoration: BoxDecoration(
//             color: kBackgroundColor,
//             // color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           height: 130,
//           width: MediaQuery.of(context).size.width * 0.90,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(left: 20),
//                 // padding: const EdgeInsets.all(10),
//                 width: 100,
//                 height: 100,
//                 child: Center(
//                   child: Ring(
//                     showBackground: false,
//                     width: 8,
//                     percent: 90,
//                     radius: 50,
//                     animate: true,
//                     color: RingColorScheme(
//                       backgroundColor: Colors.grey[300],
//                       ringColor: Colors.deepPurpleAccent[400],
//                     ),
//                     child: Ring(
//                       width: 8,
//                       percent: 30,
//                       radius: 42,
//                       color: RingColorScheme(
//                         gradient: true,
//                         backgroundColor: Colors.grey[300],
//                         ringColors: [
//                           const Color(0xffF98780),
//                           const Color(0xffEDA969),
//                         ],
//                       ),
//                       child: Ring(
//                         width: 8,
//                         percent: 70,
//                         radius: 34,
//                         color: RingColorScheme(
//                           backgroundColor: Colors.grey[300],
//                           ringColor: Colors.teal[400],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 7,
//                             backgroundColor: Colors.deepPurpleAccent,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(left: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "Calories",
//                                 ),
//                                 Text(
//                                   "100/2000 Kcal",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 7,
//                             backgroundColor: kOrange,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(left: 10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const Text("Water"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 7,
//                             backgroundColor: Colors.teal[400],
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(left: 10),
//                             child: const Text("Workout goal"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }