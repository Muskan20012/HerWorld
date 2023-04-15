import 'package:flutter/material.dart';
import 'package:gfg_hackathon/storage_service.dart';

class FoodDetails extends StatefulWidget {
  FoodDetails({Key? key, this.data}) : super(key: key);
  final data;
  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  double fiberContent = 0.0;
  double servingSize = 0.0;
  double proteinContent = 0.0;
  @override
  void initState() {
    fiberContent = double.parse(widget.data.data()["macros"]["fiber"]);
    servingSize = double.parse(widget.data.data()["servings"].toString());
    proteinContent = double.parse(widget.data.data()["macros"]["protein"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: downloadFoodFile(widget.data.data()["image"]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.network(snapshot.data.toString());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Text(widget.data.data()["name"].toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("fiber"),
                Text("${fiberContent * servingSize} g"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("protein"),
                Text("${proteinContent * servingSize} g"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
