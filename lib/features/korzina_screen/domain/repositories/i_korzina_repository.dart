import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/korzina_hive/korzina_hive.dart';

abstract class KorzinaRepository {
  Future<Either<Failure, dynamic>> sendKorzinaData(List<KorzinaCard> card);
}
