import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  final GlobalKey<FormState> editformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editformKey2 = GlobalKey<FormState>();

  String hashtagtostring(List<String> hashtags){
    String editedkeyword = hashtags.join();
    return editedkeyword;
  }
}