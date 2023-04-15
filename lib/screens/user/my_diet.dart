import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/user/daily_food.dart';

class MyDiet extends StatelessWidget {
  final CollectionReference data;
  MyDiet({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var docs = data.get();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: Text('My Diet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // print(Type(docs));
            //     // print data type of docs
            //     print(docs);
            //   },
            //   child: Text('Print Data'),
            // ),
            FutureBuilder(
              future: docs,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  // return Text(snapshot.data.docs.toString());
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data.docs[index].id.toString()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DailyFood(
                                data: snapshot.data.docs[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return Text('No data');
              },
            )
          ],
        ),
      ),
    );
  }
}
