class Lesson {
  String? title;
  String? note;
  String? video;
  String? thumbnail;
  String? category;
  String? tutor;
  String? addedAt;
  String? level;
  String? topic;

  Lesson(
      {this.title,
      this.note,
      this.video,
      this.category,
      this.thumbnail,
      this.level,
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
    level = json["level"];
    topic = json["topic"];
    addedAt = json["added_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["note"] = note;
    data["thumbnail"] = thumbnail;
    data["level"] = level;
    data["topic"] = topic;
    data["video"] = video;
    data["category"] = category;
    data["tutor"] = tutor;
    data["added_at"] = addedAt;
    return data;
  }
}
