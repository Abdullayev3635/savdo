import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product_items/domain/usescase/brand_products.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../product/data/model/product_model_new.dart';
import '../../../domain/usescase/change_product.dart';

part 'brands_products_event.dart';

part 'brands_products_state.dart';

class BrandsProductsBloc
    extends Bloc<BrandsProductsEvent, BrandsProductsState> {
  final BrandProductsUsescase brandProducts;
  final SendChangedProduct sendChangedProduct;
  List<BrandProductModel> brandProductList = [];
  var rList = <ProductsNew>[];
  var oldPerson = <ProductsNew>[];
  var currentList = <ProductsNew>[];
  TextEditingController? filter = TextEditingController();

  BrandsProductsBloc({
    required this.brandProducts,
    required this.sendChangedProduct,
  }) : super(BrandsProductsInitial()) {
    on<GetBrandsProductsEvent>(getBrandProduct, transformer: sequential());
    on<GetBrandsProductsEventNew>(getBrandProductNew,
        transformer: sequential());
    on<GetBrandsProductsEventFilter>(getFilterPart, transformer: sequential());
    on<SendNewProducts>(sendNewProducts, transformer: sequential());
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
      oldProductsList: oldPerson,
      isFirstFetch: event.name == null || event.name == "null",
    ));

    final result = await brandProducts(
      GetBrandProductsParams(
        name: event.name,
        priceTypeId: event.priceTypeId,
        salesAgentId: event.salesAgentId,
        page: event.page,
        brandId: event.brandId,
        turi: event.turi,
      ),
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

  FutureOr<void> getBrandProductNew(GetBrandsProductsEventNew event,
      Emitter<BrandsProductsState> emit) async {
    final currentState = state;

    if (currentState is BrandsProductsSuccessState) {
      oldPerson = currentState.listNew;
    }
    emit(BrandsProductsLoadingState(
      oldProductsListNew: oldPerson,
      isFirstFetch: event.name == null || event.name == "null",
    ));

    final result = await brandProducts(
      GetBrandProductsParams(
        name: event.name,
        priceTypeId: event.priceTypeId,
        salesAgentId: event.salesAgentId,
        page: event.page,
        brandId: event.brandId,
        turi: event.turi,
      ),
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
                  (state as BrandsProductsLoadingState).oldProductsListNew,
              currentList.addAll(r),
              emit(BrandsProductsSuccessState(
                  listNew: currentList, rListNew: rList, list: [], rList: [])),
            });
  }

  FutureOr<void> sendNewProducts(
      SendNewProducts event, Emitter<BrandsProductsState> emit) async {
    final result = await sendChangedProduct(
      ChangedProductsParams(
        productsNew: event.json,
      ),
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
              if (r) {event.onSuccess()}
            });
  }

  FutureOr<void> getFilterPart(
    GetBrandsProductsEventFilter event,
    Emitter<BrandsProductsState> emit,
  ) async {
    if (event.name.isEmpty) {
      emit(BrandsProductsSuccessState(
          listNew: currentList, rListNew: rList, list: [], rList: []));
    } else {
      final searchLower = event.name.toLowerCase();
      emit(BrandsProductsSuccessState(
          listNew: currentList.where((element) {
            final titleLower = element.name!.toLowerCase();
            return titleLower.contains(searchLower);
          }).toList(),
          rListNew: rList,
          list: [],
          rList: []));
    }
  }
}
