// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cali_health/models/checkmodel.dart';
import 'package:cali_health/pages/profile.dart';
import 'package:cali_health/pages/your_all_checkups.dart';
import 'package:cali_health/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';

class UserDashBoard extends StatelessWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(GetStorage().read(docIdKey))
              .collection('checkUpListCollection')
              .doc('checkUpListDoc')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var list = snapshot.data!.data()?['checkUpList'] ?? [];

            return EvenetBuilder(
              list: list,
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EvenetBuilder extends StatefulWidget {
  EvenetBuilder({Key? key, this.list}) : super(key: key);
  dynamic list;

  @override
  State<EvenetBuilder> createState() => _EvenetBuilderState();
}

class _EvenetBuilderState extends State<EvenetBuilder> {
  late final ValueNotifier<List<dynamic>> _selectedEventss;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEventss = ValueNotifier(_getEventssForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEventss.dispose();
    super.dispose();
  }

  List<dynamic> _getEventssForDay(DateTime date) {
    var checkup = DateTime(date.year, date.month, date.day);
    var list = [];
    // print('--------------length--------------${widget.list}');
    for (var e in widget.list) {
      var checkUpModel = CheckUpmodel.fromMap(e);
      print('e  $e');
      if (checkUpModel.dueDate != null && !checkUpModel.isDone) {
        var dateModel = DateTime(checkUpModel.dueDate!.year,
            checkUpModel.dueDate!.month, checkUpModel.dueDate!.day);
        if (dateModel == checkup) {
          print('hi');
          list.add(e);
        }
      }
    }
    print(list);
    return list;
  }

  List<CheckUpmodel> _getEventssForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = [DateTime(2012), DateTime(2015)];

    return [
      for (final d in days) ..._getEventssForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEventss.value = _getEventssForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEventss.value = _getEventssForRange(start, end);
    } else if (start != null) {
      _selectedEventss.value = _getEventssForDay(start);
    } else if (end != null) {
      _selectedEventss.value = _getEventssForDay(end);
    }
  }

  var forSelection = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello,',
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                '${GetStorage().read(nameKey)}',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300),
                            child: Text(
                              GetStorage()
                                  .read(nameKey)
                                  .toString()
                                  .substring(0, 1),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: SizedBox(
                        height: size.width * 0.35,
                        width: size.width * 0.27,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child:
                                  Image.asset('assets/images/Risikoprofil.png'),
                            ),
                            Text('Risikoprofil')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return YourAllCheckups();
                            },
                          ));
                        },
                        child: SizedBox(
                          height: size.width * 0.35,
                          width: size.width * 0.27,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/samsunghealth.png'),
                              Text('Check-Ups')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: size.width * 0.35,
                        width: size.width * 0.27,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/Anamnese.png'),
                            Text('Anamnese')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: SizedBox(
                        height: size.width * 0.35,
                        width: size.width * 0.27,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: size.width * 0.25,
                              width: size.width * 0.20,
                              child: Image.asset(
                                  'assets/images/Mental Health.png'),
                            ),
                            Text('Mental Health')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: size.width * 0.35,
                        width: size.width * 0.27,
                        child: Column(
                          children: [
                            SizedBox(
                                height: size.width * 0.25,
                                width: size.width * 0.20,
                                child: Image.asset(
                                    'assets/images/Laborwerte.png')),
                            Text('Laborwerte')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: size.width * 0.35,
                        width: size.width * 0.27,
                        child: Column(
                          children: [
                            SizedBox(
                                height: size.width * 0.25,
                                width: size.width * 0.20,
                                child: Image.asset(
                                    'assets/images/Vitalwerte.png')),
                            Text('Vitalwerte')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your next check-Ups:",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                      List checkupsMap = [];
                      if (docSnapshot.data!.data() != null &&
                          docSnapshot.data!.data()!.isNotEmpty) {
                        checkupsMap = docSnapshot.data!.data()!['checkUpList'];
                      }
                      List<CheckUpmodel> checkupsObjs = [];
                      for (var element in checkupsMap) {
                        var checkUpModel = CheckUpmodel.fromMap(element);
                        if (checkUpModel.dueDate != null &&
                            !checkUpModel.isDone) {
                          checkupsObjs.add(checkUpModel);
                        }
                      }

                      print('2234354545 --------- $checkupsObjs');
                      return SizedBox(
                        height: checkupsObjs.length < 2 ? 150 : 200,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              checkupsObjs.length < 2 ? checkupsObjs.length : 2,
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
                                      color: forSelection.contains(checkupsObj)
                                          ? Colors.greenAccent[200]
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all()),
                                ),
                                onTap: () {
                                  _focusedDay = checkupsObj.dueDate!;
                                  _onDaySelected(_focusedDay, _focusedDay);
                                  if (!forSelection.contains(checkupsObj)) {
                                    forSelection.clear();
                                    forSelection.add(checkupsObj);
                                    print(
                                        'container---- $forSelection----------');
                                  }
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }),
                TableCalendar<dynamic>(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(days: 365 * 3000)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: CalendarFormat.twoWeeks,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventssForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 200,
                  child: ValueListenableBuilder<List<dynamic>>(
                    valueListenable: _selectedEventss,
                    builder: (context, value, _) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          var checkupsObj = CheckUpmodel.fromMap(value[index]);
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
                                    color: checkupsObj.isDone
                                        ? Colors.greenAccent[200]
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
