
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/products.dart';

class AccountItemWidget extends StatelessWidget {
  final String title, image, brandName;

  const AccountItemWidget({
    required this.title,
    required this.brandName,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
              width: 71.w,
              height: 71.h,
              child: Image.asset(image,
                  fit: BoxFit.fill,
                  // width: 40.w,
                  // color: const Color(0xffBFC3FA),
                  // height: 40.h,
              ),
              decoration: BoxDecoration(
                  color: cImageB2Color,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            SizedBox(width: 4.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brandName,
                  style: TextStyle(
                      fontSize: 18.sp, fontFamily: 'Medium', color: primaryColor),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12.sp, fontFamily: 'Medium', color: cHintTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
