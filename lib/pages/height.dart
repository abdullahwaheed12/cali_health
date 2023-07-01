// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cali_health/pages/congrats.dart';
import 'package:flutter/material.dart';

class Height extends StatefulWidget {
  var weight;
  String name;
  int age;
  var gender;

  Height(
      {Key? key,
      this.weight,
      required this.name,
      required this.age,
      this.gender})
      : super(key: key);

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  final heightcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void height() {
    var height = heightcontroller.text;
    //var weight = widget.weight;

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Congrats(
                weight: widget.weight,
                height: height,
                name: widget.name,
                age: widget.age,
                gender: widget.gender)));
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
              SizedBox(height: 10),
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
                    "What is Your Height in cm?",
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
                    keyboardType: TextInputType.number,
                    controller: heightcontroller,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Height cannot be empty";
                      } else if (value.length < 2) {
                        return "Invalid Height in cm";
                      } else {
                        return null;
                      }
                    }),
                    decoration: InputDecoration(
                      hintText: "Enter Your Height",
                      label: const Text("Height:"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
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
            if (formkey.currentState!.validate()) {
              return height();
            }
          },
          label: Text(
            "  Next  ",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
