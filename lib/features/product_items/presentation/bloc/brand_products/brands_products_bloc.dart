import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product_items/domain/usescase/brand_products.dart';

import '../../../../../core/errors/failures.dart';

part 'brands_products_event.dart';

part 'brands_products_state.dart';

class BrandsProductsBloc
    extends Bloc<BrandsProductsEvent, BrandsProductsState> {
  final BrandProductsUsescase brandProducts;
  List<BrandProductModel> brandProductList = [];
  TextEditingController? filter = TextEditingController();

  BrandsProductsBloc({
    required this.brandProducts,
    // required this.allBrandProducts,
  }) : super(BrandsProductsInitial()) {
    on<GetBrandsProductsEvent>(getBrandProduct, transformer: sequential());
    // on<GetSearchProductEvent>(searchProduct, transformer: sequential());
  }

  int page = 1;

  FutureOr<void> getBrandProduct(
      GetBrandsProductsEvent event, Emitter<BrandsProductsState> emit) async {
    final currentState = state;
    var rList = <BrandProductModel>[];
    var oldPerson = <BrandProductModel>[];
    var currentList = <BrandProductModel>[];
    if (currentState is BrandsProductsSuccessState) {
      oldPerson = currentState.list;
    }
    emit(BrandsProductsLoadingState(
        oldProductsList: oldPerson, isFirstFetch: event.name == "null"));

    final result = await brandProducts(
      GetBrandProductsParams(
          name: event.name,
          priceTypeId: event.priceTypeId,
          salesAgentId: event.salesAgentId,
          page: event.page,
          brandId: event.brandId),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(BrandsProductsNoInternetState())}
              else if (failure is ServerFailure)
                {emit(BrandsProductsFailureState(message: ""))}
              else if (failure is InputFormatterFailure)
                {emit(BrandsProductsFailureState(message: ""))}
            },
        (r) => {
              rList.addAll(r),
              currentList =
                  (state as BrandsProductsLoadingState).oldProductsList,
              currentList.addAll(r),
              emit(BrandsProductsSuccessState(list: currentList, rList: rList)),
            });
  }

// FutureOr<void> searchProduct(
//     GetSearchProductEvent event, Emitter<BrandsProductsState> emit) async {
//   emit(BrandsProductsLoadingState());
//   if (event.txt.isEmpty) {
//     emit(BrandsProductsSuccessState(list: brandProductList, hasMore: true));
//     //  log(brandProductList.toString());
//   } else {
//     emit(BrandsProductsSuccessState(
//         hasMore: true,
//         list: brandProductList.where((element) {
//           final titleLower = element.name!.toLowerCase();
//           final searchLower = event.txt.toLowerCase();
//           return titleLower.contains(searchLower);
//         }).toList()));
//     // log(brandProductList.toString());
//   }
// }
}
