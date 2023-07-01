// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cali_health/pages/gender.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateOfBirth extends StatefulWidget {
  String name;
  DateOfBirth({Key? key, required this.name}) : super(key: key);
  var pickingdate;

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  final formkey = GlobalKey<FormState>();
  final datecontroller = TextEditingController();
  int? pickeddate;
  int? age;
  // var calculatedage;
  int? currentdate;
  void agefunction() {
    debugPrint('your dob is $pickeddate');
  }

  void navigation() {
    currentdate = DateTime.now().year.toInt();
    age = (currentdate!) - (pickeddate!);
    debugPrint('your age is $age');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Gender(name: widget.name, age: age ?? 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Image(
                  image: const AssetImage("assets/images/mainlogo.png"),
                  width: MediaQuery.of(context).size.width / 5,
                ),
              ),
              SizedBox(
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
                    "Thanks ${widget.name}, Please tell\nme your Date of Birth?",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 26,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 120.0, right: 30, top: 35.0, bottom: 15),
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Date of birth cannot be Empty";
                      } else if (value.length < 2) {
                        return "Invalid Date";
                      } else {
                        return null;
                      }
                    },
                    controller: datecontroller,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.calendar_today_outlined),
                      hintText: "BirthDate",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    readOnly: true,
                    onTap: (() async {
                      DateTime? pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickDate != null) {
                        setState(() {
                          datecontroller.text =
                              pickDate.toString().substring(0, 10);
                          pickeddate = pickDate.year.toInt();
                        });
                      } else {
                        print("Not Selected");
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Theme.of(context).primaryColor)),
          onPressed: () {
            currentdate = DateTime.now().year.toInt();
            if (formkey.currentState!.validate()) {
              navigation();
            }
          },
          label: Text(
            "  Next  ",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
