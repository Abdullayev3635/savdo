
class PriceModel {
  int? id;
  int? priceTypeId;
  String? priceTypeName;
  String? price;
  int? currencyId;
  String? currencyName;

  PriceModel({this.id, this.priceTypeId, this.priceTypeName, this.price, this.currencyId, this.currencyName});

  PriceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceTypeId = json['price_type_id'];
    priceTypeName = json['price_type_name'];
    price = json['price'];
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price_type_id'] = priceTypeId;
    data['price_type_name'] = priceTypeName;
    data['price'] = price;
    data['currency_id'] = currencyId;
    return data;
  }
}
