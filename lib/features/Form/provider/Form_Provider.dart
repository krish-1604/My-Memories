import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymemories/features/Form/Database/DbHelper.dart';
import 'package:mymemories/features/Form/Database/ImageDirectory.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:uuid/uuid.dart';

class FormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  List<XFile> pickedImages = [];
  final DbHelper dbHelper = DbHelper.dbHelper;
  final Uuid uuid = Uuid();
  late String generatedUUID;
  List<FormModel> allMemories = [];
  late String fromDate;
  late String toDate;
  DirectoryData? directoryData;
  String mainDirectoryName = "My Memories";

  Future<void> selectFromDate(BuildContext context) async {
    DateTime? picked1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2200),
    );
    if (picked1 != null) {
      fromDateController.text = picked1.toString().split(" ")[0];
      fromDate = "${picked1.toString().split(" ")[0]}";
      notifyListeners();
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    DateTime? picked2 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2200),
    );
    if (picked2 != null) {
      if (picked2.isBefore(DateTime.parse(fromDate.split("T")[0]))) {
        showDialog(
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
        toDateController.text = picked2.toString().split(" ")[0];
        toDate = "${picked2.toString().split(" ")[0]}";
        notifyListeners();
      }
    }
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    try {
      List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        pickedImages.addAll(selectedImages);
        notifyListeners();
      }
      // List<String> selectedImgPath = [];
      //
      // for(var i in selectedImages){
      //   selectedImgPath.add(i.path);
      // }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  Future<void> fetchMemories() async {
    allMemories = await dbHelper.getAllMemories();
    notifyListeners();
  }

  insertMemory() async {
    print("Date===========> $fromDate");
    FormModel formModel = FormModel(
      id: generatedUUID,
      title: titleController.text,
      fromDate: fromDate,
      toDate: toDate,
      keywords: keywordsController.text,
      details: detailsController.text,
      imagesURLs: directoryData?.SaveImages(mainDirectoryName).imagepaths,
    );
    await dbHelper.insertNewMemory(formModel);
    allMemories.add(formModel);
    await fetchMemories();
  }

  Future<void> updateMemories(FormModel formModel) async {
    await dbHelper.updateMemory(formModel);
    await fetchMemories();
  }

  Future<void> deleteMemory(FormModel formModel) async {
    await dbHelper.deleteMemory(formModel);
    allMemories.remove(formModel);
    notifyListeners();
  }

  clearForm() {
    titleController.clear();
    fromDateController.clear();
    toDateController.clear();
    detailsController.clear();
    keywordsController.clear();
    pickedImages.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    keywordsController.dispose();
    super.dispose();
  }
}
