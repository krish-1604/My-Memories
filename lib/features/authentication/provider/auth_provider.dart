import 'package:flutter/material.dart';
import 'package:mymemories/Apis/google_signin_api.dart';
import 'package:mymemories/features/HomePage/screens/HomePage.dart';
import 'dart:async';

class AuthenticationProvider extends ChangeNotifier {
  Future signIn(BuildContext context) async {
    final user = await GoogleSigninApi.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sign in Failed")));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Homepage()));
    }
  }
}
