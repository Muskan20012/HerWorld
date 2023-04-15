import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/home/components/goal_completion.dart';
import 'package:gfg_hackathon/screens/user/user_screen.dart';

class HomeTop extends StatefulWidget {
  const HomeTop({super.key, this.data});
  final data;
  @override
  State<HomeTop> createState() => _HomeTopState();
}

class _HomeTopState extends State<HomeTop> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 15,
                  right: 15,
                  bottom: 170,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xfffef2f4), Color(0xffffabab)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hi! ${_auth.currentUser!.displayName}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Get in shape",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserScreen(
                              data: widget.data,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(2),
                        child: _auth.currentUser!.photoURL != null
                            ? CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  _auth.currentUser!.photoURL.toString(),
                                ),
                              )
                            : CircleAvatar(
                                radius: 22,
                                backgroundColor: ksecondarycolor,
                                child: Icon(
                                  Icons.person,
                                  color: kprimaryColor,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              GoalCompletion(),
            ],
          ),
        ],
      ),
    );
  }
}
