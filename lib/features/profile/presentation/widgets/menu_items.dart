import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_constants.dart';
class MenuItems extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const MenuItems({
    Key? key,
    required this.title,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.h,
      width: 156.w,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 38.w,
              height: 38.h,
              color: cWhiteColor,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                  color: cWhiteColor, fontFamily: 'Regular', fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }
}
