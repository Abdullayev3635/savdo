import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../core/widgets/dialog_frame.dart';

class TulovQilishDialog extends StatefulWidget {
  const TulovQilishDialog({Key? key}) : super(key: key);

  @override
  _TulovQilishDialogState createState() => _TulovQilishDialogState();
}

class _TulovQilishDialogState extends State<TulovQilishDialog> {
  String group1 = '', group2 = '';

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'To’lov qilish',
      icon: 'assets/icons/ic_dollar_circle.svg',
      children: [
        SizedBox(height: 23.h),
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
                      fontSize: 14.sp),
                ),
              ),
              SvgPicture.asset('assets/icons/ic_dropdown.svg')
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: 7.w, top: 22.h, left: 7.w, bottom: 34.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: cOrangeColor,
                        fontSize: 18.sp,
                        fontFamily: 'Regular'),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    '-  100 \$',
                    style: TextStyle(
                        color: cOrangeColor,
                        fontSize: 18.sp,
                        fontFamily: 'Regular'),
                  ),
                ],
              ),
            ],
          ),
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
                  'To’lov turi',
                  style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'Medium',
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SvgPicture.asset('assets/icons/ic_dropdown.svg')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: cTextFieldColor,
          ),
          height: 60.h,
          margin: EdgeInsets.only(top: 16.h),
          padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
          child: Center(
            child: Row(
              children: [
                SizedBox(width: 5.w),
                Expanded(
                  child: TextFormField(
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Summani kiriting",
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: cHintTextColor,
                          fontFamily: "Regular"),
                    ),
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: primaryColor,
                        fontFamily: "Regular"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16.h),
          padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: cTextFieldColor,
                ),
                height: 60.h,
                width: MediaQuery.of(context).size.width / 2.5,
                // margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 130.w,
                        child: TextFormField(
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Summa so’m",
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: cHintTextColor,
                                fontFamily: "Regular"),
                          ),
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: primaryColor,
                              fontFamily: "Regular"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: cTextFieldColor,
                ),
                height: 60.h,
                width: MediaQuery.of(context).size.width / 2.5,
                padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 5.w),
                    SizedBox(
                      width: 130.w,
                      child: TextFormField(
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Summa valyuta",
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: cHintTextColor,
                              fontFamily: "Regular"),
                        ),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: primaryColor,
                            fontFamily: "Regular"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: cTextFieldColor,
          ),
          height: 60.h,
          margin: EdgeInsets.only(top: 16.h),
          padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
          child: Center(
            child: Row(
              children: [
                SizedBox(width: 5.w),
                Expanded(
                  child: TextFormField(
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Izoh",
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: cHintTextColor,
                          fontFamily: "Regular"),
                    ),
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: primaryColor,
                        fontFamily: "Regular"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        ElevatedButton(
            onPressed: () {},
            style: buttonStyle,
            child: const Text(
              'Davom etish',
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
