class SavdoTuriModel {
  int? id;
  String? nomi;

  SavdoTuriModel({this.id, this.nomi});

  SavdoTuriModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomi = json['nomi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nomi'] = nomi;
    return data;
  }
}