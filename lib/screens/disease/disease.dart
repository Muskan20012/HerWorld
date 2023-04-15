import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseaseReversals extends StatefulWidget {
  const DiseaseReversals({super.key, this.userdata});
  final userdata;
  @override
  State<DiseaseReversals> createState() => _DiseaseReversalsState();
}

class _DiseaseReversalsState extends State<DiseaseReversals> {
  @override
  Widget build(BuildContext context) {
    List userDisease = widget.userdata.get("disease");
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("food").get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // if disease is present in the food
                      if (snapshot.data.docs[index].data()["disease"] != null) {
                        // print(snapshot.data.docs[index].data()["disease"]);
                        // bool hasCommonElement = list1.any((element) => list2.contains(element));
                        List foodDisease =
                            snapshot.data.docs[index].data()["disease"];
                        bool hasCommonElement = foodDisease
                            .any((element) => userDisease.contains(element));
                        // print(hasCommonElement);
                        if (hasCommonElement) {
                          return ListTile(
                            title: Text(snapshot.data.docs[index].get("name")),
                          );
                        }
                        // if (snapshot.data.docs[index]
                        //     .data()["disease"]
                        //     .contains(widget.userdata.get("disease"))) {
                        //   return ListTile(
                        //     title: Text(snapshot.data.docs[index].get("name")),
                        //   );
                        // }
                      }
                      return Container();
                      // return ListTile(
                      //   title: Text(snapshot.data.docs[index].get("name")),
                      // );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
