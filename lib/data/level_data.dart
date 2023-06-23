class Level {
  int? id;
  String? name;
  int? category;
    String? thumbnail;


  Level({this.name});

  Level.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
        thumbnail = json["thumbnail_url"];
    category = json["category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["category"] = category;
        data["thumbnail_url"] = thumbnail;

    return data;
  }
}
