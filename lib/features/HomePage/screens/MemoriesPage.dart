import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/HomePage/screens/HomePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mymemories/features/HomePage/screens/MemoriesEditPage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Memoriespage extends StatefulWidget {
  final FormModel formModel;

  const Memoriespage({Key? key, required this.formModel}) : super(key: key);

  @override
  State<Memoriespage> createState() => _MemoriespageState();
}

class _MemoriespageState extends State<Memoriespage> {
  List<String> images = [];
  final FormProvider formProvider = FormProvider();
  final DirectoryData directoryData = DirectoryData(FormProvider());
  int _selectedIndex = -1; // Start with no item selected

  @override
  void initState() {
    super.initState();
    stringToList();
  }

  void onItemTapped(int index) {
    if (index == _selectedIndex) {
      setState(() {
        _selectedIndex = -1;
      });
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // edit
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MemoriesEditpage(
                      formModel: widget.formModel,
                    )));
        break;
      case 1: // delete
        deleteMemoryConfirmation(context);
        break;
    }
  }

  void stringToList() {
    String removedoublequotes = widget.formModel.imagesURL.replaceAll('"', "");
    String removedoublequotes2 = removedoublequotes.replaceAll(" ", "");
    setState(() {
      images = removedoublequotes2.split(",");
    });
  }

  void deleteMemoryConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF060913),
          title: Text(
            "Delete Memory",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Text(
            "Are you sure you want to delete this memory?",
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = -1; // Reset the selection
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                  (Route<dynamic> route) => false,
                );
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF060913),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.formModel.title,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF060913),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 500.0,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.7,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index, realIdx) {
                      return Center(
                        child: GestureDetector(
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
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.file(
                                      File(images[index].replaceAll(r'\', '')),
                                      fit: BoxFit.cover,
                                      width: 1000.0),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF060913),
                                            Color(0xFF060913),
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF0A0F1F),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      widget.formModel.toDate != null &&
                              widget.formModel.toDate.isNotEmpty
                          ? Text(
                              "${widget.formModel.fromDate}    to   ${widget.formModel.toDate}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              "${widget.formModel.fromDate}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF0F162F),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blue,
                              width: 3,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "${widget.formModel.details}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.formModel.keywords.isNotEmpty) ...{
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hashtags:${widget.formModel.keywords}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      },
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF060913),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => onItemTapped(0),
              child: Icon(color: Colors.white, Icons.edit_outlined),
            ),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => onItemTapped(1),
              child: Icon(color: Colors.white, Icons.delete_outline),
            ),
            label: 'Delete',
          ),
        ],
        currentIndex: _selectedIndex != -1 ? _selectedIndex : 0,
        selectedItemColor: _selectedIndex != -1 ? Colors.blue : Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onItemTapped,
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImage({Key? key, required this.images, required this.initialIndex})
      : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _showBackButton = true;

  void _toggleBackButton() {
    setState(() {
      _showBackButton = !_showBackButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060913),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleBackButton,
            child: PhotoViewGallery.builder(
              itemCount: widget.images.length,
              builder: (context, index) {
                print("paths-------------------${widget.images}");
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(
                    File(widget.images[index]),
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: widget.images[index]),
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: Color(0xFF060913),
              ),
              pageController: PageController(initialPage: widget.initialIndex),
            ),
          ),
          AnimatedOpacity(
            opacity: _showBackButton ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
