import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/core/widgets/failure_dialog.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/brand_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../di/dependency_injection.dart';
import '../bloc/brand/brand_bloc.dart';
import '../bloc/catalog/category_bloc.dart';
import '../widgets/catalog_items.dart';
import '../widgets/category_shimmer_widget.dart';
import '../widgets/product_items_shimmer_widget.dart';
import '../widgets/product_items_widget.dart';
import '../widgets/text_field_widget.dart';

class ClientProductPage extends StatefulWidget {
  const ClientProductPage({Key? key}) : super(key: key);
  // final int customerId = 0;

  // final int salesAgentId = 0;

  static Widget screen(
    // required int customerId,
    // required int salesAgentId,
  ) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di<ClientCatalogBloc>()..add(GetClientCategory()),
          ),
          BlocProvider(
              create: (context) => di<ClientBrandBloc>()..add(BrandInitialEvent())),
        ],
        child: const ClientProductPage(),
      );

  @override
  _ClientProductPageState createState() => _ClientProductPageState();
}

class _ClientProductPageState extends State<ClientProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  NetworkInfo networkInfo = di.get();
  late ClientCatalogBloc _catalogBloc;
  late ClientBrandBloc _brandBloc;

  @override
  void initState() {
    super.initState();
    _catalogBloc = BlocProvider.of<ClientCatalogBloc>(context);
    _brandBloc = BlocProvider.of<ClientBrandBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _catalogBloc.close();
    _brandBloc.close();
  }

  Future _handleRefresh() async {
    return _catalogBloc.add(GetClientCategory());
  }

  SharedPreferences sharedPreferences = di.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKEy,
          backgroundColor: cBackgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CupertinoSliverRefreshControl(onRefresh: _handleRefresh),
              SliverAppBar(
                elevation: 0,
                backgroundColor: cBackgroundColor,
                automaticallyImplyLeading: false,
                toolbarHeight: 90,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 50.h, left: 10.w, bottom: 50.h, right: 10.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Products.screen(
                                      brandName: "Brend nomi",
                                      salesAgentId: int.parse(
                                        sharedPreferences.getString(
                                                sharedSalesAgentId) ??
                                            '',
                                      ),
                                      brandId: -1,
                                      priceTypeId: -1),
                                ));
                          },
                          child: const ProductTextFieldWidget()),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ClientCatalogBloc, ClientCatalogState>(
                builder: (context, state) {
                  if (state is CatalogLoadingState) {
                    return const SliverToBoxAdapter(
                      child: CategoryItemsShimmerWidget(),
                    );
                  } else if (state is ClientCatalogSuccessState) {
                    _brandBloc.add(
                      GetClientBrandEvent(
                        productTypeId: state.list[state.selected].id ?? 0,
                        priceTypeId: state.selected,
                      ),
                    );
                    return SliverAppBar(
                      elevation: 0,
                      backgroundColor: cBackgroundColor,
                      automaticallyImplyLeading: false,
                      floating: false,
                      pinned: true,
                      title: Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${state.list[state.selected].name![0].toUpperCase()}${state.list[state.selected].name!.substring(1)}',
                                style: textStylePrimaryMed14),
                            InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () async {
                                _catalogBloc.add(
                                  ClientChangeColor(state.list, state.selected,
                                      state.count, state.isLarge),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Barchasi ',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: cHintTextColor,
                                          fontSize: 10.sp,
                                          fontFamily: 'Medium'),
                                    ),
                                    SvgPicture.asset(
                                        'assets/icons/ic_arrow_right.svg',
                                        width: 3.w,
                                        color: cHintTextColor)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size(
                          double.infinity,
                          state.isLarge ? 350.h : 90.h,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.only(right: state.isLarge ? 10 : 0),
                          height: state.isLarge ? 320 : 100,
                          child: CatalogItems(state: state, bloc: _catalogBloc),
                        ),
                      ),
                    );
                  } else if (state is ClientBrandNoInternetState) {
                    return SliverToBoxAdapter(
                      child: ShowFailureDialog(onTap: () async {
                        if (await networkInfo.isConnected) {
                          _catalogBloc.add(GetClientCategory());
                          Navigator.pop(context);
                        } else {
                          CustomToast.showToast(
                              'Internet bilan aloqani tekshiring!');
                        }
                      }),
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<ClientBrandBloc, ClientBrandState>(
                  builder: (context, state) {
                    if (state is ClientBrandSuccessState) {
                      if (state.list.isNotEmpty) {
                        return ClientProductWidget(state: state);
                      } else {
                        return const Center(
                          child: Text(
                            'Maxsulotlar yo`q ekan',
                            style: TextStyle(),
                          ),
                        );
                      }
                    } else if (state is ClientBrandInitial) {
                      return const ProductItemsShimmerWidget();
                    } else if (state is ClientBrandLoadingState) {
                      return const ProductItemsShimmerWidget();
                    } else if (state is ClientBrandFailureState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
