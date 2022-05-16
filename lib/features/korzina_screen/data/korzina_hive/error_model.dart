class ErrorModel {
  int? productId;
  String? productName;
  int? quantity;
  int? currencyId;
  String? currencyName;
  double? price;
  int? residue;

  ErrorModel(
      {this.productId,
        this.productName,
        this.quantity,
        this.currencyId,
        this.currencyName,
        this.price,
        this.residue});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    price = json['price'];
    residue = json['residue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['currency_id'] = currencyId;
    data['currency_name'] = currencyName;
    data['price'] = price;
    data['residue'] = residue;
    return data;
  }
}