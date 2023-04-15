import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gfg_hackathon/screens/recipies/single_dish.dart';
import 'package:gfg_hackathon/storage_service.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchTerms;
  final List recipies;
  final category;
  CustomSearchDelegate(
      {this.category, required this.searchTerms, required this.recipies});

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var dish in searchTerms) {
      if (dish.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(dish);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            // query = result;
            // print(recipies[searchTerms.indexOf(result)].data()['name']);
            close(context, null);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DishDetails(
                data: recipies[searchTerms.indexOf(result)],
                category: category,
              );
            }));
            // showResults(context);
          },
          // leading: CachedNetworkImage(
          //     imageUrl: recipies[searchTerms.indexOf(result)].data()['image']),
          leading: FutureBuilder(
            future: downloadFoodFile(
                recipies[searchTerms.indexOf(result)].data()['image']),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print(snapshot.data.toString() + ">>>" + result);

                // print()
                return Container(
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data.toString(),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              } else {
                return Container(
                  width: 50,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var dish in searchTerms) {
      if (dish.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(dish);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            // query = result;
            // print(recipies[searchTerms.indexOf(result)].data()['name']);
            close(context, null);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DishDetails(
                data: recipies[searchTerms.indexOf(result)],
                category: category,
              );
            }));
            // showResults(context);
          },
          title: Text(result),
        );
      },
    );
  }
}
