class Level {
  int? id;
  String? name;
  int? category;

  Level({this.name});

  Level.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    category = json["category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["category"] = category;
    return data;
  }
}
