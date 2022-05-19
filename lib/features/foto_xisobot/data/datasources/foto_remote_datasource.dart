import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/network/multi_part_request.dart';
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
  @override
  Future sendFoto(
    String image1,
    String image2,
    String image3,
    int customerId,
    int salesAgentId,
    int regionId,
  ) async {
    const uri = (baseUrl + photoPHP);
    final request = MultipartRequest(
      'POST',
      Uri.parse(uri),
      onProgress: (int bytes, int total) {
        final progress = bytes / total;
        print('progress: $progress ($bytes/$total)');
      },
    );

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
