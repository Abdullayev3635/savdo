class AddClientModel {
  String? name;
  String? address;
  String? login;
  String? password;
  String? userName;
  String? phone1;
  String? coordinates;
  int? stateId;
  int? legalPhysical;
  int? regionId;
  int? customerAndContragentFolderId;

  AddClientModel(
      {this.regionId,
      this.address,
      this.coordinates,
      this.customerAndContragentFolderId,
      this.legalPhysical,
      this.login,
      this.name,
      this.password,
      this.phone1,
      this.stateId,
      this.userName});

  AddClientModel.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    address = json['address'];
    stateId = json['state_id'];
    login = json['login'];
    name = json['name'];
    password = json['password'];
    userName = json['user_name'];
    legalPhysical = json['legal_physical'];
    phone1 = json['phone_1'];
    coordinates = json['cordinates'];
    customerAndContragentFolderId = json['customer_and_contragent_folder_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['region_id'] = regionId;
    json['address'] = address;
    json['state_id'] = stateId;
    json['login'] = login;
    json['name'] = name;
    json['password'] = password;
    json['user_name'] = userName;
    json['legal_physical'] = legalPhysical;
    json['phone_1'] = phone1;
    json['cordinates'] = coordinates;
    json['customer_and_contragent_folder_id'] = customerAndContragentFolderId;
    return json;
  }
}
