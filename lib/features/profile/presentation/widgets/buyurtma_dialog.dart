import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../core/widgets/dialog_frame.dart';

class BuyurtmaDialog extends StatefulWidget {
  const BuyurtmaDialog({Key? key}) : super(key: key);

  @override
  _BuyurtmaDialogState createState() => _BuyurtmaDialogState();
}

class _BuyurtmaDialogState extends State<BuyurtmaDialog> {
  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Buyurtma',
      icon: 'assets/icons/shopping-cart.svg',
      children: [
        SizedBox(
          height: 23.h,
        ),
        Container(
          height: 60.h,
          padding: EdgeInsets.only(left: 18.w, right: 10.w),
          decoration: BoxDecoration(
              color: cTextFieldColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Mijozni tanlang',
                  style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'Medium',
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SvgPicture.asset('assets/icons/drop icon.svg')
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: 7.w, top: 22.h, left: 7.w, bottom: 34.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Qarzdorligi:',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16.sp,
                      fontFamily: 'Medium'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '-  1 000 000 so’m',
                    style: TextStyle(
                        color: const Color(0xffFC5833),
                        fontSize: 18.sp,
                        fontFamily: 'Regular'),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    '-  100 \$',
                    style: TextStyle(
                        color: const Color(0xffFC5833),
                        fontSize: 18.sp,
                        fontFamily: 'Regular'),
                  ),
                ],
              ),
            ],
          ),
        ),
        SvgPicture.asset('assets/icons/divider.svg'),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Kurs:',
              style: TextStyle(
                  fontFamily: 'Medium', fontSize: 16.sp, color: primaryColor)),
          TextSpan(
              text: '10650 so’m',
              style: TextStyle(
                  fontFamily: 'Regular', fontSize: 18.sp, color: primaryColor)),
        ]))
      ],
    );
  }
}
