import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/HomePage/provider/home_provider.dart';
import 'package:mymemories/features/HomePage/screens/HomePage.dart';
import 'package:provider/provider.dart';

class MemoriesEditpage extends StatefulWidget {
  final FormModel formModel;

  MemoriesEditpage({Key? key, required this.formModel});

  @override
  State<MemoriesEditpage> createState() => _MemoriesEditpageState();
}

class _MemoriesEditpageState extends State<MemoriesEditpage> {
  late TextEditingController edittitlecontroller;
  late TextEditingController editdateController;
  late TextEditingController editFromDateController;
  late TextEditingController editToDateController;
  late TextEditingController editedKeywordsController;
  @override
  void initState() {
    super.initState();
    edittitlecontroller = TextEditingController(text: widget.formModel.title);
    editdateController = TextEditingController(text: widget.formModel.fromDate);
    editFromDateController = TextEditingController(text: widget.formModel.fromDate);
    editToDateController = TextEditingController(text: widget.formModel.toDate);
    editedKeywordsController = TextEditingController();
  }

  @override
  void dispose() {
    edittitlecontroller.dispose();
    editdateController.dispose();
    editFromDateController.dispose();
    editToDateController.dispose();
    editedKeywordsController.dispose();
    super.dispose();
  }
  String currentInput = '';
  List<String> editedHashtags = [];
  void removeEditedHashtag(String hashtag) {
    setState(() {
      editedHashtags.remove(hashtag);
    });
  }
  void handleEditHashtagInput(String input) {
    currentInput = input;
    setState(() {
      if (input.endsWith(' ')) {
        if (currentInput.trim().isNotEmpty) {
          if (!currentInput.trim().startsWith('#')) {
            currentInput = '#${currentInput.trim()}';
          }
          editedHashtags.add(currentInput.trim());
          editedKeywordsController.clear();
          currentInput = '';
        }
      }
    });
  }

  Future<void> selectEditedDate(BuildContext context) async {
    final ThemeData theme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(primary: Colors.blue),
    );
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        editdateController.text = pickedDate.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectEditedFromDate(BuildContext context) async {
    final ThemeData theme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(primary: Colors.blue),
    );
    DateTime? pickedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    if (pickedDate1 != null) {
      setState(() {
        editFromDateController.text = pickedDate1.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectEditedToDate(BuildContext context) async {
    final ThemeData theme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(primary: Colors.blue),
    );
    DateTime? pickedDate2 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    if (pickedDate2 != null) {
      setState(() {
        editToDateController.text = pickedDate2.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, FormProvider>(
      builder: (context, edit, form, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF060913),
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(color: Colors.white, Icons.arrow_back_ios),
          ),
          title: Text(
            "Edit",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: edit.editformKey,
              child: Theme(
                data: ThemeData(
                    textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.blue,
                  selectionHandleColor: Colors.blue,
                  selectionColor: Colors.blue,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: edittitlecontroller,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          // Border color and width when focused
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          // Border color and width when not focused
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
                    widget.formModel.toDate != null &&
                            widget.formModel.toDate.isNotEmpty
                        ? Column(
                            children: [
                              TextFormField(
                                readOnly: true,
                                controller: editFromDateController,
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
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    // Border color and width when focused
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                    // Border color and width when not focused
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
                                      color: Colors.white,
                                      Icons.calendar_today),
                                ),
                                onTap: () {
                                  selectEditedFromDate(context);
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: editToDateController,
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
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    // Border color and width when focused
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                    // Border color and width when not focused
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
                                      color: Colors.white,
                                      Icons.calendar_today),
                                ),
                                onTap: () {
                                  selectEditedToDate(context);
                                },
                              ),
                            ],
                          )
                        : TextFormField(
                            style: TextStyle(color: Colors.white),
                            readOnly: true,
                            controller: editdateController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Date is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Date",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                                // Border color and width when focused
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                // Border color and width when not focused
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
                              selectEditedDate(context);
                            },
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 80,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        expands: true,
                        maxLines: null,
                        controller: editedKeywordsController,
                        onChanged: handleEditHashtagInput,
                        decoration: InputDecoration(
                          hintText:
                              "Use HashTags(#) and give space.\nThis will be used for Searching",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            // Border color and width when focused
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            // Border color and width when not focused
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
                      children: editedHashtags.map((tag) {
                        return Chip(
                          backgroundColor: Color(0xFF0F162F),
                          label: Text(tag),
                          labelStyle: TextStyle(color: Colors.white),
                          deleteIcon: Icon(color: Colors.white, Icons.close),
                          onDeleted: () => removeEditedHashtag(tag),
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
                              if (edit.editformKey.currentState!.validate()) {
                                edit.hashtagtostring(editedHashtags);
                                print(editedHashtags.join(',').replaceAll("#", ""));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditDetailPage(
                                              formModel: widget.formModel,
                                              editedDate:
                                                  editdateController.text,
                                              editedtitle:
                                                  edittitlecontroller.text,
                                          editedFromDate: editFromDateController.text,
                                          editedToDate: editToDateController.text,
                                          editedKeywords: editedHashtags.join(',').replaceAll("#", ""),
                                            )));
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
    );
  }
}

class EditDetailPage extends StatefulWidget {
  final FormModel formModel;
  final String editedtitle;
  String? editedDate;
  String? editedFromDate;
  String? editedToDate;
  final String editedKeywords;
  EditDetailPage(
      {super.key,
      required this.formModel,
      required this.editedtitle,
      this.editedDate,
      this.editedFromDate,
      this.editedToDate,
      required this.editedKeywords});

  @override
  State<EditDetailPage> createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  late TextEditingController editDetailController;

  @override
  void initState() {
    super.initState();
    editDetailController =
        TextEditingController(text: widget.formModel.details);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, FormProvider>(
      builder: (context, edit, form, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF060913),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(color: Colors.white, Icons.arrow_back_ios),
          ),
          title: Text(
            "Edit",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: edit.editformKey2,
              child: Theme(
                data: ThemeData(
                    textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.blue,
                  selectionHandleColor: Colors.blue,
                  selectionColor: Colors.blue,
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.blue,
                        controller: editDetailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Details are required';
                          }
                          return null;
                        },
                        expands: true,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: "Details",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
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
                              if (edit.editformKey2.currentState!.validate()) {
                                widget.formModel.title = widget.editedtitle;
                                // widget.formModel.toDate!=null && widget.formModel.toDate.isNotEmpty? widget.formModel.fromDate = widget.editedFromDate!;widget.formModel.toDate = widget.editedTodate! :widget.formModel.fromDate = widget.editedDate!;
                                if (widget.formModel.toDate != null && widget.formModel.toDate.isNotEmpty) {
                                  widget.formModel.fromDate = widget.editedFromDate!;
                                  widget.formModel.toDate = widget.editedToDate!;
                                } else {
                                  widget.formModel.fromDate = widget.editedDate!;
                                }

                                widget.formModel.details =
                                    editDetailController.text;
                                widget.formModel.keywords = widget.editedKeywords;
                                form.updateMemories(widget.formModel);
                                print(widget.formModel.imagesURL);
                                print(widget.formModel.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
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
          ),
        ),
      ),
    );
  }
}
