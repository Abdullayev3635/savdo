class AddClientModel {
  String? name;
  String? address;
  String? login;
  String? password;
  String? phone1;
  String? coordinates;
  int? stateId;
  int? legalPhysical;
  int? regionId;
  int? salesAgentId;

  AddClientModel(
      {this.regionId,
      this.address,
      this.coordinates,
      this.legalPhysical,
      this.salesAgentId,
      this.login,
      this.name,
      this.password,
      this.phone1,
      this.stateId});

  AddClientModel.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    address = json['address'];
    stateId = json['state_id'];
    login = json['login'];
    name = json['name'];
    password = json['password'];
    legalPhysical = json['legal_physical'];
    salesAgentId = json['sales_agent_id'];
    phone1 = json['phone_1'];
    coordinates = json['cordinates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['region_id'] = regionId;
    json['address'] = address;
    json['state_id'] = stateId;
    json['login'] = login;
    json['name'] = name;
    json['password'] = password;
    json['legal_physical'] = legalPhysical;
    json['sales_agent_id'] = salesAgentId;
    json['phone_1'] = phone1;
    json['cordinates'] = coordinates;
    return json;
  }
}
