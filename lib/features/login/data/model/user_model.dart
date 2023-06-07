class UserModel {
  int? workerId;
  String? workerName;
  String? image;
  int? branchId;
  String? branchName;
  List<int>? roles;
  String? token;
  bool isAgent = false;
  bool isDostavshik= false;

  UserModel(
      {this.workerId,
        this.workerName,
        this.image,
        this.branchId,
        this.branchName,
        this.roles,
        this.token,
      required this.isAgent,
      required this.isDostavshik});

  UserModel.fromJson(Map<String, dynamic> json) {
    workerId = json['worker_id'];
    workerName = json['worker_name'];
    image = json['image'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    roles = json['roles'].cast<int>();
    token = json['token'];
    isAgent = json['isAgent'];
    isDostavshik = json['isDostavshik'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['worker_id'] = workerId;
    data['worker_name'] = workerName;
    data['image'] = image;
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    data['roles'] = roles;
    data['token'] = token;
    data['isAgent'] = isAgent;
    data['isDostavshik'] = isDostavshik;
    return data;
  }
}