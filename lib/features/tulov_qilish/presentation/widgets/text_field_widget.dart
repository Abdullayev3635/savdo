import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_constants.dart';

class TextFieldHintWidget extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextInputType keyboardType;

  TextFieldHintWidget({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                controller: controller,
                keyboardType: keyboardType,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: textStyleHintColorReg14,
                ),
                style: textStylePrimaryReg16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
