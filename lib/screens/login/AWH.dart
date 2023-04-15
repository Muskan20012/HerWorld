import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/login/select_disease.dart';
import "goal.dart";

class AWH extends StatefulWidget {
  final data;
  AWH({Key? key, required this.data}) : super(key: key);

  @override
  State<AWH> createState() => _AWHState();
}

// widget to select age, weight and height
class _AWHState extends State<AWH> {
  //  append data to the widget data
  // var data = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                    const Text("Choose a fitness level"),
                    const Text(
                        "This will help us to give you better experience"),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Weight (in kg)"),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            // hidden border
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              widget.data["weight"] = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Height (in cm)"),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            // hidden border
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              widget.data["height"] = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    // enter date of birth
                    const SizedBox(height: 20),
                    // date picker on press
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Date of Birth",
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ksecondarycolor,
                          ),
                          onPressed: (() {
                            // show date picker
                            showDatePicker(
                              //set color of the date picker

                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              widget.data["dob"] =
                                  "${value!.day}/${value.month}/${value.year}";
                            });
                          }),
                          child: Text(
                            widget.data["dob"] ?? "Date of Birth",
                            style: TextStyle(
                              color: kprimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Hero(
                tag: "next",
                child: ElevatedButton(
                  // change the color of the button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ksecondarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    // widget.data["height"] = "NO";
                    // print(widget.data["weight"]);
                    if (widget.data["weight"] == null ||
                        widget.data["height"] == null ||
                        widget.data["dob"] == null) {
                      // print("Please fill all the fields");
                      // show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all the fields"),
                        ),
                      );
                    } else {
                      if (int.parse(widget.data["height"]!) > 300 ||
                          int.parse(widget.data["height"]!) < 100) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid height"),
                          ),
                        );
                      } else if (int.parse(widget.data["weight"]!) > 300 ||
                          int.parse(widget.data["weight"]!) < 20) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid weight"),
                          ),
                        );
                      } else if (widget.data["dob"] == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid date of birth"),
                          ),
                        );
                      } else {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Goal(data: widget.data),
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectDiseasePage(data: widget.data),
                          ),
                        );
                      }
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: kprimaryColor, fontSize: 28),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
