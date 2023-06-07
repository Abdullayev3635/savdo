class LoginModel {
  String? phone;

  LoginModel({ this.phone, });

  LoginModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = phone;
    return data;
  }
}