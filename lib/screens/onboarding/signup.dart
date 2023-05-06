import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/screens/login/AWH.dart';
import 'package:gfg_hackathon/screens/login/gender_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/helper/string_methods.dart';
// import 'package:workick/screens/login/gender_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  bool? emailValid = null;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email = '';
  String _password = '';
  String _name = '';
  String _error = '';
  String _confirmPassword = '';
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: Text(
                    "HerWorld",
                    style: GoogleFonts.dancingScript(
                      fontSize: 75,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                  child: TextFormField(
                    decoration: loginInputDecoration("Name"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                  child: TextFormField(
                    decoration: loginInputDecoration("Email"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: loginInputDecoration("Password"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: loginInputDecoration("Confirm Password"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _confirmPassword = val;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        if (_password == _confirmPassword) {
                          final newUser = await _auth
                              .createUserWithEmailAndPassword(
                            email: _email,
                            password: _password,
                          )
                              .then((value) {
                            value.user!.updateDisplayName(_name);
                          });
                          if (newUser != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenderScreen(),
                              ),
                            );
                          }
                        } else {
                          // using scaffoldMessenger
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password doesn't match"),
                            ),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          _error = e.toString();
                        });
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    // width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(_error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
