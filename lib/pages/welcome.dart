import 'package:cali_health/pages/name.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Welcome to cali health",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 100,
                  child: Hero(
                    tag: 'image1',
                    child: Image.asset('assets/images/mainlogo.png'),
                  ),
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
                  // height: 50,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(
                      0xff09358A,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Hi, I'm Cali,\n\nI will be your personal health manager\nFirst of all, please answer some\nquestions.",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 26,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.extended(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Name()));
                      },
                      label: Text(
                        "  Ok  ",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     elevation: 0,
      //     backgroundColor: Colors.white,
      //     shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(18),
      //         side: BorderSide(color: Theme.of(context).primaryColor)),
      //     onPressed: () {
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => const Name()));
      //     },
      //     label: Text(
      //       "  Ok  ",
      //       style: TextStyle(color: Theme.of(context).primaryColor),
      //     ))
    );
  }
}
