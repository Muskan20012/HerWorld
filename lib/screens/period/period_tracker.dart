import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gfg_hackathon/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PeriodTrackerScreen extends StatefulWidget {
  @override
  _PeriodTrackerScreenState createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends State<PeriodTrackerScreen> {
  late DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      //to be updated from time to time
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      //create a collection period_dates inside the users collection

      // update selected date to Firebase
      // FirebaseFirestore.instance
      //     .collection('period_dates')
      //     .add({'date': DateFormat('yyyy-MM-dd').format(picked)});
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now).trim();
      // get month and year from the selected date
      String month = DateFormat('MM').format(picked);

      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("monthly")
          .doc(month)
          // .collection("period_dates")
          // .doc(DateFormat('yyyy-MM-dd').format(picked))
          .set({
        'date': DateFormat('yyyy-MM-dd').format(picked),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Text(
            //     _selectedDate == null
            //         ? 'No date selected.'
            //         : 'This month: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 25,
            //     )),
            SizedBox(height: 50),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: ksecondarycolor,
                //add a border to the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _selectDate(context),
              icon: Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
              label: Text(
                'Select Date',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            // ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //     primary: ksecondarycolor,
            //   ),
            //   onPressed: () {
            //     //delete the selected date from firebase

            //     setState(() {
            //       //delete the selected date from firebase
            //       FirebaseFirestore.instance
            //           .collection("users")
            //           .doc(FirebaseAuth.instance.currentUser!.uid)
            //           .collection("monthly")
            //           .doc(DateFormat('MM').format(_selectedDate))
            //           .delete();
            //     });
            //   },
            //   icon: Icon(
            //     Icons.delete,
            //     color: Colors.red,
            //   ),
            //   label: Text(
            //     'Delete',
            //     style: TextStyle(
            //       color: kprimaryColor,
            //     ),
            //   ),
            // ),

            CircleAvatar(
              radius: 150,
              child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Your Period in",
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),

                    //show a count of the number of days left for the next expected date
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected.'
                                : ' ${_selectedDate.add(Duration(days: 28)).difference(DateTime.now()).inDays}',
                            style: TextStyle(
                              color: kBackgroundColor,
                              fontSize: 70,
                            ),
                          ),
                          Text(
                            'days',
                            style: TextStyle(
                              color: kBackgroundColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 20.0),
              child: Text(
                _selectedDate == null
                    ? 'No date selected.'
                    : 'Expected Date: ${DateFormat('dd-MM-yyyy').format(_selectedDate.add(Duration(days: 28)))}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 80)
          ],
        ),
      ),
    );
  }
}
