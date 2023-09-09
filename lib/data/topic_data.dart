class Topic {
  int? id;
  String? name;
  String? subCategory;

  Topic({this.id, this.name, this.subCategory});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    subCategory = json["sub category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["sub category"] = subCategory;
    return data;
  }
}
