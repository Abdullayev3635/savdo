

class TulovClientDebitCreditModel {
  String? name;
  int? value;

  TulovClientDebitCreditModel({this.name, this.value});

  TulovClientDebitCreditModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
