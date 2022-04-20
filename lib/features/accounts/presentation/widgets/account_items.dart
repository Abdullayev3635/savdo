
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

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
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: (){  },
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(image,
                    fit: BoxFit.fill,
                ),
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
