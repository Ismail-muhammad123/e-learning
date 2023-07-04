class Category {
  int? id;
  String? title;
  String? description;
  String? addedAt;
  String? thumbnail;

  Category({this.title, this.description, this.addedAt});

  Category.fromJson(Map json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    addedAt = json["added_at"];
    thumbnail = json["thumbnail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["added_at"] = addedAt;
    data["thumbnail"] = thumbnail;
    return data;
  }
}
