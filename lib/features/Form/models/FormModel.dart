import 'package:image_picker/image_picker.dart';

class FormModel {
  late String id;
  late String title;
  late String fromDate;
  late String toDate;
  late String keywords;
  late String details;
  late List<XFile> images;

  FormModel({
    required this.id,
    required this.title,
    required this.fromDate,
    required this.toDate,
    required this.keywords,
    required this.details,
    this.images = const [],
  });

  FormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    keywords = json['keywords'];
    details = json['details'];
    if (json['images'] != null) {
      images = (json['images'] as List).map((i) => XFile(i)).toList();
    } else {
      images = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['keywords'] = this.keywords;
    data['details'] = this.details;
    data['images'] = this.images.map((i) => i.path).toList();
    return data;
  }
}
