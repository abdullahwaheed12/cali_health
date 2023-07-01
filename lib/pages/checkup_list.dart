import 'package:cali_health/models/checkmodel.dart';
import 'package:cali_health/pages/checkup_data_detail_registration_form.dart';
import 'package:cali_health/pages/checkup_final_redirect.dart';
import 'package:cali_health/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CheckupList extends StatefulWidget {
  const CheckupList({Key? key, required this.length}) : super(key: key);
  final int length;
  @override
  State<CheckupList> createState() => _CheckupListState();
}

class _CheckupListState extends State<CheckupList> {
  @override
  Widget build(BuildContext context) {
    var isDone = false;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 10,
              ),
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
                  "Thanks for waiting. Evaluating your \n gender and age there are ${widget.length} screening \n check ups  you need to do.",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 26,
                      color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(GetStorage().read(docIdKey))
                      .collection('checkUpListCollection')
                      .doc('checkUpListDoc')
                      .get(),
                  builder: (context, docSnapshot) {
                    if (!docSnapshot.hasData &&
                        docSnapshot.connectionState ==
                            ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    print(docSnapshot.data!.data());
                    List checkupsMap = [];
                    if (docSnapshot.data!.data() != null &&
                        docSnapshot.data!.data()!.isNotEmpty) {
                      checkupsMap = docSnapshot.data!.data()!['checkUpList'];
                    }
                    var checkupsObjs = checkupsMap
                        .map((e) => CheckUpmodel.fromMap(e))
                        .toList();
                    isDone = checkupsObjs.every((element) {
                      if (element.dueDate != null ||
                          element.isDone ||
                          element.isSkip) {
                        return true;
                      } else {
                        return false;
                      }
                    });
                    return ListView.builder(
                      itemCount: checkupsObjs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var checkupsObj = checkupsObjs[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 10,
                          child: ListTile(
                            leading: Text('(${index + 1})'),
                            title: Text(
                              checkupsObj.checkUpName,
                              style: const TextStyle(),
                            ),
                            trailing: Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: checkupsObj.dueDate != null ||
                                          checkupsObj.isDone ||
                                          checkupsObj.isSkip
                                      ? Colors.greenAccent[200]
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all()),
                              child: Icon(
                                Icons.check,
                                size: 15,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CheckupDataDetailRegistraionForm(
                                    isFromDashBoard: false,
                                    index: index,
                                    checkupsObj: checkupsObj,
                                    documentReference:
                                        docSnapshot.data!.reference,
                                    checkupsObjs: checkupsObjs,
                                  );
                                },
                              ));
                            },
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Theme.of(context).primaryColor)),
          onPressed: () {
            if (isDone) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return CheckupFinalRedirect();
                },
              ));
              GetStorage().write(isLoginKey, true);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please set checkup date for all tests')));
            }
          },
          label: Text(
            "  Done  ",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
