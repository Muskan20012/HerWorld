import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/calculator.dart';
import 'package:numberpicker/numberpicker.dart';

class ReusableBg extends StatelessWidget {
  // ignore: non_constant_identifier_names
  ReusableBg({required this.colour, required this.cardChild}); //remove required
  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: cardChild,
      margin: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class GenderBg extends StatelessWidget {
  const GenderBg({required this.colour, required this.cardChild});
  final Color colour;
  final Widget cardChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(25.0),
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
