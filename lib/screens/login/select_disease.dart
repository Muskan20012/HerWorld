import 'package:flutter/material.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:gfg_hackathon/screens/login/goal.dart';

class SelectDiseasePage extends StatefulWidget {
  const SelectDiseasePage({super.key, this.data});
  final data;
  @override
  State<SelectDiseasePage> createState() => _SelectDiseasePageState();
}

class _SelectDiseasePageState extends State<SelectDiseasePage> {
  @override
  void initState() {
    // TODO: implement initState
    widget.data["disease"] = [];
    super.initState();
  }

  static const List Diseases = [
    "Pre-Diabetes",
    "Diabetes",
    "Thyroid (Hyper)",
    "Thyroid (Hypo)",
    "PCOS & PCOD",
    "Cholesterol",
    "Hypertension",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          // child: Text(
          //   "data",
          // ),
          // selecting all the diseases from the list
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
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Select Your Disease",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "To give you better experience we need to know your disease",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Diseases.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // widget.data["disease"] = Diseases[index];
                        // Navigator.pushNamed(context, '/select_disease',
                        //     arguments: widget.data);
                        // toggle the selected disease
                        if (widget.data["disease"].contains(Diseases[index])) {
                          widget.data["disease"].remove(Diseases[index]);
                        } else {
                          widget.data["disease"].add(Diseases[index]);
                        }
                        setState(() {});
                        print(widget.data["disease"]);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                widget.data["disease"].contains(Diseases[index])
                                    ? Colors.black87
                                    : Colors.grey,
                            width:
                                widget.data["disease"].contains(Diseases[index])
                                    ? 3
                                    : 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          Diseases[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Hero(
                tag: "next",
                child: ElevatedButton(
                  // change the color of the button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // SystemChannels.textInput.invokeMethod('TextInput.hide');
                    // widget.data["height"] = "NO";
                    // print(widget.data["weight"]);
                    {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Goal(data: widget.data),
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Goal(data: widget.data),
                        ),
                      );
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
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
