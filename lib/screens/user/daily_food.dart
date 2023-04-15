import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/const/food_categories.dart';
import 'package:gfg_hackathon/screens/user/single_food.dart';
import 'package:gfg_hackathon/storage_service.dart';

class DailyFood extends StatefulWidget {
  const DailyFood({super.key, required this.data});
  final data;
  @override
  State<DailyFood> createState() => _DailyFoodState();
}

const Categories = [
  // "preworkout",
  // "postworkout",
  "when you wake up",
  "breakfast",
  "middaymeal",
  "lunch",
  "postlunch",
  "eveningsnacks",
  "dinner",
  "beforesleep",
];
const CategoriesName = {
  "preworkout": "When you wake up",
  "postworkout": "Post workout",
  "when you wake up": "Before Breakfast",
  "breakfast": "Breakfast",
  "middaymeal": "Mid day meal",
  "lunch": "Lunch",
  "postlunch": "Post lunch",
  "eveningsnacks": "Evening snacks",
  "dinner": "Dinner",
  "beforesleep": "Before sleep",
};

class _DailyFoodState extends State<DailyFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              // const Text('Daily Food'),
              // Text(widget.data.reference.toString()),
              // get data from reference
              StreamBuilder(
                stream: widget.data.reference.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: foodCategories.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                            stream: snapshot.data!.reference
                                .collection(foodCategories[index])
                                .snapshots(),
                            builder: (context, AsyncSnapshot foodsnapshot) {
                              if (foodsnapshot.hasData) {
                                if (foodsnapshot.data!.docs.length == 0) {
                                  return Text(
                                    'No food at ${categoriesLabels[foodCategories[index]]}',
                                    style: TextStyle(fontSize: 20),
                                  );
                                }
                                // return Text(foodsnapshot.data!.docs.toString());
                                // return ListTile(
                                //   title: Text(foodCategories[index]),
                                //   subtitle: Text(
                                //       '${foodsnapshot.data!.docs[0].data()['name']}'),
                                // );
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        foodCategories[index],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              foodsnapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: FutureBuilder(
                                                future: downloadFoodFile(
                                                  foodsnapshot.data!.docs[index]
                                                      .data()['image'],
                                                ),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Image.network(
                                                      snapshot.data.toString(),
                                                      width: 50,
                                                      height: 50,
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              title: Text(foodsnapshot
                                                  .data!.docs[index]
                                                  .data()['image']),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetails(
                                                      data: foodsnapshot
                                                          .data!.docs[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
