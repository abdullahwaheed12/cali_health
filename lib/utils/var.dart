// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Variables {
  static var calculateage;
  static var finalname;
  static var finalgender;
  static var finalweight;
  static var finalheight;

  // static List check = ["Samiullah", "Abdullah", "Saadi"];
}

class Globalfunction {
  static void uploadingdata() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'name': Variables.finalname.toString(),
      'age': Variables.calculateage,
      'weight': Variables.finalweight.toString(),
      'height': Variables.finalheight.toString(),
      'gender': Variables.finalgender.toString(),
    }).then((value) => print("user Added Successfully"));
  }
}
