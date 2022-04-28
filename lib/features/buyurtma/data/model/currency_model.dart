class CurrencyModel {
  int? id;
  String? name;
  String? value;

  CurrencyModel({this.id, this.name, this.value});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}