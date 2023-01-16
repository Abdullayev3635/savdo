class YukBeruvchi {
  int? id;
  String? name;

  YukBeruvchi({
    this.id,
    this.name,
  });

  YukBeruvchi.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
