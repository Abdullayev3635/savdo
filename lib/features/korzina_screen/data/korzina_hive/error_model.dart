class ErrorModel {
  int? productId;
  String? productName;
  int? quantity;
  int? currencyId;
  String? currencyName;
  int? price;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['price'] = this.price;
    data['residue'] = this.residue;
    return data;
  }
}