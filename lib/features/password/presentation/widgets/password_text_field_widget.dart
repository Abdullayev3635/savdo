// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  PasswordTextFieldWidget({
    Key? key,
    required this.controller,
    required this.visible,
    required this.prefix,
    required this.inputFormatter,
    required this.hintTextTitle,
  }) : super(key: key);
  MaskTextInputFormatter inputFormatter;
  bool visible;
  bool prefix;
  TextEditingController controller;
  String hintTextTitle;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: cTextFieldColor,
      ),
      height: 60.h,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
      child: Center(
        child: Row(
          children: [
            widget.prefix
                ? SvgPicture.asset('assets/icons/ic_lock.svg',
                width: 24.w, height: 24.h, color: primaryColor)
                : Container(),
            widget.prefix ? SizedBox(width: 16.w) : Container(),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [widget.inputFormatter],
                obscuringCharacter: '•',
                obscureText: widget.visible,
                cursorColor: primaryColor,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintTextTitle,
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
                style: textStylePrimaryReg16,
              ),
            ),
            IconButton(
              highlightColor: Colors.transparent,
              icon: widget.visible
                  ? SvgPicture.asset(
                'assets/icons/ic_eye_slash.svg',
                width: 16.w,
                height: 16.h,
              )
                  : SvgPicture.asset(
                'assets/icons/ic_eye.svg',
                width: 16.w,
                height: 16.h,
              ),
              onPressed: () {
                setState(() {
                  widget.visible = !widget.visible;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
