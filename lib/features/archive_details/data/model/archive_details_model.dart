class ArchiveDetailsModel {
  int? id;
  String? name;
  String? currencyName;
  String? price;
  String? category;
  String? quantity;

  ArchiveDetailsModel(
      {this.id,
      this.name,
      this.currencyName,
      this.price,
      this.category,
      this.quantity});

  ArchiveDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    currencyName = json['currency_name'];
    price = json['price'];
    category = json['category'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['product_name'] = name;
    data['currency_name'] = currencyName;
    data['price'] = price;
    data['category'] = category;
    data['quantity'] = quantity;
    return data;
  }
}
