class UserModel {
  int? id;
  String? name;
  String? login;
  String? phoneNumber;
  int? sectorId;
  int? regionId;
  String? token;

  UserModel(
      {this.id,
      this.name,
      this.login,
      this.phoneNumber,
      this.sectorId,
      this.regionId,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    phoneNumber = json['phone_number'];
    sectorId = json['sector_id'];
    regionId = json['region_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['login'] = login;
    data['phone_number'] = phoneNumber;
    data['sector_id'] = sectorId;
    data['region_id'] = regionId;
    data['token'] = token;
    return data;
  }
}
