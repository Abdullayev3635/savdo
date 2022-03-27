import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/bloc/product_items_cubit.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../firmalar/presentation/bloc/firma_cubit.dart';
class ProductItemsTextFieldWidget extends StatefulWidget {
  const ProductItemsTextFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  State<ProductItemsTextFieldWidget> createState() => _ProductItemsTextFieldWidgetState();
}

class _ProductItemsTextFieldWidgetState extends State<ProductItemsTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: cWhiteColor,
        boxShadow: [textFieldShadow],
      ),
      height: 65.h,
      margin: EdgeInsets.only(top: 27.h),
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
                  // BlocProvider.of<ProductItemsCubit>(context)
                  //     .searchMaxsulot(value);
                  setState(() {});
                },
                textAlignVertical: TextAlignVertical.top,
                cursorColor:primaryColor,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  hintText: "Qidirish",
                  hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: cHintTextColor,
                      fontFamily: "Regular"),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: 30.w,
                    maxHeight: 30.h,
                    minHeight: 25.h,
                    minWidth: 25.w,
                  ),
                ),
                style: TextStyle(
                    fontSize: 16.sp, color: primaryColor, fontFamily: "Regular"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
