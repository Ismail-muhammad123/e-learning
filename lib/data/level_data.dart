class Level {
  String? name;

  Level({this.name});

  Level.fromJson(Map json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
  }
}
