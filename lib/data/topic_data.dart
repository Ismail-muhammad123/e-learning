class Topic {
  int? id;
  String? name;
  int? level;

  Topic({this.id, this.name, this.level});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    level = json["level"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["level"] = level;
    return data;
  }
}
