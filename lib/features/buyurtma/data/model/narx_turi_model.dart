class NarxTuriModel {
  int? id;
  String? nomi;
  double? kurs;

  NarxTuriModel({this.id, this.nomi, this.kurs});

  NarxTuriModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomi = json['nomi'];
    kurs = json['kurs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['nomi'] = this.nomi;
    data['kurs'] = this.kurs;
    return data;
  }
}