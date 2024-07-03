import 'package:flutter/material.dart';
class MemoryPage extends StatefulWidget {
  final String title;
  final String details;
  final String fromDate;
  final String toDate;
  final String keywords;

  MemoryPage(
      {super.key,
      required this.title,
      required this.details,
      required this.fromDate,
      required this.toDate,
      required this.keywords});

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Image(
          height: 30,
          image: AssetImage(
            "assets/small_logo.png",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "${widget.fromDate} to ${widget.toDate}",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "${widget.details}",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
