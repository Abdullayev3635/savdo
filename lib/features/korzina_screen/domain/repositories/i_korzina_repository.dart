import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/korzina_hive/korzina_hive.dart';
import '../../data/korzina_hive/tolov_hive.dart';

abstract class KorzinaRepository {
  Future<Either<Failure, dynamic>> sendKorzinaData(List<KorzinaCard> card, List<TolovHive> paymentJson);
}
