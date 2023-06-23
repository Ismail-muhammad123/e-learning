class Topic {
  int? id;
  String? name;
  int? sub_category;

  Topic({this.id, this.name, this.sub_category});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    sub_category = json["sub_category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["sub_category"] = sub_category;
    return data;
  }
}
