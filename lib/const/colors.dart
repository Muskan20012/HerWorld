import 'package:flutter/material.dart';

// Color kBackgroundColor = const Color(0xFFF5F8FF);
Color kBackgroundColor = const Color(0xFFd14d72);
Color ksecondarycolor = const Color(0xFFFFDDD2);
Color kprimaryColor = const Color(0xFFFFACC7);
Color kgreenaccent = Color(0xFFFFACC7);
Color kblueaccent = Color.fromARGB(255, 32, 139, 172);
TextStyle fontstyle = const TextStyle(fontFamily: 'Volkhov');

InputDecoration loginInputDecoration(String label) {
  return InputDecoration(
    border: InputBorder.none,
    // filled: true,
    fillColor: Colors.white.withOpacity(0.8),
    // contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    labelText: label,
    // border circular
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   borderSide: BorderSide(color: Colors.grey[200]!),
    // ),
  );
}
