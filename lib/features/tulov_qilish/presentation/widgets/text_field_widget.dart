import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../core/utils/app_constants.dart';

// ignore: must_be_immutable
class TextFieldHintWidget extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextInputType keyboardType;
  bool? readOnly;

  TextFieldHintWidget({
    Key? key,
    required this.controller,
    this.readOnly,
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
                readOnly: readOnly ?? false,
                inputFormatters: [
                  keyboardType == TextInputType.number
                      ? ThousandsFormatter(allowFraction: true)
                      : MaskTextInputFormatter()
                ],
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
