import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/pin_bloc.dart';

class PasswordEditDialog extends StatefulWidget {
  const PasswordEditDialog({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<PinBloc>()..add(IsSharedPinEmpty()),
        child: const PasswordEditDialog(),
      );

  @override
  _PasswordEditDialogState createState() => _PasswordEditDialogState();
}

class _PasswordEditDialogState extends State<PasswordEditDialog> {
  bool isOldVisible = true;
  bool isNewVisible = true;
  bool isConfirmVisible = true;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(mask: '####');
  late PinBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PinBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinBloc, PinState>(
      builder: (context, state) {
        if (state is PinSuccessState) {
          Navigator.pop(context);
        } else if (state is PinConfirmFailureState) {
          CustomToast.showToast(state.message);
        } else if (state is PinIsEmptyState) {
          return AllDialogSkeleton(
            title: 'Parolni o’rnatish(o’zgartirish)',
            icon: 'assets/icons/ic_shield-security.svg',
            children: [
              SizedBox(height: 24.h),
              Visibility(
                visible: state.isEmpty,
                child: Container(
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
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [maskFormatter],
                            obscuringCharacter: '•',
                            obscureText: isOldVisible,
                            cursorColor: primaryColor,
                            controller: oldPassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Eski parolni kiriting",
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
                          highlightColor: Colors.transparent,
                          icon: isOldVisible
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
                              isOldVisible = !isOldVisible;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
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
                      SvgPicture.asset('assets/icons/ic_lock.svg',
                          width: 24.w, height: 24.h, color: primaryColor),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [maskFormatter],
                          obscuringCharacter: '•',
                          obscureText: isNewVisible,
                          cursorColor: primaryColor,
                          controller: newPassword,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Yangi parolni kiriting ",
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
                        highlightColor: Colors.transparent,
                        icon: isNewVisible
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
                            isNewVisible = !isNewVisible;
                          });
                        },
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
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_lock.svg',
                          width: 24.w, height: 24.h, color: primaryColor),
                      SizedBox(width: 16.w),
                      // if (state is ConfirmFailureState)
                      Expanded(
                        child: TextFormField(
                          // autofocus: state.autoFocus,
                          keyboardType: TextInputType.number,
                          inputFormatters: [maskFormatter],
                          obscuringCharacter: '•',
                          obscureText: isConfirmVisible,
                          cursorColor: primaryColor,
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Parolni tasdiqlang",
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
                        highlightColor: Colors.transparent,
                        icon: isConfirmVisible
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
                            isConfirmVisible = !isConfirmVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Qaytish',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Medium',
                            fontSize: 16.sp),
                      ),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(
                            MediaQuery.of(context).size.width / 2.5, 57.h)),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            primaryColor.withOpacity(0.1)),
                        // overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.2)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      )),
                  ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(
                            MediaQuery.of(context).size.width / 2.5, 57.h)),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      bloc.add(OnPressedEvent(
                        newPassword: newPassword,
                        confirmPassword: confirmPassword,
                        oldPassword: oldPassword,
                      ));
                      setState(() {});
                    },
                    child: Text('Saqlash',
                        style: TextStyle(
                            color: cWhiteColor,
                            fontSize: 16.sp,
                            fontFamily: 'Medium')),
                  ),
                ],
              )
            ],
          );
        } return AllDialogSkeleton(
          title: 'Parolni o’rnatish(o’zgartirish)',
          icon: 'assets/icons/ic_shield-security.svg',
          children: [
            SizedBox(height: 24.h),
            Visibility(
              // visible: state.isEmpty,
              child: Container(
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
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [maskFormatter],
                          obscuringCharacter: '•',
                          obscureText: isOldVisible,
                          cursorColor: primaryColor,
                          controller: oldPassword,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Eski parolni kiriting",
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
                        highlightColor: Colors.transparent,
                        icon: isOldVisible
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
                            isOldVisible = !isOldVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
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
                    SvgPicture.asset('assets/icons/ic_lock.svg',
                        width: 24.w, height: 24.h, color: primaryColor),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        obscuringCharacter: '•',
                        obscureText: isNewVisible,
                        cursorColor: primaryColor,
                        controller: newPassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Yangi parolni kiriting ",
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
                      highlightColor: Colors.transparent,
                      icon: isNewVisible
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
                          isNewVisible = !isNewVisible;
                        });
                      },
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
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_lock.svg',
                        width: 24.w, height: 24.h, color: primaryColor),
                    SizedBox(width: 16.w),
                    // if (state is ConfirmFailureState)
                    Expanded(
                      child: TextFormField(
                        // autofocus: state.autoFocus,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        obscuringCharacter: '•',
                        obscureText: isConfirmVisible,
                        cursorColor: primaryColor,
                        controller: confirmPassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Parolni tasdiqlang",
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
                      highlightColor: Colors.transparent,
                      icon: isConfirmVisible
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
                          isConfirmVisible = !isConfirmVisible;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Qaytish',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Medium',
                          fontSize: 16.sp),
                    ),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width / 2.5, 57.h)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          primaryColor.withOpacity(0.1)),
                      // overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.2)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    )),
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width / 2.5, 57.h)),
                      backgroundColor:
                      MaterialStateProperty.all(primaryColor),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    bloc.add(OnPressedEvent(
                      newPassword: newPassword,
                      confirmPassword: confirmPassword,
                      oldPassword: oldPassword,
                    ));
                    setState(() {});
                  },
                  child: Text('Saqlash',
                      style: TextStyle(
                          color: cWhiteColor,
                          fontSize: 16.sp,
                          fontFamily: 'Medium')),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
