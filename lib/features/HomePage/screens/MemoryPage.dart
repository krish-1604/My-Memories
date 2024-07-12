import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/HomePage/screens/HomePage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MemoryPage extends StatefulWidget {
  final FormModel formModel;
  MemoryPage({Key? key, required this.formModel}) : super(key: key);

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  List<String> images = [];
  final FormProvider formProvider = FormProvider();
  final DirectoryData directoryData = DirectoryData(FormProvider());

  @override
  void initState() {
    super.initState();
    stringtoList();
  }

  void stringtoList() {
    String removedoublequotes = widget.formModel.imagesURL.replaceAll('"', "");
    String removedoublequotes2 = removedoublequotes.replaceAll(" ", "");
    images = removedoublequotes2.split(",");
  }

  void deletememoryconfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Memory"),
          content: Text("Are you sure you want to delete this memory?"),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                        (Route<dynamic> route) => false);
                directoryData.deleteFolder(widget.formModel.id);
                formProvider.deleteMemory(widget.formModel);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(images);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.formModel.title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        children: [
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
          Container(
            height: 400,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          images: images,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    File(images[index]),
                    fit: BoxFit.cover,
                  ),
                );
              },
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                viewportFraction: 0.8,
              ),
            ),
          ),
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
          SizedBox(
            height: 35,
          ),
          Center(
            child: SizedBox(
              height: 60,
              width: 140,
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  deletememoryconfirmation(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImage({Key? key, required this.images, required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: PhotoViewGallery.builder(
          itemCount: images.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: FileImage(
                File(images[index]),
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              initialScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(initialPage: initialIndex),
        ),
      ),
    );
  }
}
