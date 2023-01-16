import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/features/login/presentation/bloc/login_bloc.dart';
import 'package:savdo_agnet_client/features/main/presentation/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../../di/dependency_injection.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
    required this.maskFormatter,
    required this.tel,
    required this.password,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  final MaskTextInputFormatter maskFormatter;
  final TextEditingController tel;
  final TextEditingController password;
  final LoginBloc bloc;
  final LoginState state;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isVisible = true;
  SharedPreferences sharedPreferences = di.get();

  @override
  Widget build(BuildContext context) {
    if (widget.state is LoginFailure) {
      CustomToast.showToast('Kiritilgan malumotlar noto\'g\'ri');
    }
    if (widget.state is LoginSuccess) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          ), (route) => false),
        },
      );
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), color: cWhiteColor),
      margin: EdgeInsets.symmetric(horizontal: 28.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      height: 380.h,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/imsoft_logo.svg'),
          SizedBox(height: 42.h),
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
                          color: widget.state is LoginFailure
                              ? cPriceColor
                              : primaryColor,
                          fontFamily: "Regular"),
                    ),
                  ),
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
                          color: widget.state is LoginFailure
                              ? cPriceColor
                              : primaryColor,
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
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              //   builder: (context) {
              //     return const MainPage();
              //   },
              // ), (route) => false);
              widget.bloc.add(SendLoginEvent(
                  widget.maskFormatter.getUnmaskedText(),
                  widget.password.text));
            },
            style: buttonStyle,
            child: widget.state is LoginLoading
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : Text('Kirish',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: cWhiteColor,
                        fontSize: 16.sp,
                        fontFamily: 'Regular')),
          ),
        ],
      ),
    );
  }
}
