import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/HomePage/screens/HomePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
        _selectedIndex = -1; // Deselect if tapped again
      });
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // edit
        // Handle edit functionality here
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
          title: Text("Delete Memory"),
          content: Text("Are you sure you want to delete this memory?"),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  _selectedIndex = -1; // Reset the selection
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
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
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.file(File(images[index]),
                                  fit: BoxFit.cover, width: 1000.0),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
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
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "${widget.formModel.fromDate}    to   ${widget.formModel.toDate}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 93, 164),
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "${widget.formModel.details}",
                            style: TextStyle(
                              color: Color.fromARGB(255, 2, 93, 164),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => onItemTapped(0),
              child: Icon(Icons.edit_outlined),
            ),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => onItemTapped(1),
              child: Icon(Icons.delete_outline),
            ),
            label: 'Delete',
          ),
        ],
        currentIndex: _selectedIndex != -1 ? _selectedIndex : 0,
        selectedItemColor: _selectedIndex != -1 ? Colors.blue : Colors.grey,
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleBackButton,
            child: PhotoViewGallery.builder(
              itemCount: widget.images.length,
              builder: (context, index) {
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
                color: Colors.black,
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
