import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../domain/usescase/brand.dart';

part 'brand_event.dart';

part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandCatalog brandCategory;
  final SharedPreferences sharedPreferences;

  List<BrandModel> brandList = [];
  bool isStatus = false;

  BrandBloc({required this.brandCategory,required this.sharedPreferences}) : super(BrandInitial()) {
    on<BrandInitialEvent>(getBrandInitial, transformer: sequential());
    on<GetBrandEvent>(getBrand, transformer: sequential());
  }

  FutureOr<void> getBrandInitial(
      BrandInitialEvent event, Emitter<BrandState> emit) async {
    emit(BrandInitial());
  }

  FutureOr<void> getBrand(GetBrandEvent event, Emitter<BrandState> emit) async {
    brandList.clear();
    emit(BrandLoadingState());
    final result = await brandCategory(
      GetBrandParams(
          priceTypeId: int.parse(sharedPreferences.getString(sharedPriceTypeId)??"0"), productTypeId: event.productTypeId),
    );
    result.fold(
      (failure) => {
        if (failure is NoConnectionFailure)
          {emit(BrandNoInternetState())}
        else if (failure is ServerFailure)
          {emit(BrandFailureState(message: ""))}
        else if (failure is InputFormatterFailure)
          {emit(BrandFailureState(message: ""))}
      },
      (r) => {
        if (r.isEmpty)
          {emit(BrandFailureState(message: ""))}
        else
          {emit(BrandSuccessState(list: r))}
      },
    );
  }
}
