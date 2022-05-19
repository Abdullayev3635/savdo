class TulovModel {
  int? salesAgentId;
  int? customerId;
  int? branchId;
  int? currencyValue;
  int? paymentTypeId;
  int? summa;
  int? paymentAmount;
  String? description;

  TulovModel.fromJson(Map<String, dynamic> json) {
    salesAgentId = json['sales_agent_id'];
    customerId = json['customer_id'];
    branchId = json['branch_id'];
    currencyValue = json['currency_value'];
    paymentTypeId = json['payment_type_id'];
    summa = json['summa'];
    paymentAmount = json['payment_amount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sales_agent_id'] = salesAgentId;
    data['customer_id'] = customerId;
    data['branch_id'] = branchId;
    data['currency_value'] = currencyValue;
    data['payment_type_id'] = paymentTypeId;
    data['summa'] = summa;
    data['payment_amount'] = paymentAmount;
    data['description'] = description;
    return data;
  }
}
