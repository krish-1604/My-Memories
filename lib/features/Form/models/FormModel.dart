import 'dart:convert';

class FormModel {
  late String id;
  late String title;
  late String fromDate;
  late String toDate;
  late String keywords;
  late String details;
  late List<String> imagesURLs;

  FormModel({
    required this.id,
    required this.title,
    required this.fromDate,
    required this.toDate,
    required this.keywords,
    required this.details,
    required this.imagesURLs,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      fromDate: json['fromDate'] ?? '',
      toDate: json['toDate'] ?? '',
      keywords: json['keywords'] ?? '',
      details: json['details'] ?? '',
      imagesURLs: json['imagesURLs'] != null
          ? List<String>.from(jsonDecode(json['imagesURLs']))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fromDate': fromDate,
      'toDate': toDate,
      'keywords': keywords,
      'details': details,
      'imagesURLs': jsonEncode(imagesURLs),
    };
  }
}
