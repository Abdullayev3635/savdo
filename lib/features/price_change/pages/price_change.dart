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

import '../../../../../core/network/network_info.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/appBarWidget.dart';
import '../../product/data/model/brand_product_model.dart';
import '../../product/data/model/product_model_new.dart';
import '../../product_items/presentation/bloc/brand_products/brands_products_bloc.dart';
import '../../product_items/presentation/widgets/product_items.dart';
import '../widgets/product_items_price_change.dart';

String bName = '';
int? gpriceId;
int? gbrandId;

class PriceChangePage extends StatefulWidget {
  const PriceChangePage({Key? key}) : super(key: key);

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
        ..add(
          GetBrandsProductsEventNew(
              page: 1,
              name: '',
              priceTypeId: priceTypeId,
              brandId: brandId,
              salesAgentId: salesAgentId,
              turi: "100"),
        ),
      child: const PriceChangePage(),
    );
  }

  @override
  State<PriceChangePage> createState() => _PriceChangePageState();
}

class _PriceChangePageState extends State<PriceChangePage> {
  TextEditingController textEditingController = TextEditingController();
  NetworkInfo networkInfo = di.get();
  int page = 1;
  int allPages = 0;
  late BrandsProductsBloc _brandBloc;
  List<ProductsNew> currentList = [];

  // var succesState;

  @override
  void initState() {
    super.initState();
    _brandBloc = BlocProvider.of<BrandsProductsBloc>(context);
    // succesState = BlocProvider.of<BrandsProductsBloc>(context).state;

  }

  @override
  void dispose() {
    super.dispose();
    _brandBloc.close();
    textEditingController.dispose();
  }


  SharedPreferences sharedPreferences = di.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  _brandBloc.add(GetBrandsProductsEventNew(
                      page: page,
                      name: textEditingController.text,
                      priceTypeId: gpriceId,
                      brandId: gbrandId,
                      salesAgentId: int.parse(
                          sharedPreferences.getString(sharedSalesAgentId) ??
                              ''),
                      turi: "100"));
                  Navigator.pop(context);
                } else {
                  CustomToast.showToast('Internet bilan aloqani tekshiring!');
                }
              });
            } else if (state is BrandsProductsFailureState) {
              return Center(child: Text(state.message));
            } else if (state is BrandsProductsLoadingState) {
              currentList = state.oldProductsListNew;
              isLoading = true;
            } else if (state is BrandsProductsSuccessState) {
              currentList = state.listNew;
            }
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
                                _brandBloc.add(
                                  GetBrandsProductsEventFilter(
                                      name: textEditingController.text,),
                                );
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.only(top: 25.h),
                      physics: const BouncingScrollPhysics(),
                      itemCount: currentList.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < currentList.length) {
                          return ProductItemsPriceWidget(
                            blok: 0,
                            id: currentList[index].id ?? 0,
                            brandNomi: '',
                            priceList: currentList[index].priceList ?? [],
                            image: currentList[index].image ??
                                'https://via.placeholder.com/640x480.png/004455?text=minus',
                            title: currentList[index].name ?? 'hhhh',
                            count: "0",
                            price: 0,
                            category:
                                currentList[index].brandName ?? 'category',

                            ///TODO: CLDPCLD
                            currencyId: currentList[index].currencyId!,
                            currencyName: currentList[index].currencyName,
                            residue: 0,
                            size: "0",
                            incomePrice:  currentList[index].incomePrice??"0",
                            productsNew:  currentList[index],
                            brandBloc:  _brandBloc,
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
              ],
            );
          },
        ),
      ),
    );
  }
}
