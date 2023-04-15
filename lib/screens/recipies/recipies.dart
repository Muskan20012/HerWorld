import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/const/food_categories.dart';
import 'package:gfg_hackathon/screens/recipies/search_deligate.dart';
import 'package:gfg_hackathon/screens/recipies/single_dish.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

class Recipies extends StatefulWidget {
  Recipies({required this.recipies, required this.category});
  final List recipies;
  final String category;
  @override
  State<Recipies> createState() => _RecipiesState();
}

class _RecipiesState extends State<Recipies> {
  Future downloadFile(String fileName) async {
    try {
      String downloadURL =
          await _storage.ref('food/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(categoriesLabels[widget.category]!),
        // search button
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  searchTerms:
                      widget.recipies.map((e) => e.id.toString()).toList(),
                  recipies: widget.recipies,
                  category: widget.category,
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          itemCount: widget.recipies.length,
          itemBuilder: (context, index) {
            // if food item contains category
            if (widget.recipies[index]["category"].contains(widget.category)) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DishDetails(
                        data: widget.recipies[index],
                        category: widget.category,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        FutureBuilder(
                          future: downloadFile(widget.recipies[index]["image"]),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return CachedNetworkImage(
                                  imageUrl: snapshot.data,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error));
                            } else {
                              return const SizedBox(
                                height: 100,
                                width: 100,
                              );
                            }
                          },
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.recipies[index]["image"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: ksecondarycolor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.recipies[index]["quantity"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
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
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
