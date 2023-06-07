import 'package:savdo_agnet_client/features/buyurtma/data/model/price_model.dart';

class BrandProductModel {
  int? id;
  String? name;
  String? image;
  String? category;
  int? currencyId;
  String? currencyName;
  String? price;
  num? residue;
  String? size;
  String? blok;
  num? incomePrice;
  List<PriceModel> priceList=[];

  BrandProductModel(
      {this.id,
      this.name,
      this.image,
      this.blok,
      this.category,
      this.currencyId,
      this.currencyName,
      this.priceList = const [],
      this.price,
      this.residue,
      this.size,
      this.incomePrice});

  BrandProductModel.fromJson(Map<String, dynamic> json) {
    id = json['product_id'];
    name = json['name'];
    image = json['image'];
    category = json['category'];
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    price = json['price'];
    residue = num.tryParse(json['residue'].toString()) ?? 0;
    size = json['size'];
    blok = json['blok'];
    incomePrice = num.tryParse(json['income_price'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['currency_id'] = currencyId;
    data['currency_name'] = currencyName;
    data['price'] = price;
    data['residue'] = residue;
    data['price_list'] = priceList;
    data['size'] = size;
    data['blok'] = blok;
    data['image'] = image;
    return data;
  }
}
