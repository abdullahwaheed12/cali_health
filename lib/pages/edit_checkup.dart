import 'dart:developer';

import 'package:cali_health/models/checkmodel.dart';
import 'package:cali_health/pages/user_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckupDetailFromDashboard extends StatefulWidget {
  const CheckupDetailFromDashboard(
      {super.key,
      required this.index,
      required this.checkupsObj,
      required this.documentReference,
      required this.checkupsObjs});
  final int index;
  final CheckUpmodel checkupsObj;
  final DocumentReference documentReference;
  final List<CheckUpmodel> checkupsObjs;
  @override
  State<CheckupDetailFromDashboard> createState() =>
      _CheckupDetailFromDashboardState();
}

class _CheckupDetailFromDashboardState
    extends State<CheckupDetailFromDashboard> {
  final formkey = GlobalKey<FormState>();
  final datecontroller = TextEditingController();

  int? pickeddate;
  int? age;
  int? currentdate;

  bool isNo = false;
  @override
  void initState() {
    super.initState();
    if (widget.checkupsObj.dueDate != null) {
      datecontroller.text =
          widget.checkupsObj.dueDate.toString().substring(0, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50, bottom: 30),
            child: Image(
              image: const AssetImage("assets/images/mainlogo.png"),
              width: MediaQuery.of(context).size.width / 5,
            ),
          ),
          ListTile(
            leading: Text('(${widget.index + 1})'),
            title: Text(widget.checkupsObj.checkUpName),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 40,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: OutlinedButton(
                    style: isNo
                        ? OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          )
                        : OutlinedButton.styleFrom(),
                    onPressed: () {
                      isNo = true;

                      setState(() {});
                    },
                    child: Text(
                      'Edit',
                      style:
                          isNo ? TextStyle(color: Colors.white) : TextStyle(),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (isNo)
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                'When will you do this?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          if (isNo)
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
                    hintText: "Select Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  readOnly: true,
                  onTap: (() async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050));
                    if (pickDate != null) {
                      setState(() {
                        datecontroller.text =
                            pickDate.toString().substring(0, 10);
                        pickeddate = pickDate.year.toInt();
                      });
                      print('date selected ${datecontroller.text}');
                    } else {
                      print("Not Selected");
                    }
                  }),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: isNo,
        child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Theme.of(context).primaryColor)),
            onPressed: () async {
              currentdate = DateTime.now().year.toInt();
              print('${widget.checkupsObj.gapDuration}');
              if (formkey.currentState!.validate()) {
                var a = DateTime.parse(datecontroller.text);
                print(DateTime.parse(datecontroller.text));
                var checkupDate = DateTime(a.year, a.month, a.day);
                GapDuration gapDuration = widget.checkupsObj.gapDuration;

                if (isNo) {
                  await widget.documentReference
                      .update({'checkUpList': FieldValue.delete()});
                  widget.checkupsObjs[widget.index] = CheckUpmodel(
                      checkUpName:
                          widget.checkupsObjs[widget.index].checkUpName,
                      isDone: false,
                      isSkip: false,
                      dueDate: checkupDate,
                      gapDuration: gapDuration);
                  var checkupMap =
                      widget.checkupsObjs.map((e) => e.toMap()).toList();
                  await widget.documentReference.update(
                      {'checkUpList': FieldValue.arrayUnion(checkupMap)});
                  log('all done');

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return UserDashBoard();
                    },
                  ));
                }
              }
            },
            label: Text(
              "  Done  ",
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
      ),
    );
  }
}
