
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/products.dart';

class ProductWidget extends StatelessWidget {
  final String title, image, count;

  const ProductWidget({
    required this.title,
    required this.count,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Products.screen(title),));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: cWhiteColor),
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(13.w),
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
              width: 71.w,
              height: 71.h,
              child: SvgPicture.asset(image,
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
                  title,
                  style: TextStyle(
                      fontSize: 18.sp, fontFamily: 'Medium', color: cGrayColor),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 38.h),
              child: Text(count, style: textStylePrimary16),
            )
          ],
        ),
      ),
    );
  }
}
