import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

class ProductItemsWidget extends StatelessWidget {
  final String title, image, count;

  const ProductItemsWidget({
    required this.title,
    required this.count,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), color: cWhiteColor),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            height: 125.h,
            width: 120.w,
            margin: const EdgeInsets.all(22),
            padding: const EdgeInsets.all(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: cBackgroundColor,
            ),
            child: SizedBox(
              child: SvgPicture.asset(
                "assets/icons/ic_gallery.svg",

              ),
            ),
          ),
        ],
      ),
    );
  }
}
