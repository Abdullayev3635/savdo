import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../core/widgets/dialog_frame.dart';

class EditClientDialog extends StatefulWidget {
  const EditClientDialog({Key? key}) : super(key: key);

  @override
  _EditClientDialogState createState() => _EditClientDialogState();
}

class _EditClientDialogState extends State<EditClientDialog> {
  var maskFormatter = MaskTextInputFormatter(mask: '(##) ###-##-##');
  final TextEditingController tel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Mijoz o’zgartirish',
      icon: 'assets/icons/ic_two_person.svg',
      children: [
        SizedBox(height: 23.h),
        InkWell(
          onTap: () {},
          child: Container(
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
        ),
        SizedBox(height: 16.h),
        InkWell(
          onTap: () {},
          child: Container(
            height: 60.h,
            padding: EdgeInsets.only(left: 18.w, right: 10.w),
            decoration: BoxDecoration(
                color: cTextFieldColor,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Joylashuv qo’shish',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Medium',
                        fontSize: 14.sp),
                  ),
                ),
                SvgPicture.asset('assets/icons/ic_gps.svg')
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: cTextFieldColor,
          ),
          height: 60.h,
          padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
          child: Center(
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/ic_call.svg',
                    width: 24.w, height: 24.h, color: primaryColor),
                SizedBox(width: 16.w),
                Text(
                  '+998',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: cHintTextColor,
                      // color: cGrayColor,
                      fontFamily: "Regular"),
                ),
                Expanded(
                  child: TextFormField(
                    inputFormatters: [maskFormatter],
                    controller: tel,
                    keyboardType: TextInputType.phone,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "(--)--- -- --",
                      hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: cHintTextColor,
                          fontFamily: "Regular"),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 30.w,
                        maxHeight: 30.h,
                        minHeight: 25.h,
                        minWidth: 25.w,
                      ),
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
        SizedBox(height: 16.h),
        ElevatedButton(
            onPressed: () {},
            style: buttonStyle,
            child: const Text(
              'Saqlash',
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
