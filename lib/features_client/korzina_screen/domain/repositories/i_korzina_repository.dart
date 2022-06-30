import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/korzina_hive/client_korzina_hive.dart';

abstract class ClientKorzinaRepository {
  Future<Either<Failure, dynamic>> sendKorzinaData(List<ClientKorzinaCard> card);
}
