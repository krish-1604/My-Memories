import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeProvider extends ChangeNotifier{
  String? profileImage;
  GoogleSignInAccount? googleSignInAccount;

}