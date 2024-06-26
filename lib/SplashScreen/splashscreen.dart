import 'package:flutter/material.dart';
import 'package:mymemories/features/authentication/screens/loginscreen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Center the image within the Scaffold
      body: Center(
        child:  Image.asset('assets/logo.png'), // Replace 'assets/splash.png' with your image path
      ),
    );
  }
}

