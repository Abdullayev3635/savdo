import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';

import '../repositories/i_korzina_repository.dart';

class UKorzinaOrderList extends UseCase<dynamic, GetOrderListParams> {
  final KorzinaRepository korzinaRepository;

  UKorzinaOrderList({required this.korzinaRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetOrderListParams params) {
    return korzinaRepository.sendKorzinaData(params.listSendData, params.paymentJson);
  }
}

class GetOrderListParams extends Equatable {
  final List<KorzinaCard> listSendData;
  final dynamic paymentJson;

  const GetOrderListParams({required this.listSendData,required this.paymentJson,});

  @override
  List<Object?> get props => [listSendData];
}
