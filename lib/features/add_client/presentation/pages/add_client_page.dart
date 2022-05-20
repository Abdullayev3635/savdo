import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/select_viloyat/presentation/pages/select_viloyat_dialog.dart';

import '../../../../core/widgets/appBarWidget.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key? key}) : super(key: key);

  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  var maskFormatter = MaskTextInputFormatter(mask: '(##) ###-##-##');
  var maskDateFormatter =
      MaskTextInputFormatter(mask: '##   /   ##   /   ####');
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordVer = TextEditingController();
  int viloyatId = 0;
  String viloyatTitle = 'Viloyatni tanlang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Mijoz qo’shish'),
      backgroundColor: cBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: cWhiteColor,
                    boxShadow: [textFieldShadow]),
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
                            hintText: "Ism Familiya",
                            hintStyle: hintStyle,
                          ),
                          style: textStylePrimaryReg16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: cWhiteColor,
                ),
                height: 60.h,
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_call.svg',
                          width: 24.w, height: 24.h, color: primaryColor),
                      SizedBox(width: 18.w),
                      Text(
                        '+998',
                        style: hintStyle,
                      ),
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [maskFormatter],
                          keyboardType: TextInputType.phone,
                          cursorColor: primaryColor,
                          controller: _tel,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "(--)--- -- --",
                            hintStyle: hintStyle,
                            prefixIconConstraints: boxConstraintsTextField,
                          ),
                          style: textStylePrimaryReg16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tug’ulgan sana',
                      style: textStylePrimaryReg16,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cWhiteColor,
                      ),
                      height: 60.h,
                      width: MediaQuery.of(context).size.width / 1.8,
                      // margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextFormField(
                              inputFormatters: [maskDateFormatter],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kun   /   Oy   /   Yil",
                                hintStyle: hintStyle,
                              ),
                              style: textStylePrimaryReg16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectViloyat.screen();
                      }).then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              viloyatId = value['id'];
                              viloyatTitle = value['title'].toString();
                            })
                          },
                      });
                },
                child: Container(
                  height: 60.h,
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.only(left: 20.w, right: 24.w),
                  decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_hudud.svg',
                          width: 24.w, height: 24.h),
                      SizedBox(
                        width: 18.w,
                      ),
                      Expanded(
                        child: Text(viloyatTitle, style: textStylePrimaryReg16),
                      ),
                      SvgPicture.asset('assets/icons/ic_dropdown.svg')
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: cWhiteColor,
                    boxShadow: [textFieldShadow]),
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
                            hintText: "Manzil",
                            hintStyle: hintStyle,
                          ),
                          style: textStylePrimaryReg16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: cWhiteColor,
                ),
                height: 60.h,
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_lock.svg',
                          width: 24.w, height: 24.h, color: primaryColor),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: TextFormField(
                          cursorColor: primaryColor,
                          controller: _password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Parol",
                            hintStyle: hintStyle,
                            prefixIconConstraints: boxConstraintsTextField,
                          ),
                          style: textStylePrimaryReg16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: cWhiteColor,
                ),
                height: 60.h,
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_lock.svg',
                          width: 24.w, height: 24.h, color: primaryColor),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: TextFormField(
                          cursorColor: primaryColor,
                          controller: _passwordVer,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Parolni tasdiqlang",
                            hintStyle: hintStyle,
                            prefixIconConstraints: boxConstraintsTextField,
                          ),
                          style: textStylePrimaryReg16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: cWhiteColor,
                  ),
                  height: 60.h,
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/ic_gps.svg',
                            width: 24.w, height: 24.h, color: primaryColor),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: TextFormField(
                            cursorColor: primaryColor,
                            controller: _passwordVer,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Joylashuv qo’shish",
                              hintStyle: hintStyle,
                              prefixIconConstraints: boxConstraintsTextField,
                            ),
                            style: textStylePrimaryReg16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Text(
                    'Ro’yxatdan o’tkazish',
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle hintStyle =
      TextStyle(fontSize: 16.sp, color: cHintTextColor, fontFamily: "Regular");
}
