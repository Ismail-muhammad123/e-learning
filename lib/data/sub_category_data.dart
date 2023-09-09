class SUbCategory {
  int? id;
  String? name;
  String? category;
  String? thumbnail;
  SUbCategory({this.name});

  SUbCategory.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    thumbnail = json["thumbnail"];
    category = json["category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["category"] = category;
    data["thumbnail"] = thumbnail;

    return data;
  }
}
