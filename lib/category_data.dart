class Category {
  String? title;
  String? description;
  String? addedAt;
  String? image;

  Category({this.title, this.description, this.addedAt, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    addedAt = json["added_at"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["added_at"] = addedAt;
    data["image"] = image;
    return data;
  }
}
