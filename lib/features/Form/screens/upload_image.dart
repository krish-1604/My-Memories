import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymemories/features/Form/screens/uuid1.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
class UploadImage extends StatefulWidget {
  String title;
  String keywords;
  String details;
  String fromDate;
  String toDate;
  UploadImage({super.key,required this.title,required this.keywords,required this.details,required this.fromDate,required this.toDate});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  List<XFile> pickedImages = [];
  final Uuid uuid = Uuid();
  late String generatedUUID;

  void generateUUID() {
    setState(() {
      generatedUUID = uuid.v4();
    });
  }

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
        child: Column(
          children: [
            TextButton(
              onPressed: pickImages,
              child: const Text("Pick Images"),
            ),
            Expanded(
              child: ListView(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: pickedImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Image.file(
                            File(pickedImages[index].path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade200,
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    pickedImages.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: TextButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                pickedImages.isEmpty
                                    ? Colors.grey
                                    : const Color.fromRGBO(0, 178, 255, 1)),
                            foregroundColor: WidgetStateProperty.all<Color>(
                                pickedImages.isEmpty ? Colors.black45 : Colors.black),
                          ),
                          onPressed: pickedImages.isEmpty ? null : () {
                            generateUUID();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Uuid1(uuid: generatedUUID,)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Submit"),
                                SizedBox(width: 5),
                                Icon(Icons.arrow_forward_ios, size: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    try {
      List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        setState(() {
          pickedImages.addAll(selectedImages);
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }
}
