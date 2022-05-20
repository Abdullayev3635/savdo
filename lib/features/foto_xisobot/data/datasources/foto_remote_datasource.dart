import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/network/multi_part_request.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/data/model/foto_model.dart';
import '../../../../core/utils/api_path.dart';

double progress = 0;

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
        progress = bytes / total;
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

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:http/http.dart' as http;
// import 'package:savdo_agnet_client/features/foto_xisobot/data/model/foto_model.dart';
// import '../../../../core/utils/api_path.dart';
//
// double progressIndicator = 0;
//
// abstract class FotoRemoteDataSource {
//   Future<dynamic> sendFoto(
//     String image1,
//     String image2,
//     String image3,
//     int customerId,
//     int salesAgentId,
//     int regionId,
//   );
// }
//
// class FotoRemoteDataSourceImpl implements FotoRemoteDataSource {
//   final http.Client client;
//
//   FotoRemoteDataSourceImpl({required this.client});
//
//   @override
//   Future<dynamic> sendFoto(
//     String image1,
//     String image2,
//     String image3,
//     int customerId,
//     int salesAgentId,
//     int regionId,
//   ) async {
//     double downloadProgress = 0;
//     File image = File(image1);
//     File imageTwo = File(image2);
//     File imageThree = File(image3);
//     /// bu yerda yuklanyatgan faylni hajmii o'lchaydi
//     var byte = image.readAsBytesSync().lengthInBytes +
//         imageTwo.readAsBytesSync().lengthInBytes +
//         imageThree.readAsBytesSync().lengthInBytes;
//     var request = http.MultipartRequest("POST", Uri.parse(baseUrl + photoPHP));
//     var sendRequest = await request.send();
//     final bytes = <int>[];
//
//     /// shu funksiayni yozdim
//     sendRequest.stream.asBroadcastStream().listen(
//       (event) {
//         /// hozir batda o'sha yuklayotganini listga qo'shyapti
//         bytes.addAll(event);
//
//         downloadProgress = bytes.length / byte;
//         progressIndicator = downloadProgress;
//         print('dddddddddddd $progressIndicator');
//       },
//       onDone: () async {
//         /// yuklab bo'lgandan kegin download qilib bo'lgandan kegin uni 1ga tenglaydi
//         downloadProgress = 1;
//
//         print('dddddddddddd $downloadProgress');
//       },
//       cancelOnError: true,
//     );
//     // sendRequest.stream.
//     request.headers.addAll({
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json'
//     });
//     // request.contentLength = byte;
//
//     request.fields.addAll({});
//     request.files.add(await http.MultipartFile.fromPath("image1", image1));
//     request.files.add(await http.MultipartFile.fromPath("image2", image2));
//     request.files.add(await http.MultipartFile.fromPath("image3", image3));
//     request.fields['sales_agent_id'] = salesAgentId.toString();
//     request.fields['customer_id'] = customerId.toString();
//     request.fields['region_id'] = regionId.toString();
//
//     var response = await http.Response.fromStream(sendRequest);
//
//     if (response.statusCode == 200) {
//       final parsed = jsonDecode(response.body);
//       var message = FotoModel.fromJson(parsed).message;
//       return message;
//     } else {
//       return "Bog'lanishda xatolik";
//     }
//   }
// }
// // ) async {
// //   String? message = "";
// //
// //   try {
// //     dynamic json = {
// //       "customer_id": customerId,
// //       "sales_agent_id": salesAgentId,
// //       "region_id": regionId,
// //       "image1":image1,
// //       "image2":image2,
// //       "image3":image3,
// //     };
// //     final response = await client.post(
// //       Uri.parse(baseUrl + photoPHP),
// //       body: jsonEncode(json),
// //       headers: <String, String>{
// //         'Content-Type': 'application/json; charset=UTF-8',
// //         'Accept': 'application/json'
// //       },
// //     );
// //     if (response.statusCode == 200) {
// //       final parsed = jsonDecode(response.body);
// //       message = FotoModel.fromJson(parsed).message;
// //       return message;
// //     } else {
// //       return "Bog'lanishda xatolik";
// //     }
// //   } on InputFormatterFailure {
// //     return "Qandaydir xatolik";
// //   }
// // }
