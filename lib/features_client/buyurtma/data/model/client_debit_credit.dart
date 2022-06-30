class ClientDebitCreditModel {
  String? name;
  int? value;

  ClientDebitCreditModel({this.name, this.value});

  ClientDebitCreditModel.fromJson(Map<String, dynamic> json) {
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
