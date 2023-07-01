import 'package:cali_health/pages/dob.dart';
import 'package:flutter/material.dart';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);
  @override
  State<Name> createState() => _NameState();

  static void addAll(List<String> names) {}
}

class _NameState extends State<Name> {
  final _name = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void nextpage() {
    var name = _name.text.toUpperCase();
    print('your name is $name');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => DateOfBirth(name: name)));
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
                    "What is Your Name?",
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
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: "Enter Your name",
                      label: const Text("Name:"),
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
              return nextpage();
            }
          },
          label: Text(
            "  Next  ",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
