import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product/domain/usescase/brand_products.dart';

import '../../../../../core/errors/failures.dart';

part 'brands_products_event.dart';

part 'brands_products_state.dart';

class BrandsProductsBloc
    extends Bloc<BrandsProductsEvent, BrandsProductsState> {
  final BrandProductsCatalog brandProducts;
  List<BrandProductModel> brandProductList = [];
  TextEditingController? filter = TextEditingController();

  BrandsProductsBloc({required this.brandProducts})
      : super(BrandsProductsInitial()) {
    on<GetBrandsProductsEvent>(getBrandProduct, transformer: sequential());
    on<GetSearchProductEvent>(searchProduct, transformer: sequential());
  }

  FutureOr<void> getBrandProduct(
      GetBrandsProductsEvent event, Emitter<BrandsProductsState> emit) async {
    brandProductList.clear();
    emit(BrandsProductsLoadingState());
    final result = await brandProducts(
      GetBrandProductsParams(
          priceTypeId: event.priceTypeId,
          salesAgentId: event.salesAgentId,
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
              if (r.isEmpty)
                {emit(BrandsProductsFailureState(message: ""))}
              else
                {
                  emit(BrandsProductsSuccessState(list: r)),
                  for (int i = 0; r.length > i; i++)
                    {brandProductList.add(r[i])},
                }
            });
  }

  FutureOr<void> searchProduct(
      GetSearchProductEvent event, Emitter<BrandsProductsState> emit) async {
    emit(BrandsProductsLoadingState());
    if (event.txt.isEmpty) {
      emit(BrandsProductsSuccessState(list: brandProductList));
      log(brandProductList.toString());
    } else {
    emit(BrandsProductsSuccessState(
        list: brandProductList.where((element) {
      final titleLower = element.name!.toLowerCase();
      final searchLower = event.txt.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList()));
    log(brandProductList.toString());
    }
  }
}
