import 'package:hive/hive.dart';



class ClientBrandProductModel {
  int? id;
  String? name;
  String? image;
  String? category;
  int? currencyId;
  String? currencyName;
  String? price;
  int? residue;
  String? size;
  String? blok;

  ClientBrandProductModel(
      {this.id,
      this.name,
      this.image,
      this.blok,
      this.category,
      this.currencyId,
      this.currencyName,
      this.price,
      this.residue,
      this.size});

  ClientBrandProductModel.fromJson(Map<String, dynamic> json) {
    id = json['product_id'];
    name = json['name'];
    image = json['image'];
    category = json['category'];
    currencyId  = json['currency_id'];
    currencyName = json['currency_name'];
    price = json['price'];
    residue = json['residue']??"1";
    size = json['size'];
    blok = json['blok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['currency_id'] = currencyId;
    data['currency_name'] = currencyName;
    data['price' ] = price;
    data['residue'] = residue;
    data['size'] = size;
    data['blok'] = blok;
    data['image'] = image;
    return data;
  }
}
