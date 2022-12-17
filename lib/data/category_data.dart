class Category {
  String? title;
  String? description;
  String? addedAt;

  Category({this.title, this.description, this.addedAt});

  Category.fromJson(Map json) {
    title = json["title"];
    description = json["description"];
    addedAt = json["added_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["added_at"] = addedAt;
    return data;
  }
}
