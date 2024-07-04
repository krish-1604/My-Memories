import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';

class MemoryPage extends StatefulWidget {
  final FormModel formModel;
  // final String title;
  // final String details;
  // final String fromDate;
  // final String toDate;
  // final String keywords;
  // final List<XFile>? images;

  MemoryPage({
    Key? key,
    required this.formModel,
    // required this.title,
    // required this.details,
    // required this.fromDate,
    // required this.toDate,
    // required this.keywords,
    // this.images,
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
                widget.formModel.title,
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
                "${widget.formModel.fromDate} to ${widget.formModel.toDate}",
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

            // widget.images != [] ?
            //
            // Container(
            //   height: 300, // Set a fixed height for the GridView
            //   child: GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       crossAxisSpacing: 4.0,
            //       mainAxisSpacing: 4.0,
            //     ),
            //     itemCount: widget.images!.length ?? 0,
            //     itemBuilder: (context, index) {
            //       File imageFile = File(widget.images![index].path);
            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => FullScreenImage(imagePath: imageFile.path),
            //             ),
            //           );
            //         },
            //         child: Image.file(imageFile, fit: BoxFit.cover),
            //       );
            //     },
            //   ),
            // ):SizedBox(),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "${widget.formModel.details}",
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
