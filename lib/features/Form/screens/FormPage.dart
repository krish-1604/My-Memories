import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/screens/asking_for_detail.dart';

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _keywordsController = TextEditingController();

  String? fromDate;
  String? toDate;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
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
                    filled: true,
                    fillColor: Colors.grey[150],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _fromDateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'From Date is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "From Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.grey[150],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    _selectFromDate();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _toDateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'To Date is required';
                    }
                    return null;
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "To Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.grey[150],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    _selectToDate();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _keywordsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Keywords are required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Keywords [use Hashtags (#)]",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.grey[150],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                ),
                const SizedBox(height: 30,),
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
                          backgroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(0, 178, 255, 1)),
                          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(title: _titleController.text,keywords: _keywordsController.text,toDate: _toDateController.text,fromDate: _fromDateController.text,)));
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
    );
  }

  Future<void> _selectFromDate() async {
    DateTime? picked1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2200),
    );
    if (picked1 != null) {
      setState(() {
        _fromDateController.text = picked1.toString().split(" ")[0];
        fromDate = "${picked1.toString().split(" ")[0]}T00:00:00.000Z";
      });
    }
  }

  Future<void> _selectToDate() async {
    DateTime? picked2 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2200),
    );
    if (picked2 != null) {
      if (fromDate != null && picked2.isBefore(DateTime.parse(fromDate!.split("T")[0]))) {
        showDialog (
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Invalid Date"),
              content: const Text("To Date should be greater than From Date"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _toDateController.text = picked2.toString().split(" ")[0];
          toDate = "${picked2.toString().split(" ")[0]}T00:00:00.000Z";
        });
      }
    }
  }
}
