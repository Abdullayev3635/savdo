class CategoryModel {
  int? id;
  String? name;
  String? image;
  int? count;

  CategoryModel({this.id, this.name, this.image, this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['count'] = count;
    return data;
  }
}
