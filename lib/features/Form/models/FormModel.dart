class FormModel {
  late String id;
  late String title;
  late String fromDate;
  late String toDate;
  late String keywords;
  late String details;

  FormModel({
    required this.id,
    required this.title,
    required this.fromDate,
    required this.toDate,
    required this.keywords,
    required this.details,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['id'],
      title: json['title'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      keywords: json['keywords'],
      details: json['details'],
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
    };
  }
}
