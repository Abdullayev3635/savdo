import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class CatalogRepository {
  Future<Either<Failure, dynamic>> getCatalog();
}