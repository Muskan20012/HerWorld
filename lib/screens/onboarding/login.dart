import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/helper/string_methods.dart';
import 'package:gfg_hackathon/screens/onboarding/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoading = false;
  bool? emailValid = null;
  _signIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA =
          await googleSignInAccount!.authentication;

      await _auth
          .signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: gSA.idToken,
          accessToken: gSA.accessToken,
        ),
      )
          .then((value) {
        // else go to signup page
      });
    } catch (e) {
      // snackbar showing error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // flex: 2,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    color: kBackgroundColor,
                    child: Container(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text(
                        "Womaniya",
                        style: GoogleFonts.dancingScript(
                          fontSize: 75,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                      color: Colors.black,
                    ),
                    child: Column(
                      children: [
                        // email and password text field
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Text(
                                    "Help us make you fit",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Text(
                                    "We will help you to find the best workout for you",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),

                                // email text field
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Flexible(
                          child: TextField(
                            onChanged: (newvalue) {
                              // emailController.text = newvalue;
                              // print('First text field: $newvalue');

                              if (emailRegExp.hasMatch(newvalue)) {
                                setState(() {
                                  emailValid = true;
                                });
                              } else {
                                setState(() {
                                  emailValid = false;
                                });
                              }
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              // no border
                              suffixIcon: emailValid == true
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Flexible(
                          child: TextField(
                            obscureText: true,
                            onChanged: (newvalue) {
                              // emailController.text = newvalue;
                              // print('First text field: $newvalue');

                              if (emailRegExp.hasMatch(newvalue)) {
                                setState(() {
                                  emailValid = true;
                                });
                              } else {
                                setState(() {
                                  emailValid = false;
                                });
                              }
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              // no border
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBackgroundColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: isLoading
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  // child: CircularProgressIndicator(),
                                  //  white color circular progress indicator
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  width: double.infinity,
                                  child: const Center(
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {})
                                .catchError((e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                              isLoading = false;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 2,
                          indent: 80,
                          endIndent: 80,
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kBackgroundColor,
                              // onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(500),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text("Sign In with Google",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            onPressed: () {
                              _signIn();
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: kBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
