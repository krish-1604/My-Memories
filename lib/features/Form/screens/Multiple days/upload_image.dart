import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/HomePage/screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class UploadImage extends StatefulWidget {
  UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  late DirectoryData directoryData;
  @override
  void initState() {
    super.initState();
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    formProvider.generatedUUID = formProvider.uuid.v4();
    directoryData = DirectoryData(formProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, form, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF060913),
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(color: Colors.white, Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: const Image(
            height: 76,
            image: AssetImage(
              "assets/dark_logo.png",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextButton(
                onPressed: form.pickImages,
                child: Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFF0A0F1F),
                        borderRadius: BorderRadius.circular(20)),
                    child: form.pickedImages.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "Click Here",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : ListView(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: form.pickedImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      Image.file(
                                        File(form.pickedImages[index].path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey[800],
                                          child: IconButton(
                                            icon: const Icon(Icons.close,
                                                color: Colors.white),
                                            onPressed: () {
                                              setState(() {
                                                form.pickedImages
                                                    .removeAt(index);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          )),
              ),
              SizedBox(height: 20),
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
                            form.pickedImages.isEmpty
                                ? Colors.grey
                                : const Color.fromRGBO(0, 178, 255, 1)),
                        foregroundColor: WidgetStateProperty.all<Color>(
                            form.pickedImages.isEmpty
                                ? Colors.black45
                                : Colors.black),
                      ),
                      onPressed: form.pickedImages.isEmpty
                          ? null
                          : () async {
                              form.generatedUUID;
                              await directoryData.SaveImages(
                                  "MyMemories", form);
                              form.clearForm1();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()),
                                  (Route<dynamic> route) => false);
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
      ),
    );
  }
}
