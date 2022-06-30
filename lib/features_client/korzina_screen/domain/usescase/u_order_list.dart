import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features_client/korzina_screen/domain/repositories/i_korzina_repository.dart';

import '../../data/korzina_hive/client_korzina_hive.dart';

class UKorzinaOrderList extends UseCase<dynamic, GetOrderListParams> {
  final ClientKorzinaRepository korzinaRepository;

  UKorzinaOrderList({required this.korzinaRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetOrderListParams params) {
    return korzinaRepository.sendKorzinaData(params.listSendData);
  }
}

class GetOrderListParams extends Equatable {
  final List<ClientKorzinaCard> listSendData;

  const GetOrderListParams({required this.listSendData});

  @override
  List<Object?> get props => [listSendData];
}
