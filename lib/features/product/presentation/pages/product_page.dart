import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../di/dependency_injection.dart';
import '../bloc/brand/brand_bloc.dart';
import '../bloc/catalog/catalog_bloc.dart';
import '../widgets/catalog_items.dart';
import '../widgets/product_items_widget.dart';
import '../widgets/text_field_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  static Widget screen() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di<CatalogBloc>()..add(GetCategory()),
          ),
          BlocProvider(create: (context) => di<BrandBloc>()),
        ],
        child: const ProductPage(),
      );

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController controller = TextEditingController();

  late CatalogBloc _catalogBloc;
  late BrandBloc _brandBloc;

  @override
  void initState() {
    super.initState();
    _catalogBloc = BlocProvider.of<CatalogBloc>(context);
    _brandBloc = BlocProvider.of<BrandBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _catalogBloc.close();
    _brandBloc.close();
  }

  bool isLarge = false;
  final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKEy,
          backgroundColor: cBackgroundColor,
          body: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
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
                              top: 50.h, left: 10.w, bottom: 50.h),
                          child: const ProductTextFieldWidget(),
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
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
                            'Bo’limlar',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontFamily: 'Medium'),
                          ),
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              setState(() {
                                isLarge = !isLarge;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                        isLarge ? 330.h : 90.h,
                      ),
                      child: BlocBuilder<CatalogBloc, CatalogState>(
                        builder: (context, state) {
                          if (state is CatalogLoadingState) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (state is CatalogSuccessState) {
                            _brandBloc.add(
                              GetBrandEvent(
                                productTypeId: state.list[0].id ?? 0,
                                priceTypeId: 0,
                              ),
                            );
                            return Container(
                              margin: EdgeInsets.only(right: isLarge ? 10 : 0),
                              height: isLarge ? 320 : 100,
                              child: CatalogItems(state: state),
                            );
                          } else if (state is CatalogFailureState) {
                            return Center(child: Text(state.message));
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocBuilder<BrandBloc, BrandState>(
                      builder: (context, state) {
                        if (state is BrandSuccessState) {
                          return ProductWidget(
                            state: state,
                          );
                        } else if (state is BrandLoadingState) {
                          return SizedBox(height:120.h,child: const Center(child: CupertinoActivityIndicator()));
                        } else if (state is BrandFailureState) {
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
              );
            },
          ),
        ),
      ),
    );
  }
}
