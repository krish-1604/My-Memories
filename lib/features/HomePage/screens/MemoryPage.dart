import 'dart:io';
import 'package:flutter/material.dart';

class MemoryPage extends StatefulWidget {
  final String title;
  final String details;
  final String fromDate;
  final String toDate;
  final String keywords;
  final List<File> images;

  MemoryPage({
    Key? key,
    required this.title,
    required this.details,
    required this.fromDate,
    required this.toDate,
    required this.keywords,
    required this.images,
  }) : super(key: key);

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
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(imagePath: widget.images[index].path),
                      ),
                    );
                  },
                  child: Image.file(widget.images[index], fit: BoxFit.cover),
                );
              },
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

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  const FullScreenImage({Key? key, required this.imagePath}) : super(key: key);

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
      body: Center(
        child: InteractiveViewer(
          child: Image.file(File(imagePath)),
        ),
      ),
    );
  }
}
