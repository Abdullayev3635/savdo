class ArchiveModel {
  int? id;
  String? customerName;
  String? currencyName;
  String? date;
  String? totalPrice;
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
    totalPrice = json['total_price'];
    status = json['status'];
  }
}
