import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_constants.dart';



class CallButtonWidget extends StatelessWidget {
  const CallButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cWhiteColor),
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          SizedBox(height: 31.h),
          AutoSizeText(
            '''Agar ushbu firma dasturidan ro’yxatdan\no’tmagan bo’lsangiz,iltimos biz bilan bog’laning va ro’yxatdan o’ting!''',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xff4F4F4F),
                fontSize: 12.sp,
                fontFamily: 'Regular'),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
              onPressed: () { },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(352.w, 65.h)),
                  backgroundColor:
                  MaterialStateProperty.all(primaryColor),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/call.svg',
                    height: 20.h,
                    width: 20.w,
                    color: cWhiteColor,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Biz bilan bog’lanish',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: cWhiteColor,
                        fontFamily: 'Regular',
                        fontSize: 16.sp),
                  ),
                ],
              )),
          SizedBox(height: 19.h),
        ],
      ),
    );
  }
}

