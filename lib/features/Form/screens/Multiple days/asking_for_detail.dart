import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/Form/screens/Multiple%20days/upload_image.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, form, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF060913),
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(color:Colors.white,Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: const Image(
            height: 76,
            image: AssetImage(
              "assets/dark_logo.png",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: form.formKey2,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Theme(
                      data: ThemeData(
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: Colors.blue,
                          selectionHandleColor: Colors.blue,
                          selectionColor: Colors.blue,
                        )
                      ),
                      child: TextFormField(
                        controller: form.detailsController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Details are required';
                          }
                          return null;
                        },
                        expands: true,
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.blue,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: "Details",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Border color and width when focused
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0), // Border color and width when not focused
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Color(0xFF0F162F),
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: TextButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromRGBO(0, 178, 255, 1)),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            if (form.formKey2.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UploadImage(),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Next"),
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
        ),
      ),
    );
  }
}
