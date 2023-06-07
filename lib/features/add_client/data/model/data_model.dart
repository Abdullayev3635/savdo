
import 'package:savdo_agnet_client/features/add_client/data/model/name.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/phone.dart';

class DataModel{
  List<NameModel> name;
  List<LoginModel> login;
  DataModel({required this.name, required this.login});
}