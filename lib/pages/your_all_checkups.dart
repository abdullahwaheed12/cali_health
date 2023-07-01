import 'package:cali_health/models/checkmodel.dart';
import 'package:cali_health/pages/edit_checkup.dart';
import 'package:cali_health/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class YourAllCheckups extends StatefulWidget {
  const YourAllCheckups({
    Key? key,
  }) : super(key: key);
  @override
  State<YourAllCheckups> createState() => _YourAllCheckupsState();
}

class _YourAllCheckupsState extends State<YourAllCheckups> {
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
        title: Text(
          'Meine Check-Ups',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    print('date222222222222 $checkupsObjs');
                    return ListView.builder(
                      itemCount: checkupsObjs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var checkupsObj = checkupsObjs[index];

                        return Column(
                          children: [
                            Card(
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
                                  // alignment: Alignment.center,
                                  child: Text('Due date: \n' +
                                      (checkupsObj.dueDate != null
                                          ? checkupsObj.dueDate!
                                              .toString()
                                              .substring(0, 10)
                                          : checkupsObj.gapDuration ==
                                                  GapDuration.onceInLifeTime
                                              ? 'done'
                                              : 'Skip')),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return CheckupDetailFromDashboard(
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
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
