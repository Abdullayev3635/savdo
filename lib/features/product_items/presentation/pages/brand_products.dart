import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/core/widgets/failure_dialog.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/pages/korzina_screen.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/brand_items_shimmer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/appBarWidget.dart';
import '../../../product/data/model/brand_product_model.dart';
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
            page: 1,
            name: '',
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
  int page = 1;
  late BrandsProductsBloc _brandBloc;
  final controller = ScrollController();
  List<BrandProductModel> currentList = [];
  var succesState;

  @override
  void initState() {
    super.initState();
    _brandBloc = BlocProvider.of<BrandsProductsBloc>(context);
    succesState = BlocProvider.of<BrandsProductsBloc>(context).state;
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if(succesState is BrandsProductsInitial) {
          print('y1');
          if (succesState is BrandsProductsSuccessState) {
            print('y2');
            if ((BlocProvider
                .of<BrandsProductsBloc>(context)
                .state
            as BrandsProductsSuccessState)
                .rList
                .isNotEmpty) {
              print('y3');
              if (textEditingController.text != "") {
                print('n1');
                (BlocProvider
                    .of<BrandsProductsBloc>(context)
                    .state
                as BrandsProductsSuccessState)
                    .list
                    .clear();
              }
              _brandBloc.add(GetBrandsProductsEvent(
                  page: ++page,
                  name: textEditingController.text,
                  priceTypeId: gpriceId,
                  brandId: gbrandId,
                  salesAgentId: int.parse(
                      sharedPreferences.getString(sharedSalesAgentId) ??
                          '-1')));
            }
          }else {
            print('n2');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _brandBloc.close();
    controller.dispose();
    textEditingController.dispose();
  }

  Future _handleRefresh() async {
    (BlocProvider.of<BrandsProductsBloc>(context).state
            as BrandsProductsSuccessState)
        .list
        .clear();
    page = 1;
    return _brandBloc.add(GetBrandsProductsEvent(
        priceTypeId: gpriceId,
        name: textEditingController.text,
        page: page,
        brandId: gbrandId,
        salesAgentId: int.parse(
            sharedPreferences.getString(sharedSalesAgentId) ?? '-1')));
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
            bool isLoading = false;
            if (state is BrandsProductsLoadingState && state.isFirstFetch) {
              return const BrandItemsShimmerWidget();
            } else if (state is BrandsProductsNoInternetState) {
              return ShowFailureDialog(onTap: () async {
                if (await networkInfo.isConnected) {
                  _brandBloc.add(GetBrandsProductsEvent(
                      page: page,
                      name: textEditingController.text,
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
            } else if (state is BrandsProductsLoadingState) {
              currentList = state.oldProductsList;
              isLoading = true;
            } else if (state is BrandsProductsSuccessState) {
              currentList = state.list;
            }
            // else if (state is BrandsProductsSuccessState) {
            //   return Column(
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15.r),
            //           color: cWhiteColor,
            //           boxShadow: [textFieldShadow],
            //         ),
            //         height: 65.h,
            //         padding: EdgeInsets.fromLTRB(13.w, 2.h, 13.w, 0.h),
            //         child: Center(
            //           child: Row(
            //             children: [
            //               SvgPicture.asset(
            //                 'assets/icons/ic_search.svg',
            //                 width: 24.w,
            //                 height: 24.h,
            //                 color: primaryColor,
            //               ),
            //               SizedBox(width: 12.w),
            //               Expanded(
            //                 child: TextFormField(
            //                     onChanged: (value) {
            //                       _brandBloc.add(GetBrandsProductsEvent(
            //                           page: page++,
            //                           name: textEditingController.text,
            //                           priceTypeId: gpriceId,
            //                           brandId: gbrandId,
            //                           salesAgentId: int.parse(sharedPreferences
            //                                   .getString(sharedSalesAgentId) ??
            //                               '')));
            //                     },
            //                     textAlignVertical: TextAlignVertical.top,
            //                     cursorColor: primaryColor,
            //                     controller: textEditingController,
            //                     decoration: InputDecoration(
            //                       border: InputBorder.none,
            //                       contentPadding:
            //                           const EdgeInsets.only(bottom: 0),
            //                       hintText: "Qidirish",
            //                       hintStyle: textStyleHintColorReg14,
            //                       prefixIconConstraints: BoxConstraints(
            //                         maxWidth: 30.w,
            //                         maxHeight: 30.h,
            //                         minHeight: 25.h,
            //                         minWidth: 25.w,
            //                       ),
            //                     ),
            //                     style: textStylePrimaryReg16),
            //               ),
            //               GestureDetector(
            //                   onTap: () => Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) =>
            //                               KorzinaScreen.screen())),
            //                   child: SvgPicture.asset(
            //                       'assets/icons/ic_shopping_cart.svg')),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: RefreshIndicator(
            //           onRefresh: _handleRefresh,
            //           color: primaryColor,
            //           child: ListView.builder(
            //               controller: controller,
            //               shrinkWrap: true,
            //               primary: false,
            //               padding: EdgeInsets.only(top: 25.h),
            //               physics: const BouncingScrollPhysics(),
            //               itemCount: state.list.length + 1,
            //               itemBuilder: (context, index) {
            //                 if (index < state.list.length) {
            //                   return ProductItemsWidget(
            //                     blok: int.parse(state.list[index].blok ?? '0'),
            //                     id: state.list[index].id ?? 0,
            //                     brandNomi:
            //                         state.list[index].currencyName ?? ' ',
            //                     image: state.list[index].image ??
            //                         'https://via.placeholder.com/640x480.png/004455?text=minus',
            //                     title: state.list[index].name ?? 'hhhh',
            //                     count: state.list[index].size ?? "0",
            //                     price:
            //                         num.parse(state.list[index].price ?? '0'),
            //                     category:
            //                         state.list[index].category ?? 'category',
            //
            //                     ///TODO: CLDPCLD
            //                     currencyId: state.list[index].currencyId!,
            //                     currencyName: state.list[index].currencyName,
            //                     residue: state.list[index].residue != null
            //                         ? int.parse(state.list[index].residue ?? '')
            //                         : 0,
            //                     size: state.list[index].size ?? "0",
            //                   );
            //                 } else {
            //                   return const Padding(
            //                     padding: EdgeInsets.symmetric(vertical: 32),
            //                     child:
            //                         Center(child: CupertinoActivityIndicator()),
            //                   );
            //                 }
            //               }),
            //         ),
            //       ),
            //     ],
            //   );
            // }
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
                                (BlocProvider.of<BrandsProductsBloc>(context)
                                        .state as BrandsProductsSuccessState)
                                    .list
                                    .clear();
                                _brandBloc.add(GetBrandsProductsEvent(
                                    page: 1,
                                    name: textEditingController.text,
                                    priceTypeId: gpriceId,
                                    brandId: gbrandId,
                                    salesAgentId: int.parse(sharedPreferences
                                            .getString(sharedSalesAgentId) ??
                                        '')));
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
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KorzinaScreen.screen())),
                            child: SvgPicture.asset(
                                'assets/icons/ic_shopping_cart.svg')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    color: primaryColor,
                    child: ListView.builder(
                        controller: controller,
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(top: 25.h),
                        physics: const BouncingScrollPhysics(),
                        itemCount: currentList.length + (isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < currentList.length) {
                            return ProductItemsWidget(
                              blok: int.parse(currentList[index].blok ?? '0'),
                              id: currentList[index].id ?? 0,
                              brandNomi: currentList[index].currencyName ?? ' ',
                              image: currentList[index].image ??
                                  'https://via.placeholder.com/640x480.png/004455?text=minus',
                              title: currentList[index].name ?? 'hhhh',
                              count: currentList[index].size ?? "0",
                              price: num.parse(currentList[index].price ?? '0'),
                              category:
                                  currentList[index].category ?? 'category',

                              ///TODO: CLDPCLD
                              currencyId: currentList[index].currencyId!,
                              currencyName: currentList[index].currencyName,
                              residue: currentList[index].residue ?? 0,
                              size: currentList[index].size ?? "0",
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            );
                          }
                        }),
                  ),
                ),
              ],
            );
            // return Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.r),
            //     color: cWhiteColor,
            //     boxShadow: [textFieldShadow],
            //   ),
            //   height: 65.h,
            //   padding: EdgeInsets.fromLTRB(13.w, 2.h, 13.w, 0.h),
            //   child: Center(
            //     child: Row(
            //       children: [
            //         SvgPicture.asset(
            //           'assets/icons/ic_search.svg',
            //           width: 24.w,
            //           height: 24.h,
            //           color: primaryColor,
            //         ),
            //         SizedBox(width: 12.w),
            //         Expanded(
            //           child: TextFormField(
            //               onChanged: (value) {
            //                 _brandBloc.add(GetSearchProductEvent(txt: value));
            //               },
            //               textAlignVertical: TextAlignVertical.top,
            //               cursorColor: primaryColor,
            //               controller: textEditingController,
            //               decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 contentPadding: const EdgeInsets.only(bottom: 0),
            //                 hintText: "Qidirish",
            //                 hintStyle: textStyleHintColorReg14,
            //                 prefixIconConstraints: BoxConstraints(
            //                   maxWidth: 30.w,
            //                   maxHeight: 30.h,
            //                   minHeight: 25.h,
            //                   minWidth: 25.w,
            //                 ),
            //               ),
            //               style: textStylePrimaryReg16),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
