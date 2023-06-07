import 'package:savdo_agnet_client/features/archive/data/model/total_price.dart';

class ArchiveModel {
  int? id;
  String? customerName;
  String? currencyName;
  String? date;
  List<TotalPrice>? totalPrice;
  String? status;

  ArchiveModel(
      {this.id,
      this.customerName,
      this.currencyName,
      this.date,
      this.totalPrice,
      this.status});

  ArchiveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    currencyName = json['currency_name'];
    date = json['date'];
    if (json['total_price'] != null) {
      totalPrice = <TotalPrice>[];
      json['total_price'].forEach((v) {
        totalPrice!.add(TotalPrice.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['currency_name'] = currencyName;
    data['date'] = date;
    if (totalPrice != null) {
      data['total_price'] = totalPrice!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}
