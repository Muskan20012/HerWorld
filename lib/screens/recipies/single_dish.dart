import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:gfg_hackathon/const/colors.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

class DishDetails extends StatefulWidget {
  const DishDetails({required this.data, required this.category});
  final String category;
  final data;
  @override
  State<DishDetails> createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  int servings = 1;
  Future downloadFile(String fileName) async {
    try {
      String downloadURL =
          await _storage.ref('food/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  String videoUrl = '';
  String? id = '';
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'iuCUQQksqkw',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
  @override
  void initState() {
    if (widget.data["video"] != '') {
      videoUrl = widget.data["video"];
      id = YoutubePlayer.convertUrlToId(videoUrl);
      _controller = YoutubePlayerController(
        initialVideoId: id!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: downloadFile(widget.data["image"]),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    // if (snapshot.hasData) {
                    //   return CircleAvatar(
                    //     radius: 100,
                    //     backgroundImage: CachedNetworkImageProvider(
                    //       snapshot.data,
                    //     ),
                    //   );
                    // } else {
                    //   return const Center(
                    //     child: CircleAvatar(
                    //       // radius: 10,
                    //       child: CircularProgressIndicator(),
                    //     ),
                    //   );
                    // }
                    return Stack(
                      children: [
                        // container with full width and half height of image and image in overlapping container
                        // Container(
                        //   height: 120,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     // bottom left and right radius
                        //     borderRadius: const BorderRadius.only(
                        //       bottomLeft: Radius.circular(60),
                        //       bottomRight: Radius.circular(60),
                        //     ),
                        //     color: Colors.black,
                        //     // gradient: LinearGradient(
                        //     //   begin: Alignment.topCenter,
                        //     //   end: Alignment.bottomCenter,
                        //     //   colors: [
                        //     //     Colors.orange.shade900,
                        //     //     Colors.orange.shade300
                        //     //   ],
                        //     // ),
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Positioned(
                            child: snapshot.hasData
                                ? Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //border color
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: const Offset(2, 4),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: CircleAvatar(
                                        radius: 100,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          snapshot.data,
                                        ),
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: CircleAvatar(
                                      // radius: 10,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                            // CircleAvatar(
                            //   radius: 100,
                            //   backgroundImage: CachedNetworkImageProvider(
                            //     snapshot.data,
                            //   ),
                            // ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.data["name"],
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        // maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ksecondarycolor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.data["quantity"],
                          style: TextStyle(
                            // fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "Add to your meal plan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: NumberPicker(
                        minValue: 1,
                        axis: Axis.horizontal,
                        maxValue: 20,
                        value: servings,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                        selectedTextStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          setState(() {
                            servings = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        DateTime now = DateTime.now();
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(now).trim();
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("daily")
                            .doc(formattedDate)
                            .collection(widget.category)
                            .doc(widget.data["name"])
                            .set({
                          "name": widget.data["name"],
                          "image": widget.data["image"],
                          "category": widget.category,
                          "servings": servings,
                          "macros": widget.data["macros"],
                          "micros": widget.data["micro"],
                          "quantity": widget.data["quantity"],
                        }).then((value) {
                          Navigator.pop(context);
                          // snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Added to your food diary"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: ksecondarycolor,
                        onPrimary: Colors.white,
                      ),
                      child: const Text("Add",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                // macros
                Text(
                  "Macro nutrients",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("Fiber"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage('assets/fiber.png'),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["macros"]["fiber"]}g"),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Protein"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/protein.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["macros"]["protein"]}g"),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Carbs"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/carbs.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["macros"]["carbs"]}g"),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Fats"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/fats.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["macros"]["fat"]}g"),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Calories"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/calories.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["macros"]["calories"]}g"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // macros
                Text(
                  "Micro nutrients",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // biotin
                      Column(
                        children: [
                          const Text("Biotin"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/biotin.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["micro"]["biotin"]}g"),
                        ],
                      ),

                      // iron
                      Column(
                        children: [
                          const Text("Iron"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/iron.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["micro"]["iron"]}g"),
                        ],
                      ),
                      //magnesium

                      Column(
                        children: [
                          const Text("Mag"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/magnesium.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["micro"]["magnesium"]}g"),
                        ],
                      ),
                      // vitaminb6
                      Column(
                        children: [
                          const Text("B6"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/b6.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["micro"]["vitaminb6"]}g"),
                        ],
                      ),

                      // vitaminb12
                      Column(
                        children: [
                          const Text("B12"),
                          const SizedBox(height: 5),
                          const ImageIcon(
                            AssetImage("assets/b12.png"),
                          ),
                          const SizedBox(height: 5),
                          Text("${widget.data["micro"]["vitaminb12"]}g"),
                        ],
                      ),
                    ],
                  ),
                ),
                // ingredients
                const SizedBox(height: 20),
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.data["ingrediants"],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                // preparation

                Text(
                  "Preparation",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.data["preparation"]
                        .toString()
                        .split(". ")
                        .length,
                    itemBuilder: (context, index) {
                      List perp =
                          widget.data["preparation"].toString().split(". ");
                      int namingindex = 1;
                      if (perp[index].isNotEmpty) {
                        return Text("${perp[index]}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ));
                      }
                      return Container();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // collapsible accordion
                id != ""
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Video",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: YoutubePlayer(controller: _controller),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
