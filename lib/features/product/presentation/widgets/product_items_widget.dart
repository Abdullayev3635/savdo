import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/products.dart';

import '../bloc/brand/brand_bloc.dart';

class ProductWidget extends StatelessWidget {
  final BrandSuccessState state;

  const ProductWidget({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: state.list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Products.screen(state.list[index].name ?? ""),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: cWhiteColor),
              margin: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(13.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
                    width: 71.w,
                    height: 71.h,
                    child: Image.network(state.list[index].name!,
                        fit: BoxFit.scaleDown,
                        width: 40.w,
                        color: const Color(0xffBFC3FA),
                        height: 40.h),
                    decoration: BoxDecoration(
                        color: cImageB2Color,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                      child: Text(
                    state.list[index].name ?? "",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Medium',
                        color: cGrayColor),
                  )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 31.w, vertical: 38.h),
                    child: Text("${state.list[index].count ?? 0}",
                        style: textStylePrimaryReg16),
                  )
                ],
              ),
            ),
          );
        });
  }
}
