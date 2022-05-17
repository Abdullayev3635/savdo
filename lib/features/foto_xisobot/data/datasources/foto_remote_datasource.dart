import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/foto_xisobot/data/model/foto_model.dart';

// import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class FotoRemoteDataSource {
  Future<dynamic> sendFoto(
    String image1,
    String image2,
    String image3,
    int customerId,
    int salesAgentId,
    int regionId,
  );
}

class FotoRemoteDataSourceImpl implements FotoRemoteDataSource {
  final http.Client client;

  FotoRemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> sendFoto(
    String image1,
    String image2,
    String image3,
    int customerId,
    int salesAgentId,
    int regionId,
  ) async {
    var request = http.MultipartRequest("POST", Uri.parse(baseUrl + photoPHP));

    request.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    });
    request.fields.addAll({});
    request.files.add(await http.MultipartFile.fromPath("image1", image1));
    request.files.add(await http.MultipartFile.fromPath("image2", image2));
    request.files.add(await http.MultipartFile.fromPath("image3", image3));
    request.fields['sales_agent_id'] = salesAgentId.toString();
    request.fields['customer_id'] = customerId.toString();
    request.fields['region_id'] = regionId.toString();

    var sendRequest = await request.send();
    var response = await http.Response.fromStream(sendRequest);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      var message = FotoModel.fromJson(parsed).message;
      return message;
    } else {
      return "Bog'lanishda xatolik";
    }
  }
  }
// ) async {
//   String? message = "";
//
//   try {
//     dynamic json = {
//       "customer_id": customerId,
//       "sales_agent_id": salesAgentId,
//       "region_id": regionId,
//       "image1":image1,
//       "image2":image2,
//       "image3":image3,
//     };
//     final response = await client.post(
//       Uri.parse(baseUrl + photoPHP),
//       body: jsonEncode(json),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json'
//       },
//     );
//     if (response.statusCode == 200) {
//       final parsed = jsonDecode(response.body);
//       message = FotoModel.fromJson(parsed).message;
//       return message;
//     } else {
//       return "Bog'lanishda xatolik";
//     }
//   } on InputFormatterFailure {
//     return "Qandaydir xatolik";
//   }
// }

