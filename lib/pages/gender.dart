// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cali_health/pages/weight.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Gender extends StatefulWidget {
  String name;
  int age;

  Gender({Key? key, required this.age, required this.name}) : super(key: key);

  @override
  State<Gender> createState() => GenderState();
}

class GenderState extends State<Gender> {
  final gendercontroller = TextEditingController();
  String? currentGender; // gender value
  // var currentage = widget.age;

  final _genders = [
    "Male",
    "Female",
  ];

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
                padding: const EdgeInsets.only(top: 35),
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
                    "Please Select Your Gender?",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 26,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 120.0, right: 30, top: 35.0, bottom: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          focusColor: Color(
                            0xff09358A,
                          ),
                          hintText: 'Please select Gender',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      isEmpty: currentGender == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: currentGender,
                          hint: Text('select gender'),
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              currentGender = value;
                              print(
                                  'gender selected ${currentGender?.substring(0, 1)}');
                              state.didChange(value);
                            });
                          },
                          items: _genders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              )
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
            print('your gender is $currentGender');
            Navigator.pushReplacement(
                context,
                (MaterialPageRoute(
                    builder: ((context) => Weight(
                        name: widget.name,
                        age: widget.age,
                        gender: currentGender)))));
          },
          label: Text(
            "  Next  ",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
