import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usescase/catalog.dart';

part 'category_event.dart';
part 'category_state.dart';

class CatalogBloc extends Bloc<CategoryEvent, CatalogState> {
  final ProductCatalog product;

  CatalogBloc({
    required this.product,
  }) : super(const CatalogInitialState(isLarge: false)) {
    on<GetCategory>(getCategory, transformer: sequential());
    on<ChangeColor>(changeColor, transformer: sequential());
  }

  FutureOr<void> getCategory(
      GetCategory event, Emitter<CatalogState> emit) async {
    emit(const CatalogLoadingState(isLarge: false));
    final result = await product(
      GetCatalogParams(),
    );
    // final box = Hive.box(categoryBox);
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(const CatalogNoInternetState(isLarge: false))}
              else if (failure is ServerFailure)
                {emit(const CatalogFailureState(isLarge: false, message: ""))}
              else if (failure is InputFormatterFailure)
                {emit(const CatalogFailureState(isLarge: false, message: ""))}
            },
        (r) => {
              if (r.isEmpty)
                {emit(const CatalogFailureState(isLarge: false, message: ""))}
              else
                {
                  emit(CatalogSuccessState(
                      list: r, selected: 0, isLarge: false))
                }
            });
  }

  FutureOr<void> changeColor(
      ChangeColor event, Emitter<CatalogState> emit) async {
    emit(CatalogSuccessState(
        list: event.list,
        selected: event.index,
        isLarge: !event.isLarge));
  }
}
