// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _genders = [
    "Male",
    "Female",
  ];
  var age = ['10', '20', '30'];
  var currentSelectedGender;
  var currentSelectedAge;
  var currentage;
  var currentgender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Questions"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add questions for Users",
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "please enter question",
                  labelText: 'Question :',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                minLines: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 3,
              ),
              const Text("Select Genders From Below List"),
              const SizedBox(
                height: 3,
              ),
              const Divider(),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: currentSelectedGender == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: currentSelectedGender,
                        isDense: true,
                        onChanged: (value) {
                          setState(() {
                            currentSelectedGender = value;
                            state.didChange(value);
                            currentgender = value.toString();
                          });

                          const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Select Item Type",
                                style: TextStyle(color: Colors.grey),
                              ));
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
              const Divider(),
              const SizedBox(
                height: 3,
              ),
              const Text("Select Age From Below List"),
              const SizedBox(
                height: 3,
              ),
              const Divider(),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: currentSelectedAge == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: currentSelectedAge,
                        isDense: true,
                        onChanged: (value) {
                          setState(() {
                            currentSelectedAge = value;
                            state.didChange(value);
                            currentage = value.toString();
                          });

                          const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Select Item Type",
                                style: TextStyle(color: Colors.grey),
                              ));
                        },
                        items: age.map((String value) {
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Add Question")),
            ],
          ),
        ),
      ),
    );
  }
}
