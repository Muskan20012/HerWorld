// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/firebase_options.dart';
import 'package:gfg_hackathon/screens/onboarding/authenticate.dart';
import 'package:gfg_hackathon/screens/onboarding/onboarding.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

int initScreen = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen") ?? 0;
  runApp(const MyApp());
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  if (kDebugMode) {
    await analytics.setAnalyticsCollectionEnabled(false);
  }
  // analytics.logEvent(
  //     name: 'test', parameters: <String, dynamic>{'string': 'string'});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Womaniya',
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: kprimaryColor,
        secondary: ksecondarycolor,
      )),
      home: initScreen == 0 ? const Onbording() : const Authenticate(),
    );
  }
}
