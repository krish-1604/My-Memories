import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/Form/screens/Multiple%20days/asking_for_detail.dart';
import 'package:provider/provider.dart';

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, form, child) => WillPopScope(
        onWillPop: () => form.onWillPop1(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF060913),
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                form.clearForm1();
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: form.formKey,
                child: Theme(
                  data: ThemeData(
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.blue,
                        selectionHandleColor: Colors.blue,
                        selectionColor: Colors.blue,
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: form.titleController,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Border color and width when focused
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white!, width: 1.0), // Border color and width when not focused
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
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: form.fromDateController,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'From Date is required';
                          }
                          return null;
                        },
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "From Date",
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
                          suffixIcon: const Icon(
                              color: Colors.white, Icons.calendar_today),
                        ),
                        onTap: () {
                          form.selectFromDate(context);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: form.toDateController,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'To Date is required';
                          }
                          return null;
                        },
                        cursorColor: Colors.blue,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "To Date",
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
                          suffixIcon: const Icon(color:Colors.white,Icons.calendar_today),
                        ),
                        onTap: () {
                          form.selectToDate(context);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: form.keywordsController,
                          onChanged: form.handlehashtagInput,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            hintText:
                                "Use HashTags(#) and give space.\nThis will be used for Searching",
                            hintStyle: TextStyle(fontSize: 15,color: Colors.white),
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        runSpacing: 4,
                        children: form.hashtags.map((tag) {
                          return Chip(
                            backgroundColor: Color(0xFF0F162F),
                            label: Text(tag),
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            deleteIcon: Icon(color:Colors.white,Icons.close),
                            onDeleted: () => form.removeHashtag(tag),
                          );
                        }).toList(),
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
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
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
                                if (form.formKey.currentState!.validate()) {
                                  print(form.hashtags);
                                  print(form.hashtaglisttostring());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage()));
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
        ),
      ),
    );
  }
}
