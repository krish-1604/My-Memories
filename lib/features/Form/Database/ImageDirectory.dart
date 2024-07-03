import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymemories/features/Form/provider/Form_Provider.dart';
import 'package:mymemories/features/HomePage/screens/MemoryPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DirectoryData extends ChangeNotifier {
  List<File> images = [];
  static const platform = MethodChannel('com.example.app/mediaScanner');
  List<DirectoryData> DirectoryDataList1 = [];
  late FormProvider formProvider;
  late String uuid = formProvider.generatedUUID;

  DirectoryData(FormProvider formProvider) {
    this.formProvider = formProvider; // Initialize in constructor
  }
  Future<void> requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<String> createMainDirectory(String mainDirectoryName) async {
    await requestPermission();
    Directory? externalDir = await getExternalStorageDirectory();
    String newPath = "${externalDir!.path}/$mainDirectoryName";
    final mainDir = Directory(newPath);
    if (!(await mainDir.exists())) {
      await mainDir.create(recursive: true);
    }
    return newPath;
  }

  Future<String> createSubDirectory(String mainDirectoryPath) async {
    String newPath = "$mainDirectoryPath/$uuid";
    final subDir = Directory(newPath);
    if (!(await subDir.exists())) {
      await subDir.create(recursive: true);
    }
    return newPath;
  }

  Future<void> loadSavedImages() async {
    String mainDirectoryName = "My Memories";
    String mainDirectoryPath = await createMainDirectory(mainDirectoryName);
    List<DirectoryData> directoryDataList = [];
    Directory mainDir = Directory(mainDirectoryPath);
    List<FileSystemEntity> subDirs = mainDir.listSync();
    for (var subDir in subDirs) {
      if (subDir is Directory) {
        DirectoryData directoryData = DirectoryData(formProvider);
        directoryData.uuid = subDir.path.split('/').last;
        await fetchImagesRecursively(subDir.path, directoryData);
        directoryDataList.add(directoryData);
      }
    }
    DirectoryDataList1 = directoryDataList;
    notifyListeners();
  }

  Future<void> fetchImagesRecursively(String directoryPath, DirectoryData directoryData) async {
    Directory directory = Directory(directoryPath);
    List<FileSystemEntity> entities = directory.listSync();
    for (var entity in entities) {
      if (entity is File && (entity.path.endsWith('.jpg')|| entity.path.endsWith('.png')|| entity.path.endsWith('.jpeg'))) {
        directoryData.images.add(entity);
      } else if (entity is Directory) {
        await fetchImagesRecursively(entity.path, directoryData);
      }
    }
  }

  Future<void> SaveImages(String mainDirectoryName) async {
    String mainDirectoryPath = await createMainDirectory(mainDirectoryName);
    String subDirectoryPath = await createSubDirectory(mainDirectoryPath);

    for (XFile image in formProvider.pickedImages) {
      String newFilePath = '$subDirectoryPath/${image.name}';
      File newImage = await File(image.path).copy(newFilePath);
      print("Image saved at: ${newImage.path}");
    }
    await triggerMediaScan(subDirectoryPath);
    await loadSavedImages();
  }
  Future<void> triggerMediaScan(String path) async {
    try {
      await platform.invokeMethod('scanFile', {'path': path});
    } on PlatformException catch (e) {
      print("Error triggering media scan: $e");
    }
  }

  void navigateToImages(BuildContext context,String title,String details,String fromDate,String toDate,String keywords,List<File> images) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemoryPage(title: title, details: details, fromDate: fromDate, toDate: toDate, keywords: keywords,images: images,)),
    );
  }
}
