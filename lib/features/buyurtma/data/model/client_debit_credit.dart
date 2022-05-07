

// part 'client_debit_credit.g.dart';

// @HiveType(typeId: 7)
class ClientDebitCreditModel {
  // @HiveField(0)
  String? name;
  // @HiveField(1)
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
