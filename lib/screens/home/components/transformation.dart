import 'package:flutter/material.dart';

class TransformationWidget extends StatefulWidget {
  const TransformationWidget({super.key});

  @override
  State<TransformationWidget> createState() => _TransformationWidgetState();
}

class _TransformationWidgetState extends State<TransformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 100,
            child: Image.asset(
              "assets/fem_1.jpg",
              // height: 10,
              // width: 100,
            ),
          );
        },
      ),
    );
  }
}
