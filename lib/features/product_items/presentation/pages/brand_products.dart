import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/core/widgets/failure_dialog.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/brand_items_shimmer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/appBarWidget.dart';
import '../bloc/brand_products/brands_products_bloc.dart';
import '../widgets/product_items.dart';

String bName = '';
int? gpriceId;
int? gbrandId;
// int? gsalesAgentId;

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  static Widget screen({
    required String brandName,
    int? priceTypeId,
    int? brandId,
    int? salesAgentId,
  }) {
    bName = brandName;
    gpriceId = priceTypeId;
    gbrandId = brandId;
    // gsalesAgentId = salesAgentId;
    return BlocProvider(
      create: (context) => di<BrandsProductsBloc>()
        ..add(GetBrandsProductsEvent(
            priceTypeId: priceTypeId,
            brandId: brandId,
            salesAgentId: salesAgentId)),
      child: const Products(),
    );
  }

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController textEditingController = TextEditingController();
  NetworkInfo networkInfo = di.get();
  late BrandsProductsBloc _brandBloc;

  @override
  void initState() {
    super.initState();
    _brandBloc = BlocProvider.of<BrandsProductsBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _brandBloc.close();
    textEditingController.dispose();
  }

  Future _handleRefresh() async {
    // print("refresh");
    return _brandBloc.add(GetBrandsProductsEvent(
        priceTypeId: gpriceId,
        brandId: gbrandId,
        salesAgentId:
            int.parse(sharedPreferences.getString(sharedSalesAgentId) ?? '')));
  }

  SharedPreferences sharedPreferences = di.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cBackgroundColor,
      appBar: appBarWidget(context, bName),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: BlocBuilder<BrandsProductsBloc, BrandsProductsState>(
          builder: (context, state) {
            if (state is BrandsProductsLoadingState) {
              return const BrandItemsShimmerWidget();
            } else if (state is BrandsProductsNoInternetState) {
              return ShowFailureDialog(onTap: () async {
                if (await networkInfo.isConnected) {
                  _brandBloc.add(GetBrandsProductsEvent(
                      priceTypeId: gpriceId,
                      brandId: gbrandId,
                      salesAgentId: int.parse(
                          sharedPreferences.getString(sharedSalesAgentId) ??
                              '')));
                  Navigator.pop(context);
                } else {
                  CustomToast.showToast('Internet bilan aloqani tekshiring!');
                }
              });
            } else if (state is BrandsProductsFailureState) {
              return Center(child: Text(state.message));
            } else if (state is BrandsProductsSuccessState) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: cWhiteColor,
                      boxShadow: [textFieldShadow],
                    ),
                    height: 65.h,
                    padding: EdgeInsets.fromLTRB(13.w, 2.h, 13.w, 0.h),
                    child: Center(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_search.svg',
                            width: 24.w,
                            height: 24.h,
                            color: primaryColor,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextFormField(
                                onChanged: (value) {
                                  _brandBloc
                                      .add(GetSearchProductEvent(txt: value));
                                },
                                textAlignVertical: TextAlignVertical.top,
                                cursorColor: primaryColor,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 0),
                                  hintText: "Qidirish",
                                  hintStyle: textStyleHintColorReg14,
                                  prefixIconConstraints: BoxConstraints(
                                    maxWidth: 30.w,
                                    maxHeight: 30.h,
                                    minHeight: 25.h,
                                    minWidth: 25.w,
                                  ),
                                ),
                                style: textStylePrimaryReg16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      color: primaryColor,
                      child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.only(top: 25.h),
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            return ProductItemsWidget(
                              blok: state.list[index].blok,
                              id: state.list[index].id!,
                              brandNomi: state.list[index].currencyName!,
                              image: null,
                              title: state.list[index].name!,
                              count: state.list[index].size!,
                              price: state.list[index].price!,
                              category: state.list[index].category!,
                              currencyId: state.list[index].currencyId!,
                              currencyName: state.list[index].currencyName,
                              residue: state.list[index].residue,
                              size: state.list[index].size,
                            );
                          }),
                    ),
                  ),
                ],
              );
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: cWhiteColor,
                boxShadow: [textFieldShadow],
              ),
              height: 65.h,
              padding: EdgeInsets.fromLTRB(13.w, 2.h, 13.w, 0.h),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_search.svg',
                      width: 24.w,
                      height: 24.h,
                      color: primaryColor,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextFormField(
                          onChanged: (value) {
                            _brandBloc.add(GetSearchProductEvent(txt: value));
                          },
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: primaryColor,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(bottom: 0),
                            hintText: "Qidirish",
                            hintStyle: textStyleHintColorReg14,
                            prefixIconConstraints: BoxConstraints(
                              maxWidth: 30.w,
                              maxHeight: 30.h,
                              minHeight: 25.h,
                              minWidth: 25.w,
                            ),
                          ),
                          style: textStylePrimaryReg16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
