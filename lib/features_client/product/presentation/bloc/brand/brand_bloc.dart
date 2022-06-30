import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_model.dart';
import 'package:savdo_agnet_client/features_client/product/data/model/brand_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usescase/brand.dart';

part 'brand_event.dart';

part 'brand_state.dart';

class ClientBrandBloc extends Bloc<ClientBrandEvent, ClientBrandState> {
  final ClientBrandCatalog brandCategory;

  List<BrandModel> brandList = [];
  bool isStatus = false;

  ClientBrandBloc({required this.brandCategory}) : super(ClientBrandInitial()) {
    on<BrandInitialEvent>(getBrandInitial, transformer: sequential());
    on<GetClientBrandEvent>(getBrand, transformer: sequential());
  }

  FutureOr<void> getBrandInitial(
      BrandInitialEvent event, Emitter<ClientBrandState> emit) async {
    emit(ClientBrandInitial());
  }

  FutureOr<void> getBrand(GetClientBrandEvent event, Emitter<ClientBrandState> emit) async {
    brandList.clear();
    emit(ClientBrandLoadingState());
    final result = await brandCategory(
      GetBrandParams(
          priceTypeId: event.priceTypeId, productTypeId: event.productTypeId),
    );
    result.fold(
      (failure) => {
        if (failure is NoConnectionFailure)
          {emit(ClientBrandNoInternetState())}
        else if (failure is ServerFailure)
          {emit(ClientBrandFailureState(message: ""))}
        else if (failure is InputFormatterFailure)
          {emit(ClientBrandFailureState(message: ""))}
      },
      (r) => {
        if (r.isEmpty)
          {emit(ClientBrandFailureState(message: ""))}
        else
          {emit(ClientBrandSuccessState(list: r))}
      },
    );
  }
}
