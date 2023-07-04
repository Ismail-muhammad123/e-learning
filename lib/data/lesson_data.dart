class Lesson {
  String? title;
  String? note;
  String? video;
  String? thumbnail;
  String? category;
  String? tutor;
  String? addedAt;
  int? sub_category;
  String? topic;

  Lesson(
      {this.title,
      this.note,
      this.video,
      this.category,
      this.thumbnail,
      this.sub_category,
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
    sub_category = json["sub_category"];
    topic = json["topic"];
    addedAt = json["added_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["note"] = note;
    data["thumbnail"] = thumbnail;
    data["sub_category"] = sub_category;
    data["topic"] = topic;
    data["video"] = video;
    data["category"] = category;
    data["tutor"] = tutor;
    data["added_at"] = addedAt;
    return data;
  }
}
