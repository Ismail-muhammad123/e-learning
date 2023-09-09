import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String? title;
  String? note;
  String? video;
  String? thumbnail;
  String? category;
  String? tutor;
  Timestamp? addedAt;
  String? subCategory;
  String? topic;

  Lesson(
      {this.title,
      this.note,
      this.video,
      this.category,
      this.thumbnail,
      this.subCategory,
      this.topic,
      this.tutor,
      this.addedAt});

  Lesson.fromJson(Map json) {
    title = json["title"];
    note = json["note"];
    thumbnail = json["thumbnail"];
    video = json["video"];
    category = json["category"];
    tutor = json["tutor"];
    subCategory = json["sub category"];
    topic = json["topic"];
    addedAt = json["added at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["note"] = note;
    data["thumbnail"] = thumbnail;
    data["sub category"] = subCategory;
    data["topic"] = topic;
    data["video"] = video;
    data["category"] = category;
    data["tutor"] = tutor;
    data["added at"] = addedAt;
    return data;
  }
}
