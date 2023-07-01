import 'package:cali_health/pages/user_dashboard.dart';
import 'package:cali_health/pages/welcome.dart';
import 'package:cali_health/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Cali Health",
    theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(
          0xff09358A,
        ),
        colorScheme: ColorScheme.light(
            primary: Color(
          0xff09358A,
        )),
        scaffoldBackgroundColor: Color(0xffECF9FF)),
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          var box = GetStorage();
          var isLogin = box.read<bool>(isLoginKey) ?? false;

          if (!isLogin) {
            return const Welcome();
          } else {
            return UserDashBoard();
          }
        }), (route) => false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: SizedBox(
                height: 200,
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: Hero(
                      tag: 'image1',
                      child: Image.asset('assets/images/mainlogo.png')),
                )),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            'Cali Health',
            style: TextStyle(
                color: Color(
                  0xff09358A,
                ),
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
