class AddClientErrorModel {
  List<String>? name;
  List<String>? password;
  List<String>? login;
  List<String>? address;
  List<String>? phone1;
  List<String>? coordinate;
  List<String>? legalPhysical;
  List<String>? stateId;
  List<String>? regionId;

  AddClientErrorModel(
      {this.name,
        this.password,
        this.login,
        this.address,
        this.phone1,
        this.coordinate,
        this.legalPhysical,
        this.stateId,
        this.regionId});

  AddClientErrorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    password = json['password'].cast<String>();
    login = json['login'].cast<String>();
    address = json['address'].cast<String>();
    phone1 = json['phone_1'].cast<String>();
    coordinate = json['coordinate'].cast<String>();
    legalPhysical = json['legal_physical'].cast<String>();
    stateId = json['state_id'].cast<String>();
    regionId = json['region_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['login'] = login;
    data['address'] = address;
    data['phone_1'] = phone1;
    data['coordinate'] = coordinate;
    data['legal_physical'] = legalPhysical;
    data['state_id'] = stateId;
    data['region_id'] = regionId;
    return data;
  }
}