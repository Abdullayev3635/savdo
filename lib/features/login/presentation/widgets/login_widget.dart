import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../main/presentation/pages/main_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
    required this.maskFormatter,
    required this.tel,
    required this.password,
  }) : super(key: key);

  final MaskTextInputFormatter maskFormatter;
  final TextEditingController tel;
  final TextEditingController password;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cWhiteColor),
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: 380.h,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/imsoft_logo.svg'),
          const SizedBox(height: 42),
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
                      inputFormatters: [widget.maskFormatter],
                      keyboardType: TextInputType.phone,
                      cursorColor: primaryColor,
                      controller: widget.tel,
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
          const SizedBox(height: 16),
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
                  SvgPicture.asset('assets/icons/ic_lock.svg',
                      width: 24.w, height: 24.h, color: primaryColor),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextFormField(
                      obscuringCharacter: '•',
                      obscureText: isVisible,
                      cursorColor: primaryColor,
                      controller: widget.password,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Parol",
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
                  IconButton(
                    icon: isVisible
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
                        isVisible = !isVisible;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  )),
              style: buttonStyle,
              child: Text(
                'Kirish',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: cWhiteColor, fontFamily: 'Regular', fontSize: 16.sp),
              )),
        ],
      ),
    );
  }
}
