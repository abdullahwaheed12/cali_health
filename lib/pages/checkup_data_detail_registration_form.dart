import 'dart:developer';

import 'package:cali_health/models/checkmodel.dart';
import 'package:cali_health/pages/checkup_list.dart';
import 'package:cali_health/pages/user_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckupDataDetailRegistraionForm extends StatefulWidget {
  const CheckupDataDetailRegistraionForm(
      {super.key,
      required this.index,
      required this.checkupsObj,
      required this.documentReference,
      required this.isFromDashBoard,
      required this.checkupsObjs});
  final int index;
  final CheckUpmodel checkupsObj;
  final DocumentReference documentReference;
  final List<CheckUpmodel> checkupsObjs;
  final bool isFromDashBoard;
  @override
  State<CheckupDataDetailRegistraionForm> createState() =>
      _CheckupDataDetailRegistraionFormState();
}

class _CheckupDataDetailRegistraionFormState
    extends State<CheckupDataDetailRegistraionForm> {
  final formkey = GlobalKey<FormState>();
  final datecontroller = TextEditingController();

  int? pickeddate;
  int? age;
  int? currentdate;

  bool isYes = false;
  bool isNo = false;
  bool isSkip = false;
  bool isOnceInLife = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Have you done before this?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
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
                    style: isYes
                        ? OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          )
                        : OutlinedButton.styleFrom(),
                    onPressed: () {
                      isYes = true;
                      isNo = false;
                      isSkip = false;
                      setState(() {});
                    },
                    child: Text(
                      'Yes',
                      style:
                          isYes ? TextStyle(color: Colors.white) : TextStyle(),
                    )),
              ),
            ),
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
                      isYes = false;
                      isSkip = false;
                      setState(() {});
                    },
                    child: Text(
                      'No',
                      style:
                          isNo ? TextStyle(color: Colors.white) : TextStyle(),
                    )),
              ),
            ),
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
                    style: OutlinedButton.styleFrom(),
                    onPressed: () {
                      isSkip = true;
                      isNo = false;
                      isYes = false;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Alert!'),
                            content: Text(
                                'Do you want to skip this checkup for now'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () async {
                                    await widget.documentReference.update(
                                        {'checkUpList': FieldValue.delete()});
                                    widget.checkupsObjs[widget.index] =
                                        CheckUpmodel(
                                            checkUpName: widget
                                                .checkupsObjs[widget.index]
                                                .checkUpName,
                                            isDone: true,
                                            isSkip: false,
                                            dueDate: null,
                                            gapDuration: widget
                                                .checkupsObjs[widget.index]
                                                .gapDuration);
                                    var checkupMap = widget.checkupsObjs
                                        .map((e) => e.toMap())
                                        .toList();
                                    await widget.documentReference.update({
                                      'checkUpList':
                                          FieldValue.arrayUnion(checkupMap)
                                    });
                                    log('all done');
                                    if (widget.isFromDashBoard) {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return UserDashBoard();
                                        },
                                      ));
                                    } else {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return CheckupList(
                                            length: widget.checkupsObjs.length,
                                          );
                                        },
                                      ));
                                    }
                                  },
                                  child: Text('Yes')),
                            ],
                          );
                        },
                      );
                      setState(() {});
                    },
                    child: Text(
                      'Skip',
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (isYes)
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                'When did you do this?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
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
          if (isYes || isNo)
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
                        firstDate: isYes ? DateTime(1950) : DateTime.now(),
                        lastDate: isYes ? DateTime.now() : DateTime(2050));
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
      floatingActionButton: Visibility(
        visible: isYes || isNo,
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
                //-------------------start------------------
                if (isYes) {
                  if (gapDuration == GapDuration.afterAYear) {
                    print('before checkup date $checkupDate');
                    checkupDate = checkupDate.add(Duration(days: 365));
                    print('after checkup date $checkupDate');
                  } else if (gapDuration == GapDuration.afterSixMonth) {
                    print('before checkup date $checkupDate');
                    checkupDate = checkupDate.add(Duration(days: 365 ~/ 2));

                    print('after checkup date $checkupDate');
                  } else if (gapDuration == GapDuration.afterTenYears) {
                    print('before checkup date $checkupDate');

                    checkupDate = checkupDate.add(Duration(days: 365 * 10));

                    print('after checkup date $checkupDate');
                  } else if (gapDuration == GapDuration.afterThreeYears) {
                    print('before checkup date $checkupDate');
                    print('----------------------');
                    checkupDate = checkupDate.add(Duration(days: 365 * 3));
                    print('after checkup date $checkupDate');
                  } else if (gapDuration == GapDuration.afterTwoYear) {
                    print('before checkup date $checkupDate');

                    checkupDate = checkupDate.add(Duration(days: 365 * 2));

                    print('after checkup date $checkupDate');
                  } else if (gapDuration == GapDuration.onceInLifeTime) {
                    isOnceInLife = true;
                    print('once in a life $checkupDate ');
                  }
                }

                //-------------------end------------------

                if (isYes) {
                  await widget.documentReference
                      .update({'checkUpList': FieldValue.delete()});
                  widget.checkupsObjs[widget.index] = CheckUpmodel(
                      checkUpName:
                          widget.checkupsObjs[widget.index].checkUpName,
                      isDone: isOnceInLife ? true : false,
                      isSkip: false,
                      dueDate: gapDuration == GapDuration.onceInLifeTime
                          ? null
                          : checkupDate,
                      gapDuration: gapDuration);
                  var checkupMap =
                      widget.checkupsObjs.map((e) => e.toMap()).toList();
                  await widget.documentReference.update(
                      {'checkUpList': FieldValue.arrayUnion(checkupMap)});
                  log('all done');
                  if (widget.isFromDashBoard) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return UserDashBoard();
                      },
                    ));
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return CheckupList(
                          length: widget.checkupsObjs.length,
                        );
                      },
                    ));
                  }
                } else if (isNo) {
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

                  if (widget.isFromDashBoard) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return UserDashBoard();
                      },
                    ));
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return CheckupList(
                          length: widget.checkupsObjs.length,
                        );
                      },
                    ));
                  }
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
