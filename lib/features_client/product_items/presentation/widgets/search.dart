// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:savdo_agnet_client/features/product_items/presentation/bloc/brand_products/brands_products_bloc.dart';
//
// import '../../../../core/utils/app_constants.dart';
//
// class ProductItemsTextFieldWidget extends StatefulWidget {
//   ProductItemsTextFieldWidget({
//     Key? key,
//     required this.controller,
//     required this.bloc,
//   }) : super(key: key);
//
//   final TextEditingController? controller;
//   late BrandsProductsBloc bloc;
//
//   @override
//   State<ProductItemsTextFieldWidget> createState() =>
//       _ProductItemsTextFieldWidgetState();
// }
//
// class _ProductItemsTextFieldWidgetState
//     extends State<ProductItemsTextFieldWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.r),
//         color: cWhiteColor,
//         boxShadow: [textFieldShadow],
//       ),
//       height: 65.h,
//       // margin: EdgeInsets.only(top: 27.h),
//       padding: EdgeInsets.fromLTRB(13.w, 2.h, 13.w, 0.h),
//       child: Center(
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               'assets/icons/ic_search.svg',
//               width: 24.w,
//               height: 24.h,
//               color: primaryColor,
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: TextFormField(
//                   onChanged: (value) {
//                     widget.bloc.add(GetSearchProductEvent(txt: value));
//                     setState(() {});
//                   },
//                   textAlignVertical: TextAlignVertical.top,
//                   cursorColor: primaryColor,
//                   controller: widget.controller,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.only(bottom: 0),
//                     hintText: "Qidirish",
//                     hintStyle: textStyleHintColorReg14,
//                     prefixIconConstraints: BoxConstraints(
//                       maxWidth: 30.w,
//                       maxHeight: 30.h,
//                       minHeight: 25.h,
//                       minWidth: 25.w,
//                     ),
//                   ),
//                   style: textStylePrimaryReg16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
