import 'package:hive/hive.dart';

part 'brand_product_model.g.dart';

@HiveType(typeId: 3)
class BrandProductModel {
  int? id;
  String? name;
  String? category;
  int? currencyId;
  String? currencyName;
  String? price;
  int? residue;
  String? size;
  String? blok;

  BrandProductModel(
      {this.id,
      this.name,
      this.blok,
      this.category,
      this.currencyId,
      this.currencyName,
      this.price,
      this.residue,
      this.size});

  BrandProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    currencyId  = json['currency_id'];
    currencyName = json['currency_name'];
    price = json['price'];
    residue = json['residue'];
    size = json['size'];
    blok = json['blok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['currency_id'] = currencyId;
    data['currency_name'] = currencyName;
    data['price'] = price;
    data['residue'] = residue;
    data['size'] = size;
    data['blok'] = blok;
    return data;
  }
}
