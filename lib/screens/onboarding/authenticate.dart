import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/home/main_screen.dart';
import 'package:gfg_hackathon/screens/login/AWH.dart';
import 'package:gfg_hackathon/screens/login/gender_screen.dart';
import 'package:gfg_hackathon/screens/onboarding/login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((value) {
              if (value.data() == null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenderScreen(),
                  ),
                );
                return GenderScreen();
              } else {
                return const MainScreen();
              }
            });
            return const MainScreen();
            //if firebase has data then go to home screen else go to AWHScreen
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
