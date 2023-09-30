import 'package:flutter/material.dart';
import 'package:our_flutter_team/screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

String myUID = '';
String myEmail = '';
String myName = '';
String myPhn = '';
String myInstitute = '';
String myProfile = '';
String myBatch = '';
String myBatchID = '';
String myPassword = '';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myUID = prefs.getString("uid") ?? '';
      myName = prefs.getString("name") ?? '';
      myEmail = prefs.getString("email") ?? '';
    });
    if (myUID != '' || myName != '' || myEmail != '') {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (r) => false),
      );
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (r) => false),
      );
    }
  }

  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('asset/image/splash.png'))),
        ));
  }
}
