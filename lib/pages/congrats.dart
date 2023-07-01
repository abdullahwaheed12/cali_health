// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';

import 'package:cali_health/models/checkmodel.dart';
import 'package:cali_health/pages/checkup_list.dart';
import 'package:cali_health/utils/calculations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class Congrats extends StatefulWidget {
  String weight;
  String height;
  String name;
  int age;
  String gender;
  late Timer timer;
  Congrats(
      {Key? key,
      required this.weight,
      required this.height,
      required this.age,
      required this.name,
      required this.gender})
      : super(key: key);

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 100,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image(
                    image: const AssetImage("assets/images/mainlogo.png"),
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(
                        0xff09358A,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Thank you so much.\nCongratulations! We now\nset up your personal\nhealth profile.",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 26,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Theme.of(context).primaryColor)),
          onPressed: () async {
            GetStorage().write(nameKey, widget.name);
            GetStorage().write(weightKey, widget.weight);
            GetStorage().write(heightKey, widget.height);
            GetStorage().write(ageKey, widget.age);
            GetStorage().write(genderKey, widget.gender.substring(0, 1));

            GetStorage().write(docIdKey, Random().nextInt(400000).toString());

            print('User Object is saved to DB');
            FirebaseFirestore.instance
                .collection('users')
                .doc(GetStorage().read(docIdKey).toString())
                .set({
              'name': widget.name,
              'weight': widget.weight,
              'height': widget.height,
              'age': widget.age,
              'gender': widget.gender,
            }, SetOptions(merge: true));
            print('User Object is saved to Firebase');
            //Method to Calculate Persons Checkup
            List<CheckUpmodel> checkups =
                getCalculations(widget.age, widget.gender.substring(0, 1));
            var checkupsMap = checkups.map((e) => e.toMap()).toList();

            FirebaseFirestore.instance
                .collection('users')
                .doc(GetStorage().read(docIdKey))
                .collection('checkUpListCollection')
                .doc('checkUpListDoc')
                .set({'checkUpList': checkupsMap}, SetOptions(merge: true));
            print('user checkUp list is saved to Firebase ${checkupsMap} ');

            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CheckupList(length: checkupsMap.length);
              },
            ));
          },
          label: Text(
            "  Okay  ",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
