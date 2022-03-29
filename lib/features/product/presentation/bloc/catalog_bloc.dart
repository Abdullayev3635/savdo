import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import '../../../../core/errors/failures.dart';
import '../../data/model/category_model1.dart';
import '../../domain/usescase/usescase.dart';

part 'catalog_event.dart';

part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ProductCatalog home;

  CatalogBloc({
    required this.home,
  }) : super(const ProductInitialState(isLarge: false)) {
    on<GetCatalog>(getCategory, transformer: sequential());
    on<ChangeColor>(changeColor, transformer: sequential());
  }

  FutureOr<void> getCategory(
      GetCatalog event, Emitter<CatalogState> emit) async {
    emit(const ProductLoadingState(isLarge: false));
    final result = await home(GetCategoryParams());

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(const ProductFailureState(isLarge: false))}
              else if (failure is ServerFailure)
                {emit(const ProductFailureState(isLarge: false))}
            },
        (r) => {
              if (r.isEmpty)
                {emit(const ProductFailureState(isLarge: false))}
              else
                {
                  emit(ProductSuccessState(
                      list: r, selected: 0, isLarge: false, count: 20))
                }
            });
  }

  FutureOr<void> changeColor(
      ChangeColor event, Emitter<CatalogState> emit) async {
    emit(ProductSuccessState(
        list: event.list,
        selected: event.index,
        isLarge: !event.isLarge,
        count: 20));
  }
}
