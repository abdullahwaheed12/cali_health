import 'package:cali_health/pages/user_dashboard.dart';
import 'package:flutter/material.dart';

class CheckupFinalRedirect extends StatelessWidget {
  const CheckupFinalRedirect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return UserDashBoard();
        },
      ), (route) => false);
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50),
            child: Image(
              image: const AssetImage("assets/images/mainlogo.png"),
              width: MediaQuery.of(context).size.width / 5,
            ),
          ),
          SizedBox(
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
                "Thanks! We will now redirect you to your personal health profile.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 26,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
