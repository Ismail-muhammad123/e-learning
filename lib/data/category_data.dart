import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? id;
  String? title;
  String? description;
  Timestamp? addedAt;
  String? thumbnail;

  Category({this.title, this.description, this.addedAt});

  Category.fromJson(Map json) {
    title = json["title"];
    description = json["description"];
    addedAt = json["added at"];
    thumbnail = json["thumbnail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["added at"] = addedAt;
    data["thumbnail"] = thumbnail;
    return data;
  }
}
