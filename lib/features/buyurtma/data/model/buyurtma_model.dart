import 'package:savdo_agnet_client/features/buyurtma/data/model/narx_turi_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/savdo_turi_model.dart';

class BuyurtmaModel {
  List<NarxTuriModel>? narxTuri;
  List<SavdoTuriModel>? savdoTuri;

  BuyurtmaModel({required this.narxTuri, required this.savdoTuri});
}
