// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:savdo_agnet_client/core/utils/app_constants.dart';
// import 'package:savdo_agnet_client/features/product/presentation/bloc/catalog_bloc.dart';
//
// import '../../../../core/widgets/costum_toast.dart';
// import '../../../../di/dependency_injection.dart';
// import '../widgets/product_items_widget.dart';
// import '../widgets/text_field_widget.dart';
//
// class ProductPage extends StatefulWidget {
//   const ProductPage({Key? key}) : super(key: key);
//
//   static Widget screen() => BlocProvider(
//         create: (context) => di<CatalogBloc>()..add(GetCatalog()),
//         child: const ProductPage(),
//       );
//
//   @override
//   _ProductPageState createState() => _ProductPageState();
// }
//
// class _ProductPageState extends State<ProductPage> {
//   TextEditingController controller = TextEditingController();
//
//   late CatalogBloc _catalogBloc;
//   int count = 3;
//
//   @override
//   void initState() {
//     super.initState();
//     _catalogBloc = BlocProvider.of<CatalogBloc>(context);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _catalogBloc.close();
//   }
//
//   bool isLarge = false;
//   final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKEy,
//       backgroundColor: cBackgroundColor,
//       body: BlocBuilder<CatalogBloc, CatalogState>(
//         builder: (context, state) {
//           if (state is ProductFailureState) {
//             CustomToast.showToast("Маълумотлар юкланишда хатолик юз берди!");
//           }
//           if (state is ProductLoadingState) {
//             const Center(
//                 child: CupertinoActivityIndicator(
//               key: ValueKey('value'),
//             ));
//           } else if (state is ProductSuccessState) {
//             return CustomScrollView(
//               physics: const BouncingScrollPhysics(),
//               slivers: [
//                 SliverAppBar(
//                   expandedHeight: state.isLarge ? 490.h : 270.h,
//                   elevation: 0,
//                   backgroundColor: cBackgroundColor,
//                   automaticallyImplyLeading: false,
//                   toolbarHeight: state.isLarge ? 390.h : 180.h,
//                   floating: false,
//                   pinned: true,
//                   flexibleSpace: FlexibleSpaceBar(
//                     expandedTitleScale: 1,
//                     centerTitle: true,
//                     background: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: 50.h, right: 20.w, left: 20.w, bottom: 50.h),
//                           child: const ProductTextFieldWidget(),
//                         ),
//                       ],
//                     ),
//                     titlePadding: EdgeInsets.only(top: 10.h),
//                     title: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 21.w),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Bo’limlar',
//                                 style: TextStyle(
//                                     color: primaryColor,
//                                     fontSize: 14.sp,
//                                     fontFamily: 'Medium'),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   _catalogBloc.add(ChangeColor(state.list, 0,
//                                       state.count, !state.isLarge));
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         'Barchasi ',
//                                         style: TextStyle(
//                                             decoration:
//                                                 TextDecoration.underline,
//                                             color: cHintTextColor,
//                                             fontSize: 10.sp,
//                                             fontFamily: 'Medium'),
//                                       ),
//                                       SvgPicture.asset(
//                                           'assets/icons/ic_arrow_right.svg',
//                                           width: 3.w,
//                                           color: cHintTextColor)
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: 12.h, right: state.isLarge ? 10 : 0),
//                           height: state.isLarge ? 320 : 100,
//                           child: GridView.builder(
//                             itemCount: 50,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: state.isLarge ? 4 : 1,
//                               mainAxisExtent: 90.w,
//                               crossAxisSpacing: 10.h,
//                               childAspectRatio: 1 / 1,
//                               mainAxisSpacing: state.isLarge ? 20.w : 0,
//                             ),
//                             physics: const BouncingScrollPhysics(),
//                             padding: EdgeInsets.only(
//                                 left: state.isLarge ? 3.w : 11.w, top: 5),
//                             scrollDirection:
//                                 state.isLarge ? Axis.vertical : Axis.horizontal,
//                             itemBuilder: (context, index) => Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 10.w),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   _catalogBloc.add(ChangeColor(state.list,
//                                       index, state.count, !state.isLarge));
//                                 },
//                                 child: SizedBox(
//                                   width: 89.w,
//                                   height: state.isLarge ? 380 : 91.h,
//                                   child: Stack(
//                                     clipBehavior: Clip.none,
//                                     alignment: Alignment.topRight,
//                                     children: [
//                                       Column(
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(15.r),
//                                             child: ShaderMask(
//                                                 shaderCallback: (Rect bounds) {
//                                                   return LinearGradient(
//                                                       stops: const [
//                                                         0.0,
//                                                         0.0
//                                                       ],
//                                                       colors: [
//                                                         Colors.transparent,
//                                                         state.isLarge
//                                                             ? primaryColor07
//                                                             : Colors.transparent
//                                                       ]).createShader(bounds);
//                                                 },
//                                                 blendMode: BlendMode.srcATop,
//                                                 child: Image.asset(
//                                                     'assets/images/truck.png')),
//                                           ),
//                                           SizedBox(
//                                               height:
//                                                   state.isLarge ? 12.h : 18.h),
//                                           state.isLarge
//                                               ? const Text(
//                                                   'Yuk mashina',
//                                                   style: TextStyle(
//                                                       color: primaryColor,
//                                                       fontFamily: 'Medium',
//                                                       fontSize: 10),
//                                                 )
//                                               : Container(
//                                                   width: 13.w,
//                                                   height: 3.h,
//                                                   decoration: BoxDecoration(
//                                                     color: primaryColor,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             3.5.r),
//                                                   ),
//                                                 )
//                                         ],
//                                       ),
//                                       count == 0
//                                           ? Container()
//                                           : Positioned(
//                                               top: -4,
//                                               right: -5,
//                                               child: Container(
//                                                 width: 18.w,
//                                                 height: 18.h,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color:
//                                                         const Color(0xffEB5757),
//                                                     border: Border.all(
//                                                         width: 3,
//                                                         color: cWhiteColor)),
//                                                 child: Text(
//                                                   '$count',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: cWhiteColor,
//                                                       fontFamily: 'Medium',
//                                                       fontSize: 9.sp),
//                                                 ),
//                                               ),
//                                             ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: ListView.builder(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       primary: false,
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: 10,
//                       itemBuilder: (context, index) {
//                         return const ProductWidget(
//                           image: 'assets/icons/ic_gallery.svg',
//                           title: 'Liqui Moly',
//                           count: '40',
//                         );
//                       }),
//                 )
//               ],
//             );
//           }
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: 50.h, right: 20.w, left: 20.w, bottom: 50.h),
//                 child: const ProductTextFieldWidget(),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
