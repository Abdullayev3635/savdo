import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';

class SavatchaFailureDialog extends StatefulWidget {
  const SavatchaFailureDialog({Key? key}) : super(key: key);

  @override
  _SavatchaFailureDialogState createState() => _SavatchaFailureDialogState();
}

class _SavatchaFailureDialogState extends State<SavatchaFailureDialog> {
  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Savatcha',
      icon: 'assets/icons/ic_shopping_cart.svg',
      children: [
        SizedBox(height: 31.h),
        SvgPicture.asset('assets/icons/ic_info.svg'),
        Padding(
          padding:
              EdgeInsets.only(top: 18.h, bottom: 31.h, left: 29.w, right: 29.w),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.sp, fontFamily: 'Regular', color: cGrayColor),
          ),
        ),
        SizedBox(
          height: 350.h,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 13.h),
                  height: 96.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: cTextFieldColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOP TEC ATF 1700',
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16.sp,
                                color: cGrayColor),
                          ),
                          Text(
                            '690 000 so’m',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: primaryColor,
                                fontFamily: "Medium"),
                          ),
                          Row(
                            children: [
                              Text(
                                '5  х  6 690 000 so’m',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: cOrange2Color,
                                    fontFamily: "Regular"),
                              ),
                              Text(
                                ' - 3 dona qoldiq',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff969696),
                                    fontFamily: "Regular"),
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/ic_trash.svg'))
                    ],
                  ),
                );
              }),
        ),
        ElevatedButton(
            onPressed: () {},
            style: buttonStyle,
            child: const Text(
              'O’zgartirish',
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}

String description = 'Ushbu mahsulotlar omborda yetmaganligi sababli sotuv amalga oshirilmadi. Iltimos mavjud bo‘lmagan mahsulotlarni o‘chirib qayta buyurtma bering!';