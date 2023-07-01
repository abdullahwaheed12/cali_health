import 'package:cali_health/pages/welcome.dart';
import 'package:cali_health/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
          'Mein persönliches Profil',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 4.6,
            child: const Image(
              image: AssetImage("assets/images/healthlogo.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 100,
              height: MediaQuery.of(context).size.height / 6,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Allgemeine Informationen:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Name:                    ${GetStorage().read(nameKey)}"),
                      Text(
                          "Alter::                      ${GetStorage().read(ageKey)}"),
                      Text(
                          "Geschlecht::           ${GetStorage().read(genderKey)}"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 100,
              height: MediaQuery.of(context).size.height / 6,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Persönliche Angaben:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Körpergröße:       ${GetStorage().read(heightKey)} cm"),
                      Text(
                          "Körpergewicht:   ${GetStorage().read(weightKey)} kg"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(GetStorage().read(docIdKey))
                  .delete();
              GetStorage().erase();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (route) => false);
            },
            child: Container(
                height: 20,
                child: Text('Ich möchte die App vollständig resetten.')),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
