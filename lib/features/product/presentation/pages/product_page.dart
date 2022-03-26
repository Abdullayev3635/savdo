import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product/presentation/bloc/catalog_bloc.dart';

import '../../../../di/dependency_injection.dart';
import '../../../firmalar/presentation/widgets/text_field_widget.dart';
import '../widgets/catalog_items.dart';
import '../widgets/product_items_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<CatalogBloc>()..add(GetCatalog()),
        child: const ProductPage(),
      );

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController controller = TextEditingController();


  // late CatalogBloc _catalogBloc;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _catalogBloc = BlocProvider.of<CatalogBloc>(context);
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   _catalogBloc.close();
  // }
  bool isLarge = false;
  final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKEy,
      backgroundColor: cBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: isLarge ? 490 : 270,
            elevation: 0,
            backgroundColor: cBackgroundColor,
            automaticallyImplyLeading: false,
            toolbarHeight: isLarge ? 390 : 180.h,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              centerTitle: true,
              background: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 50.h, right: 20.w, left: 20.w, bottom: 21.h),
                    child: TextFieldWidget(controller: controller),
                  ),
                ],
              ),
              title:
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.w),
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
                          onTap: () {
                            setState(() {
                              isLarge = !isLarge;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  Container(
                    margin: EdgeInsets.only(top: 12.h,right: isLarge ? 10:0),
                    height: isLarge ? 320 : 100,
                    child: CatalogItems(isLarge: isLarge),
                  ),
                ],
              ),
              //     BlocBuilder<CatalogBloc, CatalogState>(
              //   builder: (context, state) {
              //     if (state is ProductFailureState) {
              //       CustomToast.showToast('text');
              //     }
              //     if (state is ProductLoadingState) {
              //       const Center(
              //           child: CupertinoActivityIndicator(
              //         key: ValueKey('value'),
              //       ));
              //     } else if (state is ProductInitialState) {
              //       const Center(
              //           child: CupertinoActivityIndicator(
              //         key: ValueKey('v'),
              //       ));
              //     } else if (state is ProductSuccessState) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 21.w),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Bo’limlar',
              //                   style: TextStyle(
              //                       color: primaryColor,
              //                       fontSize: 14.sp,
              //                       fontFamily: 'Medium'),
              //                 ),
              //                 Row(
              //                   children: [
              //                     Text(
              //                       'Barchasi ',
              //                       style: TextStyle(
              //                           decoration: TextDecoration.underline,
              //                           color: cHintTextColor,
              //                           fontSize: 10.sp,
              //                           fontFamily: 'Medium'),
              //                     ),
              //                     SvgPicture.asset(
              //                         'assets/icons/ic_arrow_right.svg',
              //                         width: 3.w,
              //                         color: cHintTextColor)
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(top: 12.h),
              //             height: 100,
              //             child: CatalogItems(isLarge: isLarge,),
              //           ),
              //         ],
              //       );
              //     }
              //     return Container();
              //   },
              // ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                primary: false,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ProductItemsWidget(
                    image: 'assets/icons/ic_gallery.svg',
                    title: 'Liqui Moly',
                    count: '40',
                  );
                }),
          )
        ],
      ),
    );
  }
}
