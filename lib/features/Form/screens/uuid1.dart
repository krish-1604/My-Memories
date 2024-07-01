import 'package:flutter/material.dart';

class Uuid1 extends StatefulWidget {
  String uuid;
  Uuid1({super.key, required this.uuid});

  @override
  State<Uuid1> createState() => _Uuid1State();
}

class _Uuid1State extends State<Uuid1> {
  @override
  Widget build(BuildContext context) {
    print("-----------------------${widget.uuid}");
    return Scaffold();
  }
}
