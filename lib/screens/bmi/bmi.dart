import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'reusable_bg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/bmi/reusable_bg.dart';
import 'package:gfg_hackathon/const/calculator.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

double _bmi = 0;
double _weight = 0;
double _height = 0;
String _message = "";
String _fbmi = _bmi.toStringAsFixed(1);

class _BMIState extends State<BMI> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          //build a future builder to get only weight of the user from firestore
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Your height : ${snapshot.data.get('height')}',
                          style: GoogleFonts.poppins(
                            color: kprimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //calculate bmi using the weight and height
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Your weight : ${snapshot.data.get('weight')}',
                          style: GoogleFonts.poppins(
                            color: kprimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _bmi = snapshot.data.get('weight') /
                                  pow(snapshot.data.get('height') / 100, 2);

                              if (_bmi < 18.5) {
                                _message = "Underweight";
                              } else if (_bmi >= 18.5 && _bmi < 25) {
                                _message = "Normal weight";
                              } else if (_bmi >= 25 && _bmi < 30) {
                                _message = "Overweight";
                              } else {
                                _message = "Obese";
                              }
                            });
                          },
                          child: Text('Calculate BMI'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _bmi.toStringAsFixed(2),
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          '$_message',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// // calculate bmi using the weight and height and return to a text form
// String calculateBMI(int weight, int height) {
//   double bmi = weight / (height * height);
//   return bmi.toString();
// }
