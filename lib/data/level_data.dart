
class Level {
  String? name;

  Level({this.name});

  Level.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    return _data;
  }
}