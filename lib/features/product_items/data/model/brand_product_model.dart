class BrandProductModel {
  int? id;
  String? name;
  String? category;
  int? currencyId;
  String? currencyName;
  String? price;
  int? residue;
  String? size;

  BrandProductModel(
      {this.id,
        this.name,
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
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    price = json['price'];
    residue = json['residue'];
    size = json['size'];
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
    return data;
  }
}